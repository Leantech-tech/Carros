const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('../db');

const router = express.Router();

const JWT_SECRET = process.env.JWT_SECRET || 'fallback-secret-change-me';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '7d';

// Middleware para validar token JWT
function authenticateToken(req, res, next) {
  const authHeader = req.headers.authorization;
  const token = authHeader && authHeader.startsWith('Bearer ')
    ? authHeader.split(' ')[1]
    : null;

  if (!token) {
    return res.status(401).json({ error: 'Token não fornecido' });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.userId = decoded.userId;
    next();
  } catch (err) {
    return res.status(401).json({ error: 'Token inválido ou expirado' });
  }
}

// Login
router.post('/login', async (req, res, next) => {
  const { login, password } = req.body;

  if (!login || !password) {
    return res.status(400).json({ error: 'Login e senha são obrigatórios' });
  }

  try {
    const result = await pool.query(
      'SELECT * FROM "usuarios" WHERE "login" = $1 LIMIT 1',
      [login]
    );

    const user = result.rows[0];

    if (!user || !user.is_ativo) {
      return res.status(401).json({ error: 'Credenciais inválidas' });
    }

    const validPassword = await bcrypt.compare(password, user.senha_hash);

    if (!validPassword) {
      return res.status(401).json({ error: 'Credenciais inválidas' });
    }

    // Atualiza último login
    await pool.query(
      'UPDATE "usuarios" SET "ultimo_login" = NOW() WHERE "id" = $1',
      [user.id]
    );

    const token = jwt.sign(
      { userId: user.id, login: user.login },
      JWT_SECRET,
      { expiresIn: JWT_EXPIRES_IN }
    );

    res.json({
      token,
      user: {
        id: user.id,
        nome: user.nome,
        login: user.login,
        is_admin: user.is_admin,
      },
    });
  } catch (err) {
    next(err);
  }
});

// Registro
router.post('/register', async (req, res, next) => {
  const { nome, login, password, is_admin = false } = req.body;

  if (!nome || !login || !password) {
    return res.status(400).json({ error: 'Nome, login e senha são obrigatórios' });
  }

  if (password.length < 6) {
    return res.status(400).json({ error: 'A senha deve ter pelo menos 6 caracteres' });
  }

  try {
    const existing = await pool.query(
      'SELECT id FROM "usuarios" WHERE "login" = $1 LIMIT 1',
      [login]
    );

    if (existing.rows.length > 0) {
      return res.status(409).json({ error: 'Login já cadastrado' });
    }

    const senhaHash = await bcrypt.hash(password, 10);

    const result = await pool.query(
      `INSERT INTO "usuarios" ("nome", "login", "senha_hash", "is_ativo", "is_admin")
       VALUES ($1, $2, $3, true, $4) RETURNING *`,
      [nome, login, senhaHash, is_admin]
    );

    const user = result.rows[0];

    const token = jwt.sign(
      { userId: user.id, login: user.login },
      JWT_SECRET,
      { expiresIn: JWT_EXPIRES_IN }
    );

    res.status(201).json({
      token,
      user: {
        id: user.id,
        nome: user.nome,
        login: user.login,
        is_admin: user.is_admin,
      },
    });
  } catch (err) {
    next(err);
  }
});

// Dados do usuário logado
router.get('/me', authenticateToken, async (req, res, next) => {
  try {
    const result = await pool.query(
      'SELECT id, nome, login, is_ativo, is_admin, ultimo_login, created_at FROM "usuarios" WHERE "id" = $1 LIMIT 1',
      [req.userId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Usuário não encontrado' });
    }

    res.json({ user: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
module.exports.authenticateToken = authenticateToken;

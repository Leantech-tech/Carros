const express = require('express');
const pool = require('../db');

const router = express.Router();

// Tabelas permitidas (whitelist de segurança)
const ALLOWED_TABLES = [
  'carros',
  'carros_bkp',
  'historico_servico',
  'os',
  'usuarios',
  'veiculo',
];

// Verifica se o nome da tabela é válido
function isValidTable(tableName) {
  return ALLOWED_TABLES.includes(tableName);
}

// Verifica se o nome da coluna é seguro (apenas letras, números e underscore)
function isValidColumn(columnName) {
  return /^[a-zA-Z_][a-zA-Z0-9_]*$/.test(columnName);
}

// Lista registros de uma tabela
// Suporta: filtros por igualdade (?coluna=valor), orderBy, orderDirection, limit
router.get('/:table', async (req, res, next) => {
  const { table } = req.params;
  if (!isValidTable(table)) {
    return res.status(400).json({ error: 'Tabela não permitida' });
  }

  const { orderBy, orderDirection, limit, offset, ...filters } = req.query;

  try {
    const conditions = [];
    const values = [];
    let paramIndex = 1;

    for (const [key, value] of Object.entries(filters)) {
      if (!isValidColumn(key)) continue;
      conditions.push(`"${key}" = $${paramIndex}`);
      values.push(value);
      paramIndex++;
    }

    let sql = `SELECT * FROM "${table}"`;
    if (conditions.length > 0) {
      sql += ` WHERE ${conditions.join(' AND ')}`;
    }

    if (orderBy && isValidColumn(orderBy)) {
      const direction = orderDirection?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC';
      sql += ` ORDER BY "${orderBy}" ${direction}`;
    }

    if (limit && !isNaN(parseInt(limit, 10))) {
      sql += ` LIMIT $${paramIndex}`;
      values.push(parseInt(limit, 10));
      paramIndex++;
    }

    if (offset && !isNaN(parseInt(offset, 10))) {
      sql += ` OFFSET $${paramIndex}`;
      values.push(parseInt(offset, 10));
      paramIndex++;
    }

    const result = await pool.query(sql, values);
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

// Busca um registro pelo id
router.get('/:table/:id', async (req, res, next) => {
  const { table, id } = req.params;
  if (!isValidTable(table)) {
    return res.status(400).json({ error: 'Tabela não permitida' });
  }

  try {
    const result = await pool.query(
      `SELECT * FROM "${table}" WHERE "id" = $1 LIMIT 1`,
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Registro não encontrado' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

// Cria um novo registro
router.post('/:table', async (req, res, next) => {
  const { table } = req.params;
  if (!isValidTable(table)) {
    return res.status(400).json({ error: 'Tabela não permitida' });
  }

  const data = req.body;
  if (!data || Object.keys(data).length === 0) {
    return res.status(400).json({ error: 'Dados não fornecidos' });
  }

  const columns = Object.keys(data).filter(isValidColumn);
  if (columns.length === 0) {
    return res.status(400).json({ error: 'Nenhuma coluna válida fornecida' });
  }

  const values = columns.map((col) => data[col]);
  const placeholders = columns.map((_, i) => `$${i + 1}`).join(', ');
  const columnNames = columns.map((col) => `"${col}"`).join(', ');

  try {
    const result = await pool.query(
      `INSERT INTO "${table}" (${columnNames}) VALUES (${placeholders}) RETURNING *`,
      values
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

// Atualiza um registro pelo id
router.patch('/:table/:id', async (req, res, next) => {
  const { table, id } = req.params;
  if (!isValidTable(table)) {
    return res.status(400).json({ error: 'Tabela não permitida' });
  }

  const data = req.body;
  if (!data || Object.keys(data).length === 0) {
    return res.status(400).json({ error: 'Dados não fornecidos' });
  }

  const columns = Object.keys(data).filter(isValidColumn);
  if (columns.length === 0) {
    return res.status(400).json({ error: 'Nenhuma coluna válida fornecida' });
  }

  const values = columns.map((col) => data[col]);
  const setClause = columns.map((col, i) => `"${col}" = $${i + 1}`).join(', ');

  try {
    const result = await pool.query(
      `UPDATE "${table}" SET ${setClause} WHERE "id" = $${columns.length + 1} RETURNING *`,
      [...values, id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Registro não encontrado' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

// Remove um registro pelo id
router.delete('/:table/:id', async (req, res, next) => {
  const { table, id } = req.params;
  if (!isValidTable(table)) {
    return res.status(400).json({ error: 'Tabela não permitida' });
  }

  try {
    const result = await pool.query(
      `DELETE FROM "${table}" WHERE "id" = $1 RETURNING *`,
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Registro não encontrado' });
    }
    res.json({ message: 'Registro removido', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

module.exports = router;

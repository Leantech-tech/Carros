require('dotenv').config();
const express = require('express');
const cors = require('cors');
const crudRoutes = require('./routes/crud');
const authRoutes = require('./routes/auth');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Rotas de autenticação
app.use('/auth', authRoutes);

// Rotas CRUD genéricas
app.use('/api', crudRoutes);

// Tratamento de rotas não encontradas
app.use((req, res) => {
  res.status(404).json({ error: 'Rota não encontrada' });
});

// Tratamento de erros global
app.use((err, req, res, next) => {
  console.error('Erro na requisição:', err);
  res.status(err.status || 500).json({
    error: err.message || 'Erro interno do servidor',
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`API Carros rodando na porta ${PORT}`);
});

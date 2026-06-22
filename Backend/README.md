# Backend - Carros

API REST para integração do app Carros com o banco de dados PostgreSQL.

## Tecnologias

- Node.js 20
- Express
- PostgreSQL (via `pg`)
- JWT para autenticação
- Docker

## Estrutura

```
Backend/
├── src/
│   ├── db.js              # Conexão com PostgreSQL
│   ├── index.js           # Servidor Express
│   └── routes/
│       ├── auth.js        # Login, registro, dados do usuário
│       └── crud.js        # CRUD genérico para as tabelas
├── Dockerfile
├── docker-compose.yml
├── package.json
└── .env.example
```

## Configuração local

1. Copie o arquivo de exemplo:
   ```bash
   cp .env.example .env
   ```

2. Instale as dependências:
   ```bash
   npm install
   ```

3. Inicie a API:
   ```bash
   npm start
   # ou, em desenvolvimento:
   npm run dev
   ```

A API estará disponível em `http://localhost:3000`.

## Endpoints

### Health check
- `GET /health`

### Autenticação
- `POST /auth/login` — Login
- `POST /auth/register` — Registro
- `GET /auth/me` — Dados do usuário logado

### CRUD genérico

Para cada tabela permitida (`carros`, `carros_bkp`, `historico_servico`, `os`, `usuarios`, `veiculo`):

- **Listar:** `GET /api/:tabela`
- **Buscar por id:** `GET /api/:tabela/:id`
- **Criar:** `POST /api/:tabela`
- **Atualizar:** `PATCH /api/:tabela/:id`
- **Remover:** `DELETE /api/:tabela/:id`

## Deploy com Docker

```bash
docker-compose up -d --build
```

A API estará disponível na porta `3000`.

## Deploy no servidor

1. Suba este diretório (`Backend/`) no GitHub.
2. No servidor, clone o repositório:
   ```bash
   git clone https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
   cd SEU_REPOSITORIO/Backend
   ```
3. Suba com Docker Compose:
   ```bash
   docker-compose up -d --build
   ```
4. Verifique se está rodando:
   ```bash
   curl http://localhost:3000/health
   ```

# ============================================
# Dockerfile - Backend Carros
# API REST em Node.js + Express + PostgreSQL
# ============================================

# Estágio 1: Build das dependências
FROM node:20-alpine AS builder

WORKDIR /app

# Copia apenas os arquivos de dependências primeiro (cache eficiente)
COPY package*.json ./

# Instala dependências de produção
RUN npm ci --only=production && npm cache clean --force

# Estágio 2: Imagem final enxuta
FROM node:20-alpine

WORKDIR /app

# Cria usuário não-root para segurança
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copia as dependências instaladas do estágio anterior
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./

# Copia o código fonte
COPY src ./src

# Ajusta permissões
RUN chown -R nodejs:nodejs /app
USER nodejs

# Porta exposta pela aplicação
EXPOSE 3000

# Health check da aplicação
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => r.statusCode === 200 ? process.exit(0) : process.exit(1))"

# Comando de inicialização
CMD ["node", "src/index.js"]

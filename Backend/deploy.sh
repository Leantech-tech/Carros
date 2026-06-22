#!/bin/bash
set -e

# ============================================================
# Script de deploy automático do Backend Carros
# Roda no servidor Linux onde a API será hospedada
# ============================================================

APP_NAME="backend-carros"
APP_DIR="/opt/backend-carros"
API_PORT="${API_PORT:-3000}"

echo "=========================================="
echo "Deploy do Backend Carros"
echo "=========================================="

# 1. Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
  echo "⚠️  Execute com sudo: sudo ./deploy.sh"
  exit 1
fi

# 2. Instala o Docker e Docker Compose se não existirem
if ! command -v docker &> /dev/null; then
  echo "🐳 Docker não encontrado. Instalando..."
  curl -fsSL https://get.docker.com | sh
  systemctl enable docker
  systemctl start docker
else
  echo "✅ Docker já instalado"
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
  echo "🐳 Docker Compose não encontrado. Instalando..."
  DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
else
  echo "✅ Docker Compose já instalado"
fi

# 3. Cria a pasta da aplicação
echo "📁 Criando pasta da aplicação em $APP_DIR..."
mkdir -p "$APP_DIR"

# 4. Copia os arquivos (assumindo que o script está na mesma pasta do backend)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📂 Copiando arquivos do backend..."
cp -r "$SCRIPT_DIR"/* "$APP_DIR/"

# 5. Ajusta permissões
chmod +x "$APP_DIR/deploy.sh"

# 6. Para e remove containers antigos, se existirem
echo "🛑 Parando versão anterior, se existir..."
cd "$APP_DIR"
docker-compose down 2>/dev/null || true

# 7. Build e sobe a API
echo "🏗️  Buildando e iniciando o backend..."
docker-compose up -d --build

# 8. Aguarda a API subir
echo "⏳ Aguardando o backend iniciar..."
sleep 5

# 9. Testa a API
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$API_PORT/health || echo "000")
if [ "$HTTP_STATUS" = "200" ]; then
  echo ""
  echo "=========================================="
  echo "✅ Backend Carros deployado com sucesso!"
  echo "📍 URL da API: http://$(curl -s ifconfig.me || echo 'SEU_IP'):$API_PORT/api"
  echo "📍 Health check: http://localhost:$API_PORT/health"
  echo "=========================================="
else
  echo ""
  echo "⚠️  Backend não respondeu como esperado (status $HTTP_STATUS)."
  echo "Verifique os logs com: docker logs $APP_NAME"
  exit 1
fi

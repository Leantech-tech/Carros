-- Script para adicionar a coluna mecanico_responsavel na tabela os
ALTER TABLE public.os 
ADD COLUMN IF NOT EXISTS mecanico_responsavel text;

-- Comentário opcional para descrever a coluna
COMMENT ON COLUMN public.os.mecanico_responsavel IS 'Nome do mecânico responsável pela Ordem de Serviço';

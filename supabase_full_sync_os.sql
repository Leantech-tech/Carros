-- Script Completo para Sincronização da Tabela 'os'
-- Este script adiciona todas as colunas necessárias caso elas não existam.

ALTER TABLE public.os 
ADD COLUMN IF NOT EXISTS numero text DEFAULT '',
ADD COLUMN IF NOT EXISTS km_veiculo integer,
ADD COLUMN IF NOT EXISTS data_entrada timestamp with time zone,
ADD COLUMN IF NOT EXISTS data_previsao timestamp with time zone,
ADD COLUMN IF NOT EXISTS data_conclusao timestamp with time zone,
ADD COLUMN IF NOT EXISTS status text DEFAULT 'Pendente',
ADD COLUMN IF NOT EXISTS descricao text,
ADD COLUMN IF NOT EXISTS valor_mao_obra numeric(10,2),
ADD COLUMN IF NOT EXISTS valor_peca numeric(10,2),
ADD COLUMN IF NOT EXISTS valor_total numeric(10,2),
ADD COLUMN IF NOT EXISTS observacao text,
ADD COLUMN IF NOT EXISTS mecanico_responsavel text,
ADD COLUMN IF NOT EXISTS veiculo_id uuid REFERENCES public.veiculo(id) ON DELETE SET NULL,
ADD COLUMN IF NOT EXISTS criado_em timestamp with time zone DEFAULT now(),
ADD COLUMN IF NOT EXISTS atualizado_em timestamp with time zone DEFAULT now();

-- Garantir que a coluna numero não seja nula (opcional, dependendo da necessidade)
-- ALTER TABLE public.os ALTER COLUMN numero SET NOT NULL;

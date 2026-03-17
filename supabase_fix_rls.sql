-- Script para Corrigir Permissões (RLS) na Tabela 'os'
-- Este script habilita o acesso para inserção, atualização e leitura.

-- 1. Habilitar RLS (caso não esteja habilitado)
ALTER TABLE public.os ENABLE ROW LEVEL SECURITY;

-- 2. Criar política para permitir acesso total (leitura/escrita) para usuários anonimos/autenticados
-- Nota: Em produção, o ideal é restringir apenas para usuários autenticados.
-- Abaixo, uma política permissiva para fins de desenvolvimento:

CREATE POLICY "Permitir tudo para todos" ON public.os
FOR ALL
USING (true)
WITH CHECK (true);

-- 3. Garantir que o esquema public tenha permissões
GRANT ALL ON TABLE public.os TO anon;
GRANT ALL ON TABLE public.os TO authenticated;
GRANT ALL ON TABLE public.os TO service_role;

-- Script para sincronizar o campo 'numero' com o 'id' sequencial
-- 1. Primeiro, garantimos que a coluna 'id' seja um BIGINT gerado automaticamente (caso ainda não seja)
-- Nota: Se o seu 'id' for UUID, o procedimento é diferente. Assumindo ID numérico baseado na reclamação do usuário ("id 2").

-- 2. Alterar a coluna 'numero' para ter um valor padrão baseado no ID
-- Como o ID é gerado no insert, podemos usar uma trigger para preencher o numero logo após a inserção se ele for enviado vazio.

CREATE OR REPLACE FUNCTION public.tr_preencher_numero_os()
RETURNS TRIGGER AS $$
BEGIN
  -- Se o número vier vazio ou nulo, preenchemos com o ID formatado (ex: 000002)
  IF (NEW.numero IS NULL OR NEW.numero = '') THEN
    NEW.numero := LPAD(NEW.id::text, 6, '0');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_preencher_numero_os_trigger ON public.os;
CREATE TRIGGER tr_preencher_numero_os_trigger
BEFORE INSERT ON public.os
FOR EACH ROW
EXECUTE FUNCTION public.tr_preencher_numero_os();

-- 3. (Opcional) Corrigir os registros existentes
UPDATE public.os 
SET numero = LPAD(id::text, 6, '0') 
WHERE numero = '' OR numero IS NULL OR numero ~ '^[0-9]+$' AND LENGTH(numero) != 6;

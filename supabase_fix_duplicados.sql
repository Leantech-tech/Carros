-- 1. Transforma a OS duplicada mais recente em #2
UPDATE os 
SET numero = '2' 
WHERE id = (
  SELECT id FROM os WHERE numero = '1' ORDER BY criado_em DESC LIMIT 1
);

-- 2. Sincroniza o contador para que a próxima OS seja sempre o MAIOR_NUMERO + 1
SELECT setval('os_numero_seq', COALESCE((SELECT MAX(numero::int) FROM os), 0));

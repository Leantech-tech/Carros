-- 1. Reset the sequence so the next OS starts at 1
ALTER SEQUENCE IF EXISTS os_numero_seq RESTART WITH 1;

-- 2. (Optional) If you have an OS that was created as #4 and you want it to be #1:
UPDATE os SET numero = '1' WHERE numero = '4';

-- Note: After running this, the next OS created will use 'nextval' which will be 1 (if no records exist) 
-- or it might conflict if you already have a #1. 
-- If you just want to clear everything and start fresh:
-- DELETE FROM os;
-- ALTER SEQUENCE os_numero_seq RESTART WITH 1;

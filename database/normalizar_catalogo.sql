-- Normalizacion de dos codigos provisorios del seed.sql original.
-- El catalogo masivo salta esos programas por nombre, de modo que sin esta
-- correccion Humanidades no encuentra PLAN-P-CSPE ni PLAN-P-PSIC al reconstruir.
-- Es idempotente y no crea carreras duplicadas.
UPDATE carreras
SET codigo='PLAN-P-CSPE'
WHERE codigo='UASD-LOC-004'
  AND nombre='Licenciatura en Comunicación Social Mención Periodismo'
  AND NOT EXISTS (SELECT 1 FROM carreras WHERE codigo='PLAN-P-CSPE');

UPDATE carreras
SET codigo='PLAN-P-PSIC'
WHERE codigo='UASD-LOC-005'
  AND nombre='Licenciatura en Psicología Mención Psicología Clínica'
  AND NOT EXISTS (SELECT 1 FROM carreras WHERE codigo='PLAN-P-PSIC');

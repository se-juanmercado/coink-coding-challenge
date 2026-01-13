-- =====================================================
-- SP create users Tests
-- =====================================================

-- País no existe
CALL sp_create_user(
    'Juan Pérez',
    '3001234567',
    'Calle Falsa 123',
    'Indonesia',       -- país inválido
    'Antioquia',
    'Medellín',
	'3fa85f64-5717-4562-b3fc-2c963f66afa6'
);

-- Departamento no pertenece al país
CALL sp_create_user(
    'Ana Gómez',
    '3002345678',
    'Carrera 45 #67-89',
    'Colombia',           -- país correcto
    'Zulia',              -- departamento que NO pertenece a Colombia
    'Maracaibo',
	'3fa85f64-5717-4562-b3fc-2c963f66afa6'
);

-- Municipio no pertenece al departamento
CALL sp_create_user(
    'Luis Martínez',
    '3003456789',
    'Avenida Siempre Viva 742',
    'Colombia',           -- país correcto
    'Antioquia',          -- departamento correcto
    'Bogotá',              -- municipio que NO pertenece a Antioquia
	'3fa85f64-5717-4562-b3fc-2c963f66afa6'
);

-- Todo correcto
CALL sp_create_user(
    'María Rodríguez',
    '3004567890',
    'Calle 100 #10-20',
    'Colombia',
    'Antioquia',
    'Medellín',
	'3fa85f64-5717-4562-b3fc-2c963f66afa6'
);







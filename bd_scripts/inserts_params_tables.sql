-- =====================================================
-- countries
-- =====================================================

INSERT INTO countries (name) VALUES
('Venezuela'),
('Colombia'),
('Argentina'),
('Brazil');

-- =====================================================
-- departments
-- =====================================================

-- Venezuela
INSERT INTO departments (name, country_id)
SELECT d.name, c.id
FROM countries c
JOIN (VALUES
    ('Zulia'),
    ('Miranda'),
    ('Aragua'),
    ('Bolívar'),
    ('Monagas')
) AS d(name)
ON c.name = 'Venezuela';

-- Colombia
INSERT INTO departments (name, country_id)
SELECT d.name, c.id
FROM countries c
JOIN (VALUES
    ('Antioquia'),
    ('Cundinamarca'),
    ('Valle del Cauca'),
    ('Atlántico'),
    ('Santander')
) AS d(name)
ON c.name = 'Colombia';

-- Argentina
INSERT INTO departments (name, country_id)
SELECT d.name, c.id
FROM countries c
JOIN (VALUES
    ('Buenos Aires'),
    ('Córdoba'),
    ('Santa Fe'),
    ('Mendoza'),
    ('Tucumán')
) AS d(name)
ON c.name = 'Argentina';

-- Brazil
INSERT INTO departments (name, country_id)
SELECT d.name, c.id
FROM countries c
JOIN (VALUES
    ('São Paulo'),
    ('Rio de Janeiro'),
    ('Bahia'),
    ('Minas Gerais'),
    ('Paraná')
) AS d(name)
ON c.name = 'Brazil';

-- =====================================================
-- municipalities
-- =====================================================

-- Venezuela municipalities
INSERT INTO municipalities (name, department_id)
SELECT m.name, d.id
FROM departments d
JOIN (VALUES
    ('Zulia', 'Maracaibo'),
    ('Zulia', 'San Francisco'),
    ('Miranda', 'Los Teques'),
    ('Miranda', 'Guarenas'),
    ('Aragua', 'Maracay'),
    ('Aragua', 'Turmero'),
    ('Bolívar', 'Ciudad Bolívar'),
    ('Bolívar', 'Upata'),
    ('Monagas', 'Maturín'),
    ('Monagas', 'Caripito')
) AS m(department_name, name)
ON d.name = m.department_name
JOIN countries c ON c.id = d.country_id
WHERE c.name = 'Venezuela';

-- Colombia municipalities
INSERT INTO municipalities (name, department_id)
SELECT m.name, d.id
FROM departments d
JOIN (VALUES
    ('Antioquia', 'Medellín'),
    ('Antioquia', 'Envigado'),
    ('Cundinamarca', 'Bogotá'),
    ('Cundinamarca', 'Soacha'),
    ('Valle del Cauca', 'Cali'),
    ('Valle del Cauca', 'Palmira'),
    ('Atlántico', 'Barranquilla'),
    ('Atlántico', 'Soledad'),
    ('Santander', 'Bucaramanga'),
    ('Santander', 'Floridablanca')
) AS m(department_name, name)
ON d.name = m.department_name
JOIN countries c ON c.id = d.country_id
WHERE c.name = 'Colombia';

-- Argentina municipalities
INSERT INTO municipalities (name, department_id)
SELECT m.name, d.id
FROM departments d
JOIN (VALUES
    ('Buenos Aires', 'La Plata'),
    ('Buenos Aires', 'Mar del Plata'),
    ('Córdoba', 'Córdoba'),
    ('Córdoba', 'Villa Carlos Paz'),
    ('Santa Fe', 'Rosario'),
    ('Santa Fe', 'Santa Fe'),
    ('Mendoza', 'Mendoza'),
    ('Mendoza', 'San Rafael'),
    ('Tucumán', 'San Miguel de Tucumán'),
    ('Tucumán', 'Tafí Viejo')
) AS m(department_name, name)
ON d.name = m.department_name
JOIN countries c ON c.id = d.country_id
WHERE c.name = 'Argentina';

-- Brasil municipalities
INSERT INTO municipalities (name, department_id)
SELECT m.name, d.id
FROM departments d
JOIN (VALUES
    ('São Paulo', 'São Paulo'),
    ('São Paulo', 'Campinas'),
    ('Rio de Janeiro', 'Rio de Janeiro'),
    ('Rio de Janeiro', 'Niterói'),
    ('Bahia', 'Salvador'),
    ('Bahia', 'Feira de Santana'),
    ('Minas Gerais', 'Belo Horizonte'),
    ('Minas Gerais', 'Uberlândia'),
    ('Paraná', 'Curitiba'),
    ('Paraná', 'Londrina')
) AS m(department_name, name)
ON d.name = m.department_name
JOIN countries c ON c.id = d.country_id
WHERE c.name = 'Brazil';

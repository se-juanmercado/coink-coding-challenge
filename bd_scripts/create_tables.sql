/*
	El modelo de datos fue diseñado aplicando la Tercera Forma Normal (3FN),
	con el objetivo de evitar duplicación de información y mantener la
	consistencia de los datos.

	Durante el diseño se evaluó la posibilidad de desnormalizar la tabla
	users almacenando tanto la ciudad como el país. Esta alternativa se
	consideró para simplificar algunas consultas y tener en cuenta posibles
	escenarios de rendimiento.

	Finalmente, se decidió mantener el modelo completamente normalizado,
	dejando únicamente la referencia a la ciudad en la tabla users, ya que
	el país puede obtenerse de forma correcta a través de las relaciones
	entre ciudades, departamentos y países.
*/

-- =====================================================
-- Habilitar la extensión necesaria para la generación de UUID
-- =====================================================
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- =====================================================
-- countries (Tabla parametrica)
-- =====================================================
CREATE TABLE countries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,

    CONSTRAINT uq_countries_name UNIQUE (name)
);

-- =====================================================
-- departments (Tabla parametrica)
-- =====================================================
CREATE TABLE departments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    country_id UUID NOT NULL,

    CONSTRAINT fk_departments_country
        FOREIGN KEY (country_id)
        REFERENCES countries(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_departments_country_name
        UNIQUE (country_id, name)
);

-- =====================================================
-- municipalities (Tabla parametrica)
-- =====================================================
CREATE TABLE municipalities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    department_id UUID NOT NULL,

    CONSTRAINT fk_municipalities_department
        FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_municipalities_department_name
        UNIQUE (department_id, name)
);

-- =====================================================
-- users (Tabla transaccional)
-- =====================================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    municipality_id UUID NOT NULL,
	created_by UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
	updated_by UUID NULL,
    updated_at TIMESTAMPTZ NULL,

    CONSTRAINT uq_users_phone UNIQUE (phone),

    CONSTRAINT fk_users_municipality
        FOREIGN KEY (municipality_id)
        REFERENCES municipalities(id)
        ON DELETE RESTRICT
);


/*
	Se agregaron índices en las claves foráneas para optimizar consultas y operaciones de JOIN.
	Las claves primarias y restricciones UNIQUE ya generan índices automáticamente.
*/
-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_users_municipality_id
    ON users (municipality_id);

CREATE INDEX idx_municipalities_department_id
    ON municipalities (department_id);

CREATE INDEX idx_departments_country_id
    ON departments (country_id);
-- =====================================================
-- FN create users
-- =====================================================

CREATE OR REPLACE FUNCTION fn_create_user(
    p_name TEXT,
    p_phone VARCHAR(20),
    p_address TEXT,
    p_country_name TEXT,
    p_department_name TEXT,
    p_municipality_name TEXT,
    p_created_by UUID
)
RETURNS UUID AS
$$
DECLARE
    v_country_id UUID;
    v_department_id UUID;
    v_municipality_id UUID;
    v_user_id UUID;
BEGIN
    -- Validar país
    SELECT id INTO v_country_id
    FROM countries
    WHERE name = p_country_name;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'País % no está parametrizado en el sistema', p_country_name;
    END IF;

    -- Validar departamento y que pertenezca al país
    SELECT id INTO v_department_id
    FROM departments
    WHERE name = p_department_name
      AND country_id = v_country_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Departamento % no pertenece al país %', p_department_name, p_country_name;
    END IF;

    -- Validar municipio y que pertenezca al departamento
    SELECT id INTO v_municipality_id
    FROM municipalities
    WHERE name = p_municipality_name
      AND department_id = v_department_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Municipio % no pertenece al departamento %', p_municipality_name, p_department_name;
    END IF;

    -- Insertar usuario
    INSERT INTO users(name, phone, address, municipality_id, created_by)
    VALUES (p_name, p_phone, p_address, v_municipality_id, p_created_by)
    RETURNING id INTO v_user_id;

    -- Devolver el id del usuario creado
    RETURN v_user_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Ya existe un usuario con el teléfono %', p_phone;
END;
$$ LANGUAGE plpgsql;
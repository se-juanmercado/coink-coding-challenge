-- =====================================================
-- Query users
-- =====================================================

SELECT
    id         AS user_id,
    name       AS user_name,
    phone,
    address,
    municipality_id,
	created_by,
    created_at,
	updated_by,
    updated_at
FROM users
ORDER BY name;

-- =====================================================
-- Query users (Salida JSON)
-- =====================================================

SELECT
    jsonb_build_object(
        'user_id', u.id,
        'name', u.name,
        'phone', u.phone,
        'address', u.address,
		'created_by', u.created_by,
        'created_at', u.created_at,
		'updated_by', u.updated_by,
        'updated_at', u.updated_at,
        'municipality', jsonb_build_object(
            'id', m.id,
            'name', m.name
        ),
        'department', jsonb_build_object(
            'id', d.id,
            'name', d.name
        ),
        'country', jsonb_build_object(
            'id', c.id,
            'name', c.name
        )
    ) AS user
FROM users u
JOIN municipalities m ON m.id = u.municipality_id
JOIN departments d ON d.id = m.department_id
JOIN countries c ON c.id = d.country_id;

-- =====================================================
-- Query tablas parametricas
-- =====================================================

SELECT
    u.id        AS user_id,
    u.name      AS user_name,
    u.phone,
    u.address,
	u.created_by,
    u.created_at,
	u.updated_by,
    u.updated_at,

    m.id        AS municipality_id,
    m.name      AS municipality_name,

    d.id        AS department_id,
    d.name      AS department_name,

    c.id        AS country_id,
    c.name      AS country_name
FROM users u
JOIN municipalities m
    ON m.id = u.municipality_id
JOIN departments d
    ON d.id = m.department_id
JOIN countries c
    ON c.id = d.country_id
ORDER BY
    u.name;

-- QUERY TRUNCATED
-- ========================
-- USUARIOS
-- Password de todos: Password123!
-- BCrypt hash: $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W
-- ========================

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Admin Sistema', 'admin@sistema.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'ADMIN', 'ACTIVE', NOW() - INTERVAL '30 days', NOW() - INTERVAL '1 hour')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Carlos Mendoza', 'carlos.mendoza@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'ACTIVE', NOW() - INTERVAL '20 days', NOW() - INTERVAL '2 days')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Laura Torres', 'laura.torres@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'ACTIVE', NOW() - INTERVAL '18 days', NOW() - INTERVAL '2 days')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Andrés Ríos', 'andres.rios@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'ACTIVE', NOW() - INTERVAL '15 days', NOW() - INTERVAL '2 days')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Sofía Vargas', 'sofia.vargas@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'ACTIVE', NOW() - INTERVAL '12 days', NOW() - INTERVAL '5 days')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Miguel Herrera', 'miguel.herrera@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'ACTIVE', NOW() - INTERVAL '10 days', NOW() - INTERVAL '3 days')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Valentina Cruz', 'valentina.cruz@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'ACTIVE', NOW() - INTERVAL '8 days', NOW() - INTERVAL '1 day')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Jorge Castillo', 'jorge.castillo@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'ACTIVE', NOW() - INTERVAL '6 days', NOW() - INTERVAL '1 day')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Natalia Gómez', 'natalia.gomez@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'ACTIVE', NOW() - INTERVAL '4 days', NOW() - INTERVAL '1 day')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Ricardo Peña', 'ricardo.pena@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'INACTIVE', NOW() - INTERVAL '25 days', NOW() - INTERVAL '20 days')
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (name, email, password, role, status, created_at, last_login)
VALUES ('Camila Rojas', 'camila.rojas@correo.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh.W',
        'USER', 'INACTIVE', NOW() - INTERVAL '22 days', NOW() - INTERVAL '18 days')
ON CONFLICT (email) DO NOTHING;

-- ========================
-- SESSIONS
-- ========================

INSERT INTO sessions (user_id, token, ip_address, user_agent, created_at, expires_at, is_active)
VALUES (
    (SELECT id FROM users WHERE email = 'admin@sistema.com'),
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    '192.168.1.1',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    NOW() - INTERVAL '1 hour',
    NOW() + INTERVAL '23 hours',
    TRUE
) ON CONFLICT (token) DO NOTHING;

INSERT INTO sessions (user_id, token, ip_address, user_agent, created_at, expires_at, is_active)
VALUES (
    (SELECT id FROM users WHERE email = 'carlos.mendoza@correo.com'),
    'b2c3d4e5-f6a7-8901-bcde-f12345678901',
    '192.168.1.10',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
    NOW() - INTERVAL '2 days',
    NOW() - INTERVAL '1 day',
    FALSE
) ON CONFLICT (token) DO NOTHING;

INSERT INTO sessions (user_id, token, ip_address, user_agent, created_at, expires_at, is_active)
VALUES (
    (SELECT id FROM users WHERE email = 'laura.torres@correo.com'),
    'c3d4e5f6-a7b8-9012-cdef-123456789012',
    '192.168.1.20',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1',
    NOW() - INTERVAL '3 hours',
    NOW() + INTERVAL '21 hours',
    TRUE
) ON CONFLICT (token) DO NOTHING;

INSERT INTO sessions (user_id, token, ip_address, user_agent, created_at, expires_at, is_active)
VALUES (
    (SELECT id FROM users WHERE email = 'sofia.vargas@correo.com'),
    'd4e5f6a7-b8c9-0123-defa-234567890123',
    '192.168.1.35',
    'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36',
    NOW() - INTERVAL '5 days',
    NOW() - INTERVAL '4 days',
    FALSE
) ON CONFLICT (token) DO NOTHING;

INSERT INTO sessions (user_id, token, ip_address, user_agent, created_at, expires_at, is_active)
VALUES (
    (SELECT id FROM users WHERE email = 'natalia.gomez@correo.com'),
    'e5f6a7b8-c9d0-1234-efab-345678901234',
    '192.168.1.50',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/117.0',
    NOW() - INTERVAL '30 minutes',
    NOW() + INTERVAL '23 hours 30 minutes',
    TRUE
) ON CONFLICT (token) DO NOTHING;

-- ========================
-- AUDIT LOG
-- ========================

INSERT INTO audit_log (performed_by, target_user, action, description, ip_address, created_at)
VALUES (
    (SELECT id FROM users WHERE email = 'carlos.mendoza@correo.com'),
    (SELECT id FROM users WHERE email = 'carlos.mendoza@correo.com'),
    'REGISTER',
    'Usuario Carlos Mendoza se registró en el sistema',
    '192.168.1.10',
    NOW() - INTERVAL '20 days'
) ON CONFLICT DO NOTHING;

INSERT INTO audit_log (performed_by, target_user, action, description, ip_address, created_at)
VALUES (
    (SELECT id FROM users WHERE email = 'admin@sistema.com'),
    (SELECT id FROM users WHERE email = 'ricardo.pena@correo.com'),
    'ADMIN_UPDATE_USER',
    'Admin cambió el estado de Ricardo Peña a INACTIVE',
    '192.168.1.1',
    NOW() - INTERVAL '15 days'
) ON CONFLICT DO NOTHING;

INSERT INTO audit_log (performed_by, target_user, action, description, ip_address, created_at)
VALUES (
    (SELECT id FROM users WHERE email = 'admin@sistema.com'),
    (SELECT id FROM users WHERE email = 'camila.rojas@correo.com'),
    'ADMIN_UPDATE_USER',
    'Admin cambió el estado de Camila Rojas a INACTIVE',
    '192.168.1.1',
    NOW() - INTERVAL '14 days'
) ON CONFLICT DO NOTHING;

INSERT INTO audit_log (performed_by, target_user, action, description, ip_address, created_at)
VALUES (
    (SELECT id FROM users WHERE email = 'laura.torres@correo.com'),
    (SELECT id FROM users WHERE email = 'laura.torres@correo.com'),
    'UPDATE_PROFILE',
    'Usuario Laura Torres actualizó su nombre y correo',
    '192.168.1.20',
    NOW() - INTERVAL '10 days'
) ON CONFLICT DO NOTHING;

INSERT INTO audit_log (performed_by, target_user, action, description, ip_address, created_at)
VALUES (
    (SELECT id FROM users WHERE email = 'andres.rios@correo.com'),
    (SELECT id FROM users WHERE email = 'andres.rios@correo.com'),
    'CHANGE_PASSWORD',
    'Usuario Andrés Ríos cambió su contraseña',
    '192.168.1.15',
    NOW() - INTERVAL '7 days'
) ON CONFLICT DO NOTHING;

INSERT INTO audit_log (performed_by, target_user, action, description, ip_address, created_at)
VALUES (
    (SELECT id FROM users WHERE email = 'admin@sistema.com'),
    (SELECT id FROM users WHERE email = 'valentina.cruz@correo.com'),
    'ADMIN_CREATE_USER',
    'Admin creó la cuenta de Valentina Cruz',
    '192.168.1.1',
    NOW() - INTERVAL '8 days'
) ON CONFLICT DO NOTHING;

INSERT INTO audit_log (performed_by, target_user, action, description, ip_address, created_at)
VALUES (
    (SELECT id FROM users WHERE email = 'miguel.herrera@correo.com'),
    (SELECT id FROM users WHERE email = 'miguel.herrera@correo.com'),
    'LOGIN',
    'Usuario Miguel Herrera inició sesión',
    '192.168.1.30',
    NOW() - INTERVAL '3 days'
) ON CONFLICT DO NOTHING;

INSERT INTO audit_log (performed_by, target_user, action, description, ip_address, created_at)
VALUES (
    (SELECT id FROM users WHERE email = 'admin@sistema.com'),
    (SELECT id FROM users WHERE email = 'jorge.castillo@correo.com'),
    'ADMIN_UPDATE_USER',
    'Admin actualizó el perfil de Jorge Castillo',
    '192.168.1.1',

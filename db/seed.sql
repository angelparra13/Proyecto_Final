-- =============================================================================
-- Seed: datos de prueba
-- Passwords hasheados con BCryptPasswordEncoder (strength = 10)
--
-- Para regenerar un hash desde Spring Boot:
--   BCryptPasswordEncoder enc = new BCryptPasswordEncoder();
--   System.out.println(enc.encode("TuPassword"));
--
-- Credenciales de prueba:
--   Admin   → admin@sistema.com    /  Admin123!
--   Usuarios → (cualquier email)   /  Password123!
-- =============================================================================

-- Admin por defecto
INSERT INTO users (name, email, password, role, status, created_at) VALUES
    ('Administrador',
     'admin@sistema.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'ADMIN', 'ACTIVE', NOW() - INTERVAL '60 days')
ON CONFLICT (email) DO NOTHING;

-- Usuarios de prueba (password: Password123!)
INSERT INTO users (name, email, password, role, status, created_at) VALUES
    ('María García',    'maria.garcia@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'ACTIVE',   NOW() - INTERVAL '30 days'),

    ('Carlos López',    'carlos.lopez@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'ACTIVE',   NOW() - INTERVAL '25 days'),

    ('Ana Martínez',    'ana.martinez@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'INACTIVE', NOW() - INTERVAL '20 days'),

    ('Luis Rodríguez',  'luis.rodriguez@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'ADMIN', 'ACTIVE',  NOW() - INTERVAL '15 days'),

    ('Elena Fernández', 'elena.fernandez@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'ACTIVE',   NOW() - INTERVAL '12 days'),

    ('Pedro Sánchez',   'pedro.sanchez@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'ACTIVE',   NOW() - INTERVAL '10 days'),

    ('Laura Díaz',      'laura.diaz@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'INACTIVE', NOW() - INTERVAL '8 days'),

    ('Miguel Torres',   'miguel.torres@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'ACTIVE',   NOW() - INTERVAL '5 days'),

    ('Carmen Ruiz',     'carmen.ruiz@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'ACTIVE',   NOW() - INTERVAL '3 days'),

    ('José Morales',    'jose.morales@email.com',
     '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO1ohKjlzm2',
     'USER', 'ACTIVE',   NOW() - INTERVAL '1 day')
ON CONFLICT (email) DO NOTHING;

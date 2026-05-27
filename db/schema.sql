-- =============================================================================
-- Schema: Sistema de Gestión de Usuarios
-- Base de datos: PostgreSQL (Neon)
-- Ejecutar ANTES del seed.sql
-- =============================================================================

CREATE TABLE IF NOT EXISTS users (
    id         BIGSERIAL    PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    email      VARCHAR(255) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    role       VARCHAR(10)  NOT NULL DEFAULT 'USER'
                            CHECK (role IN ('USER', 'ADMIN')),
    status     VARCHAR(10)  NOT NULL DEFAULT 'ACTIVE'
                            CHECK (status IN ('ACTIVE', 'INACTIVE')),
    created_at TIMESTAMP    NOT NULL DEFAULT NOW(),
    last_login TIMESTAMP
);

-- Índices para búsquedas frecuentes
CREATE INDEX IF NOT EXISTS idx_users_email ON users (email);
CREATE INDEX IF NOT EXISTS idx_users_role  ON users (role);

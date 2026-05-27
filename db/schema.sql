-- ============================================================
-- TABLA 1: users
-- Propósito: almacena todos los usuarios del sistema.
-- Es la tabla central del proyecto. Todas las demás tablas
-- se relacionan con ella. Contiene credenciales, rol y estado.
--
-- Columnas clave:
--   role   → determina qué puede hacer el usuario (USER/ADMIN)
--   status → permite desactivar cuentas sin eliminarlas
--   password → siempre almacenada como hash BCrypt, nunca texto plano
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id         BIGSERIAL    PRIMARY KEY,                        -- Identificador único autoincremental
    name       VARCHAR(100) NOT NULL,                          -- Nombre completo del usuario
    email      VARCHAR(150) NOT NULL UNIQUE,                   -- Correo único, usado para login
    password   VARCHAR(255) NOT NULL,                          -- Hash BCrypt de la contraseña
    role       VARCHAR(20)  NOT NULL DEFAULT 'USER'            -- Rol del usuario en el sistema
                            CHECK (role IN ('USER', 'ADMIN')),
    status     VARCHAR(20)  NOT NULL DEFAULT 'ACTIVE'          -- Estado de la cuenta
                            CHECK (status IN ('ACTIVE', 'INACTIVE')),
    created_at TIMESTAMP    NOT NULL DEFAULT NOW(),            -- Fecha de registro
    last_login TIMESTAMP                                        -- Último inicio de sesión (null si nunca)
);

-- Índices para acelerar búsquedas frecuentes en users
CREATE INDEX IF NOT EXISTS idx_users_email  ON users(email);   -- Login busca por email constantemente
CREATE INDEX IF NOT EXISTS idx_users_role   ON users(role);    -- Admin filtra usuarios por rol
CREATE INDEX IF NOT EXISTS idx_users_status ON users(status);  -- Admin filtra usuarios por estado


-- ============================================================
-- TABLA 2: sessions
-- Propósito: registra cada vez que un usuario inicia sesión.
-- Guarda el token JWT emitido, desde qué dispositivo/IP accedió
-- y si esa sesión sigue activa o ya expiró.
--
-- Columnas clave:
--   token     → el JWT emitido en ese login (único por sesión)
--   is_active → FALSE cuando el usuario hace logout o el token expira
--   expires_at → cuándo vence el token (útil para limpiar sesiones viejas)
--
-- Relación: user_id → users(id) ON DELETE CASCADE
--   Si se elimina el usuario, todas sus sesiones se eliminan también
-- ============================================================
CREATE TABLE IF NOT EXISTS sessions (
    id         BIGSERIAL    PRIMARY KEY,                        -- Identificador único de la sesión
    user_id    BIGINT       NOT NULL                           -- Usuario dueño de esta sesión
                            REFERENCES users(id)
                            ON DELETE CASCADE,
    token      VARCHAR(512) NOT NULL UNIQUE,                   -- JWT emitido (único por sesión)
    ip_address VARCHAR(45),                                    -- IP desde donde se conectó (IPv4 o IPv6)
    user_agent VARCHAR(512),                                   -- Navegador/dispositivo usado
    created_at TIMESTAMP    NOT NULL DEFAULT NOW(),            -- Cuándo se inició la sesión
    expires_at TIMESTAMP    NOT NULL,                          -- Cuándo vence el token
    is_active  BOOLEAN      NOT NULL DEFAULT TRUE              -- TRUE=sesión vigente, FALSE=cerrada/expirada
);

-- Índices para acelerar consultas frecuentes en sessions
CREATE INDEX IF NOT EXISTS idx_sessions_user_id   ON sessions(user_id);   -- Ver sesiones de un usuario
CREATE INDEX IF NOT EXISTS idx_sessions_token     ON sessions(token);     -- Validar token en cada request
CREATE INDEX IF NOT EXISTS idx_sessions_is_active ON sessions(is_active); -- Filtrar solo sesiones activas


-- ============================================================
-- TABLA 3: audit_log
-- Propósito: bitácora de todas las acciones importantes del sistema.
-- Registra quién hizo qué, sobre quién, cuándo y desde dónde.
-- No se puede modificar ni eliminar (solo INSERT).
-- Sirve para rastrear acciones de admins y usuarios.
--
-- Columnas clave:
--   performed_by → quién ejecutó la acción
--   target_user  → sobre quién recayó la acción (puede ser el mismo)
--   action       → tipo de acción estandarizado (ver CHECK)
--   description  → texto legible que explica qué pasó exactamente
--
-- Relaciones:
--   performed_by → users(id) ON DELETE SET NULL
--   target_user  → users(id) ON DELETE SET NULL
--   Si se elimina el usuario, el log se conserva con NULL
--   (importante para auditoría: el historial no desaparece)
-- ============================================================
CREATE TABLE IF NOT EXISTS audit_log (
    id           BIGSERIAL   PRIMARY KEY,                      -- Identificador único del registro
    performed_by BIGINT                                        -- Usuario que ejecutó la acción
                             REFERENCES users(id)
                             ON DELETE SET NULL,
    target_user  BIGINT                                        -- Usuario sobre quien se ejecutó la acción
                             REFERENCES users(id)
                             ON DELETE SET NULL,
    action       VARCHAR(100) NOT NULL CHECK (action IN (       -- Tipo de acción (valores fijos)
                     'REGISTER',           -- Usuario se registró
                     'LOGIN',              -- Usuario inició sesión
                     'LOGOUT',             -- Usuario cerró sesión
                     'UPDATE_PROFILE',     -- Usuario editó su propio perfil
                     'CHANGE_PASSWORD',    -- Usuario cambió su contraseña
                     'DELETE_ACCOUNT',     -- Usuario eliminó su propia cuenta
                     'ADMIN_CREATE_USER',  -- Admin creó un usuario
                     'ADMIN_UPDATE_USER',  -- Admin editó un usuario
                     'ADMIN_DELETE_USER'   -- Admin eliminó un usuario
                 )),
    description  VARCHAR(500),                                 -- Descripción legible de la acción
    ip_address   VARCHAR(45),                                  -- IP desde donde se ejecutó la acción
    created_at   TIMESTAMP NOT NULL DEFAULT NOW()             -- Cuándo ocurrió la acción
);

-- Índices para acelerar consultas frecuentes en audit_log
CREATE INDEX IF NOT EXISTS idx_audit_performed_by ON audit_log(performed_by); -- Ver acciones de un usuario
CREATE INDEX IF NOT EXISTS idx_audit_target_user  ON audit_log(target_user);  -- Ver acciones sobre un usuario
CREATE INDEX IF NOT EXISTS idx_audit_action       ON audit_log(action);       -- Filtrar por tipo de acción
CREATE INDEX IF NOT EXISTS idx_audit_created_at   ON audit_log(created_at);   -- Ordenar por fecha

ALTER TABLE sessions
ALTER COLUMN user_agent TYPE TEXT;

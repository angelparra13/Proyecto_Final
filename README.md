# Sistema de Gestión de Usuarios y Roles

Aplicación full-stack para administrar usuarios con autenticación JWT, roles (USER/ADMIN) y CRUD completo.

## Tecnologías

| Capa       | Tecnología                            |
|------------|---------------------------------------|
| Backend    | Spring Boot 3.2 · Java 21 · Maven     |
| Frontend   | HTML5 · CSS3 · JavaScript (ES Modules)|
| Base datos | PostgreSQL (Neon)                     |
| Seguridad  | Spring Security · JWT (jjwt 0.11.5)  |

## Requisitos previos

- Java 21+
- Maven 3.9+
- Cuenta en [Neon](https://neon.tech) (PostgreSQL serverless) o PostgreSQL local
- Extensión Live Server en VS Code (para el frontend)

## Configuración de variables de entorno

Crea el archivo `backend/src/main/resources/application.properties` con los valores reales
(está en `.gitignore`, no se sube al repositorio):

```properties
spring.datasource.url=jdbc:postgresql://<host>/<db>?sslmode=require
spring.datasource.username=<usuario>
spring.datasource.password=<contraseña>
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
jwt.secret=<clave-secreta-minimo-32-caracteres>
jwt.expiration=86400000
```

### Variables de entorno alternativas (shell)

```bash
export DATABASE_URL="jdbc:postgresql://..."
export DB_USERNAME="usuario"
export DB_PASSWORD="contraseña"
export JWT_SECRET="mi-clave-super-secreta-de-32-chars"
```

## Base de datos

Ejecutar en orden en Neon (SQL Editor) o psql:

```sql
\i db/schema.sql
\i db/seed.sql
```

> **Nota:** Los hashes BCrypt del seed corresponden a una contraseña de prueba.
> Si los usuarios no pueden iniciar sesión, regenera los hashes con:
> ```java
> BCryptPasswordEncoder enc = new BCryptPasswordEncoder();
> System.out.println(enc.encode("TuPassword"));
> ```

## Cómo correr el backend

```bash
cd backend
mvn spring-boot:run
```

El servidor arranca en `http://localhost:8080`.

## Cómo correr el frontend

1. Abre la carpeta `frontend/` en VS Code.
2. Click derecho sobre `index.html` → **Open with Live Server**.
3. El navegador abre `http://127.0.0.1:5500` y redirige al login.

## Estructura del proyecto

```
proyecto-gestion-usuarios/
├── backend/                        → Spring Boot
│   └── src/main/java/com/proyecto/gestion/
│       ├── entity/                 → User, Role
│       ├── dto/                    → LoginRequest/Response, UserDTO, …
│       ├── repository/             → UserRepository
│       ├── service/                → AuthService, UserService
│       ├── controller/             → AuthController, UserController
│       ├── security/               → JwtUtil, JwtAuthFilter, UserDetailsServiceImpl
│       ├── config/                 → SecurityConfig, JwtConfig
│       └── exception/              → GlobalExceptionHandler, ResourceNotFoundException
├── frontend/
│   ├── pages/                      → login, register, dashboard, admin
│   ├── css/                        → global, auth, dashboard, admin
│   └── js/                         → api, auth, dashboard, profile, admin
├── db/                             → schema.sql, seed.sql
└── docs/
```

## Endpoints de la API

| Método | Ruta                    | Acceso     | Descripción                    |
|--------|-------------------------|------------|--------------------------------|
| POST   | /api/auth/register      | Público    | Registrar nuevo usuario        |
| POST   | /api/auth/login         | Público    | Iniciar sesión, obtener JWT    |
| GET    | /api/users/me           | USER+ADMIN | Obtener perfil propio          |
| PUT    | /api/users/me           | USER+ADMIN | Actualizar nombre / email      |
| PUT    | /api/users/me/password  | USER+ADMIN | Cambiar contraseña             |
| DELETE | /api/users/me           | USER+ADMIN | Eliminar cuenta propia         |
| GET    | /api/users              | ADMIN      | Listar todos los usuarios      |
| POST   | /api/users              | ADMIN      | Crear usuario                  |
| GET    | /api/users/{id}         | ADMIN      | Obtener usuario por ID         |
| PUT    | /api/users/{id}         | ADMIN      | Editar usuario                 |
| DELETE | /api/users/{id}         | ADMIN      | Eliminar usuario               |

## Credenciales de prueba

| Rol   | Email                   | Contraseña   |
|-------|-------------------------|--------------|
| ADMIN | admin@sistema.com       | (ver seed)   |
| USER  | maria.garcia@email.com  | (ver seed)   |

> Regenera los hashes en `db/seed.sql` con `BCryptPasswordEncoder` si es necesario.

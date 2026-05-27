# Especificación de la API

Base URL: `http://localhost:8080`

Todas las rutas protegidas requieren el header:
```
Authorization: Bearer <token>
```

---

## Auth

### POST /api/auth/register
Registra un nuevo usuario con rol USER.

**Body:**
```json
{
  "name": "Juan Pérez",
  "email": "juan@email.com",
  "password": "min6chars"
}
```

**Response 201:**
```json
{
  "id": 1,
  "name": "Juan Pérez",
  "email": "juan@email.com",
  "role": "USER",
  "status": "ACTIVE",
  "createdAt": "2026-05-27T10:00:00",
  "lastLogin": null
}
```

---

### POST /api/auth/login
Autentica al usuario y devuelve un JWT.

**Body:**
```json
{
  "email": "juan@email.com",
  "password": "min6chars"
}
```

**Response 200:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": 1,
    "name": "Juan Pérez",
    "email": "juan@email.com",
    "role": "USER",
    "status": "ACTIVE",
    "createdAt": "2026-05-27T10:00:00",
    "lastLogin": "2026-05-27T12:30:00"
  }
}
```

---

## Usuarios — perfil propio

### GET /api/users/me
Devuelve los datos del usuario autenticado.

**Response 200:** `UserDTO`

---

### PUT /api/users/me
Actualiza nombre y/o email del usuario autenticado.

**Body:**
```json
{ "name": "Nuevo Nombre", "email": "nuevo@email.com" }
```

**Response 200:** `UserDTO` actualizado

---

### PUT /api/users/me/password
Cambia la contraseña del usuario autenticado.

**Body:**
```json
{ "currentPassword": "actual123", "newPassword": "nueva456" }
```

**Response 204:** sin cuerpo

---

### DELETE /api/users/me
Elimina la cuenta del usuario autenticado.

**Response 204:** sin cuerpo

---

## Usuarios — administración (solo ADMIN)

### GET /api/users
Lista todos los usuarios. Acepta query param `?search=texto` para filtrar.

**Response 200:** `UserDTO[]`

---

### POST /api/users
Crea un nuevo usuario.

**Body:** igual que `/api/auth/register`

**Response 201:** `UserDTO`

---

### GET /api/users/{id}
Obtiene un usuario por ID.

**Response 200:** `UserDTO` | **404** si no existe

---

### PUT /api/users/{id}
Actualiza nombre y email de un usuario.

**Body:** `{ "name": "...", "email": "..." }`

**Response 200:** `UserDTO`

---

### DELETE /api/users/{id}
Elimina un usuario por ID.

**Response 204** | **404** si no existe

---

## Códigos de error comunes

| Código | Significado                    |
|--------|--------------------------------|
| 400    | Datos inválidos / bad request  |
| 401    | Token ausente o inválido       |
| 403    | Sin permisos (rol insuficiente)|
| 404    | Recurso no encontrado          |
| 500    | Error interno del servidor     |

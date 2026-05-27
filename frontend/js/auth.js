import { post } from './api.js';

/**
 * Inicia sesión y guarda el token en localStorage.
 * Redirige según el rol del usuario.
 */
export async function login(email, password) {
    const response = await post('/api/auth/login', { email, password });

    localStorage.setItem('token',    response.token);
    localStorage.setItem('role',     response.user.role);
    localStorage.setItem('userId',   response.user.id);
    localStorage.setItem('userName', response.user.name);

    if (response.user.role === 'ADMIN') {
        window.location.href = './admin.html';
    } else {
        window.location.href = './dashboard.html';
    }
}

/**
 * Registra un nuevo usuario (rol USER por defecto).
 */
export async function register(name, email, password) {
    return await post('/api/auth/register', { name, email, password });
}

/**
 * Cierra sesión y redirige al login.
 */
export function logout() {
    localStorage.clear();
    window.location.href = './login.html';
}

/**
 * Verifica que haya un token válido y opcionalmente que el rol coincida.
 * Redirige si no se cumplen las condiciones.
 * @returns {boolean} true si el acceso es válido
 */
export function requireAuth(requiredRole = null) {
    const token = localStorage.getItem('token');
    const role  = localStorage.getItem('role');

    if (!token) {
        window.location.href = './login.html';
        return false;
    }

    if (requiredRole && role !== requiredRole) {
        window.location.href = role === 'ADMIN' ? './admin.html' : './dashboard.html';
        return false;
    }

    return true;
}

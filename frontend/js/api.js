const API_BASE_URL = 'http://localhost:8080';

function getToken() {
    return localStorage.getItem('token');
}

/**
 * Función central de comunicación con el backend.
 * Adjunta automáticamente el Bearer token si existe.
 * Redirige a login si recibe 401.
 */
async function request(method, path, body = null) {
    const headers = { 'Content-Type': 'application/json' };

    const token = getToken();
    if (token) headers['Authorization'] = `Bearer ${token}`;

    const options = { method, headers };
    if (body !== null && method !== 'GET') {
        options.body = JSON.stringify(body);
    }

    let response;
    try {
        response = await fetch(`${API_BASE_URL}${path}`, options);
    } catch (_) {
        throw new Error('No se puede conectar con el servidor. Verifica que el backend esté corriendo en http://localhost:8080');
    }

    if (response.status === 401) {
        localStorage.clear();
        window.location.href = './login.html';
        return;
    }

    if (response.status === 204) return null;

    const data = await response.json().catch(() => null);

    if (!response.ok) {
        const msg = data?.message || `Error ${response.status}: ${response.statusText}`;
        throw new Error(msg);
    }

    return data;
}

export const get  = (path)        => request('GET',    path);
export const post = (path, body)  => request('POST',   path, body);
export const put  = (path, body)  => request('PUT',    path, body);
export const del  = (path)        => request('DELETE', path);

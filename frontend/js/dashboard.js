import { get } from './api.js';
import { requireAuth, logout } from './auth.js';

document.addEventListener('DOMContentLoaded', async () => {
    if (!requireAuth('USER')) return;

    document.getElementById('user-name').textContent =
        localStorage.getItem('userName') || 'Usuario';

    document.getElementById('btn-logout')
        ?.addEventListener('click', logout);

    document.getElementById('btn-profile')
        ?.addEventListener('click', openProfileModal);

    try {
        const user = await get('/api/users/me');
        populateDashboard(user);
    } catch (err) {
        showError(err.message);
    }
});

function populateDashboard(user) {
    const fmt = (d) => d
        ? new Date(d).toLocaleString('es-ES', {
            year: 'numeric', month: 'long', day: 'numeric',
            hour: '2-digit', minute: '2-digit'
          })
        : 'Nunca';

    document.getElementById('user-created').textContent    = fmt(user.createdAt);
    document.getElementById('user-last-login').textContent = fmt(user.lastLogin);
    document.getElementById('user-status-card').textContent = user.status;

    document.getElementById('user-full-name').textContent = user.name;
    document.getElementById('user-email').textContent     = user.email;
    document.getElementById('user-role').textContent      = user.role;
    document.getElementById('user-status').textContent    = user.status;

    // Pre-cargar campos del modal de perfil
    const nameField  = document.getElementById('profile-name');
    const emailField = document.getElementById('profile-email');
    if (nameField)  nameField.value  = user.name;
    if (emailField) emailField.value = user.email;
}

function openProfileModal() {
    const modal = document.getElementById('profile-modal');
    if (modal) modal.style.display = 'flex';
}

function showError(message) {
    const el = document.getElementById('error-message');
    if (el) { el.textContent = message; el.style.display = 'block'; }
}

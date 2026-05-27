import { put, del } from './api.js';
import { logout } from './auth.js';

// ── Abrir / cerrar modal ──────────────────────────────────────────────────

document.getElementById('btn-close-modal')
    ?.addEventListener('click', closeProfileModal);

export function closeProfileModal() {
    const modal = document.getElementById('profile-modal');
    if (modal) modal.style.display = 'none';
    clearErrors();
}

// Cerrar al hacer clic fuera del modal
document.getElementById('profile-modal')
    ?.addEventListener('click', (e) => {
        if (e.target.id === 'profile-modal') closeProfileModal();
    });

// ── Editar datos del perfil ───────────────────────────────────────────────

document.getElementById('profile-form')
    ?.addEventListener('submit', async (e) => {
        e.preventDefault();
        clearErrors();

        const name  = document.getElementById('profile-name').value.trim();
        const email = document.getElementById('profile-email').value.trim();

        try {
            const updated = await put('/api/users/me', { name, email });

            localStorage.setItem('userName', updated.name);
            document.getElementById('user-name').textContent      = updated.name;
            document.getElementById('user-full-name').textContent = updated.name;
            document.getElementById('user-email').textContent     = updated.email;

            showSuccess('Perfil actualizado correctamente');
        } catch (err) {
            showError(err.message);
        }
    });

// ── Cambiar contraseña ────────────────────────────────────────────────────

document.getElementById('password-form')
    ?.addEventListener('submit', async (e) => {
        e.preventDefault();
        clearErrors();

        const currentPassword = document.getElementById('current-password').value;
        const newPassword     = document.getElementById('new-password').value;

        try {
            await put('/api/users/me/password', { currentPassword, newPassword });
            document.getElementById('password-form').reset();
            showSuccess('Contraseña actualizada correctamente');
        } catch (err) {
            showError(err.message);
        }
    });

// ── Eliminar cuenta ───────────────────────────────────────────────────────

document.getElementById('btn-delete-account')
    ?.addEventListener('click', async () => {
        const confirmed = confirm(
            '¿Estás seguro de que deseas eliminar tu cuenta?\nEsta acción no se puede deshacer.'
        );
        if (!confirmed) return;

        try {
            await del('/api/users/me');
            logout();
        } catch (err) {
            showError(err.message);
        }
    });

// ── Helpers ───────────────────────────────────────────────────────────────

function showError(msg) {
    const el = document.getElementById('profile-error');
    if (el) { el.textContent = msg; el.style.display = 'block'; }
}

function showSuccess(msg) {
    const el = document.getElementById('profile-success');
    if (el) {
        el.textContent = msg;
        el.style.display = 'block';
        setTimeout(() => { el.style.display = 'none'; }, 3000);
    }
}

function clearErrors() {
    ['profile-error', 'profile-success'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.style.display = 'none';
    });
}

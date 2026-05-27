import { get, post, put, del } from './api.js';
import { requireAuth, logout } from './auth.js';

let allUsers      = [];
let editingUserId = null;

// ── Init ──────────────────────────────────────────────────────────────────

document.addEventListener('DOMContentLoaded', async () => {
    if (!requireAuth('ADMIN')) return;

    document.getElementById('admin-name').textContent =
        localStorage.getItem('userName') || 'Admin';

    document.getElementById('btn-logout')
        ?.addEventListener('click', logout);

    document.getElementById('btn-create')
        ?.addEventListener('click', openCreateModal);

    document.getElementById('user-form')
        ?.addEventListener('submit', handleFormSubmit);

    setupSearch();
    await loadUsers();
});

// ── Carga de usuarios ─────────────────────────────────────────────────────

async function loadUsers() {
    try {
        allUsers = await get('/api/users');
        renderTable(allUsers);
    } catch (err) {
        showError(err.message);
    }
}

function renderTable(users) {
    const tbody = document.getElementById('users-tbody');
    if (!tbody) return;

    if (!users || users.length === 0) {
        tbody.innerHTML =
            '<tr><td colspan="6" class="text-center text-muted" style="padding:2rem;">No hay usuarios registrados</td></tr>';
        return;
    }

    tbody.innerHTML = users.map(u => `
        <tr>
            <td>${u.id}</td>
            <td>${u.name}</td>
            <td>${u.email}</td>
            <td><span class="badge badge-role-${u.role.toLowerCase()}">${u.role}</span></td>
            <td><span class="badge badge-status-${u.status.toLowerCase()}">${u.status}</span></td>
            <td class="actions">
                <button class="btn btn-sm btn-secondary" onclick="openEditModal(${u.id})">Editar</button>
                <button class="btn btn-sm btn-danger"    onclick="deleteUser(${u.id})">Eliminar</button>
            </td>
        </tr>
    `).join('');
}

// ── Búsqueda en tiempo real ───────────────────────────────────────────────

function setupSearch() {
    document.getElementById('search-input')?.addEventListener('input', (e) => {
        const q = e.target.value.toLowerCase().trim();
        if (!q) { renderTable(allUsers); return; }
        renderTable(allUsers.filter(u =>
            u.name.toLowerCase().includes(q) || u.email.toLowerCase().includes(q)
        ));
    });
}

// ── Modal crear ───────────────────────────────────────────────────────────

window.openCreateModal = function () {
    editingUserId = null;
    document.getElementById('modal-title').textContent = 'Crear usuario';
    document.getElementById('user-form').reset();
    document.getElementById('password-field').style.display = 'block';
    document.getElementById('form-error').style.display     = 'none';
    document.getElementById('user-modal').style.display     = 'flex';
};

// ── Modal editar ──────────────────────────────────────────────────────────

window.openEditModal = async function (id) {
    try {
        editingUserId = id;
        const user = await get(`/api/users/${id}`);

        document.getElementById('modal-title').textContent  = 'Editar usuario';
        document.getElementById('form-name').value          = user.name;
        document.getElementById('form-email').value         = user.email;
        document.getElementById('password-field').style.display = 'none';
        document.getElementById('form-error').style.display     = 'none';
        document.getElementById('user-modal').style.display     = 'flex';
    } catch (err) {
        showError(err.message);
    }
};

// ── Cerrar modal ──────────────────────────────────────────────────────────

window.closeModal = function () {
    document.getElementById('user-modal').style.display = 'none';
};

document.getElementById('user-modal')
    ?.addEventListener('click', (e) => {
        if (e.target.id === 'user-modal') closeModal();
    });

// ── Guardar usuario (crear o editar) ─────────────────────────────────────

async function handleFormSubmit(e) {
    e.preventDefault();
    const errEl = document.getElementById('form-error');
    errEl.style.display = 'none';

    const name  = document.getElementById('form-name').value.trim();
    const email = document.getElementById('form-email').value.trim();

    try {
        if (editingUserId) {
            await put(`/api/users/${editingUserId}`, { name, email });
        } else {
            const password = document.getElementById('form-password').value;
            await post('/api/users', { name, email, password });
        }
        closeModal();
        await loadUsers();
    } catch (err) {
        errEl.textContent   = err.message;
        errEl.style.display = 'block';
    }
}

// ── Eliminar usuario ──────────────────────────────────────────────────────

window.deleteUser = async function (id) {
    if (!confirm(`¿Eliminar el usuario con ID ${id}? Esta acción no se puede deshacer.`)) return;
    try {
        await del(`/api/users/${id}`);
        await loadUsers();
    } catch (err) {
        showError(err.message);
    }
};

// ── Helpers ───────────────────────────────────────────────────────────────

function showError(msg) {
    const el = document.getElementById('error-message');
    if (el) { el.textContent = msg; el.style.display = 'block'; }
}

package com.proyecto.gestion.service;

import com.proyecto.gestion.dto.ChangePasswordRequest;
import com.proyecto.gestion.dto.RegisterRequest;
import com.proyecto.gestion.dto.UpdateUserRequest;
import com.proyecto.gestion.dto.UserDTO;
import com.proyecto.gestion.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserDTO getCurrentUser(UserDetails userDetails) {
        // TODO: buscar user por email desde userDetails.getUsername(), mapear a UserDTO
        return null;
    }

    public UserDTO updateCurrentUser(UserDetails userDetails, UpdateUserRequest request) {
        // TODO: buscar user, validar email único si cambió, actualizar name/email, guardar
        return null;
    }

    public void changePassword(UserDetails userDetails, ChangePasswordRequest request) {
        // TODO: verificar currentPassword con BCrypt, hashear newPassword, guardar
    }

    public void deleteCurrentUser(UserDetails userDetails) {
        // TODO: buscar user por email, eliminar
    }

    public List<UserDTO> getAllUsers(String search) {
        // TODO: si search es null/vacío devolver todos; si no, filtrar por nombre o email
        return null;
    }

    public UserDTO getUserById(Long id) {
        // TODO: findById o lanzar ResourceNotFoundException, mapear a UserDTO
        return null;
    }

    public UserDTO createUser(RegisterRequest request) {
        // TODO: validar email único, hashear password, rol default USER, guardar
        return null;
    }

    public UserDTO updateUser(Long id, UpdateUserRequest request) {
        // TODO: buscar por id, actualizar campos, guardar
        return null;
    }

    public void deleteUser(Long id) {
        // TODO: verificar que existe, eliminar
    }
}

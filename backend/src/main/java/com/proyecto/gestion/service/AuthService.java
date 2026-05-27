package com.proyecto.gestion.service;

import com.proyecto.gestion.dto.LoginRequest;
import com.proyecto.gestion.dto.LoginResponse;
import com.proyecto.gestion.dto.RegisterRequest;
import com.proyecto.gestion.dto.UserDTO;
import com.proyecto.gestion.repository.UserRepository;
import com.proyecto.gestion.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    public UserDTO register(RegisterRequest request) {
        // TODO: validar email único, hashear password, guardar usuario, retornar UserDTO
        return null;
    }

    public LoginResponse login(LoginRequest request) {
        // TODO: buscar usuario por email, validar password con BCrypt, generar JWT, actualizar lastLogin
        return null;
    }
}

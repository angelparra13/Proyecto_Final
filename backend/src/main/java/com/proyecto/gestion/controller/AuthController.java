package com.proyecto.gestion.controller;

import com.proyecto.gestion.dto.LoginRequest;
import com.proyecto.gestion.dto.LoginResponse;
import com.proyecto.gestion.dto.RegisterRequest;
import com.proyecto.gestion.dto.UserDTO;
import com.proyecto.gestion.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<UserDTO> register(@Valid @RequestBody RegisterRequest request) {
        // TODO: llamar authService.register(request)
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@Valid @RequestBody LoginRequest request) {
        // TODO: llamar authService.login(request)
        return ResponseEntity.ok().build();
    }
}

package com.proyecto.gestion.security;

import com.proyecto.gestion.config.JwtConfig;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;

@Component
public class JwtUtil {

    @Autowired
    private JwtConfig jwtConfig;

    public String generateToken(String email, String role) {
        // TODO: Jwts.builder() con subject=email, claim("role", role),
        //       issuedAt=now, expiration=now+jwtConfig.getExpiration(), signWith(getSigningKey())
        return null;
    }

    public boolean validateToken(String token) {
        // TODO: parsear el token con getSigningKey(), retornar true si no lanza excepción
        return false;
    }

    public String extractEmail(String token) {
        // TODO: extraer Claims del token y retornar getSubject()
        return null;
    }

    public String extractRole(String token) {
        // TODO: extraer Claims y retornar claim "role" como String
        return null;
    }

    private Key getSigningKey() {
        // TODO: Keys.hmacShaKeyFor(jwtConfig.getSecret().getBytes(StandardCharsets.UTF_8))
        return null;
    }

    private Claims extractAllClaims(String token) {
        // TODO: Jwts.parserBuilder().setSigningKey(getSigningKey()).build().parseClaimsJws(token).getBody()
        return null;
    }
}

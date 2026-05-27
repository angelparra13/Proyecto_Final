package com.proyecto.gestion.security;

import com.proyecto.gestion.entity.User;
import com.proyecto.gestion.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // TODO:
        // 1. userRepository.findByEmail(email).orElseThrow(...)
        // 2. Construir org.springframework.security.core.userdetails.User con:
        //    - email como username
        //    - password hasheado
        //    - authority "ROLE_" + user.getRole().name()
        return null;
    }
}

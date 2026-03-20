package com.auth.jwt.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.auth.jwt.service.AuthService;

@RestController
@RequestMapping("/api/profile")
public class ProfileController {
    
    private final AuthService authService;
    
    public ProfileController(AuthService authService) {
        this.authService = authService;
    }
    
    @GetMapping
    public ResponseEntity<?> getProfile(@AuthenticationPrincipal UserDetails userDetails) {
        try {
            // Get user ID from JWT or database
            var user = ((org.springframework.security.core.userdetails.User) userDetails);
            // In a real application, you would extract the user ID from the JWT token
            // For now, we'll fetch from database using username
            var profile = authService.getProfileByUsername(user.getUsername());
            return ResponseEntity.ok(profile);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new ErrorResponse(e.getMessage()));
        }
    }
    
    record ErrorResponse(String message) {}
}

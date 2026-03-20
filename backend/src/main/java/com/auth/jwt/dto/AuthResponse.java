package com.auth.jwt.dto;

public class AuthResponse {
    private Long id;
    private String username;
    private String email;
    private String token;
    private String tokenType = "Bearer";
    private long expiresIn;
    
    // Constructors
    public AuthResponse() {}
    
    public AuthResponse(Long id, String username, String email, String token, String tokenType, long expiresIn) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.token = token;
        this.tokenType = tokenType;
        this.expiresIn = expiresIn;
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }
    
    public String getTokenType() { return tokenType; }
    public void setTokenType(String tokenType) { this.tokenType = tokenType; }
    
    public long getExpiresIn() { return expiresIn; }
    public void setExpiresIn(long expiresIn) { this.expiresIn = expiresIn; }
}

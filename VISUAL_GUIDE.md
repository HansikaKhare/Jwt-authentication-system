# 🎨 Application Flow & Screenshots Guide

## Application Workflow

```
┌─────────────────┐
│  Login Page     │
│  (login.html)   │
└────────┬────────┘
         │
         ├─► New User? ──► Register Page ──► Create Account
         │                  (register.html)       │
         │                                        │
         │◄───────────────────────────────────────┘
         │
         ▼
    Enter Credentials
         │
         ▼
    POST /api/auth/login
         │
         ▼
    Backend Validates
         │
         ├─ Invalid ──► Show Error Message
         │
         ▼
      Valid
         │
         ▼
    Generate JWT Token
         │
         ▼
    Store in localStorage
         │
         ▼
┌─────────────────┐
│  Profile Page   │
│  (profile.html) │◄── Requires JWT Token
└────────┬────────┘
         │
         ▼
    Display User Info
         │
         ▼
    Logout Button
         │
         ▼
    Clear Token
         │
         ▼
    Redirect to Login
```

---

## Page 1: Login Page (login.html)

### Layout
```
╔════════════════════════════════════╗
║                                    ║
║        ┌──────────────────┐        ║
║        │     Login        │        ║
║        ├──────────────────┤        ║
║        │                  │        ║
║        │ Username/Email   │        ║
║        │ [____________]   │        ║
║        │                  │        ║
║        │ Password         │        ║
║        │ [____________]   │        ║
║        │                  │        ║
║        │  [   Login   ]   │        ║
║        │                  │        ║
║        │ Don't have an    │        ║
║        │ account? Register│        ║
║        └──────────────────┘        ║
║                                    ║
╚════════════════════════════════════╝
```

### Features
- Beautiful gradient background (purple to violet)
- Clean white card design
- Input validation
- Error message display
- Link to registration page
- Responsive design

---

## Page 2: Registration Page (register.html)

### Layout
```
╔════════════════════════════════════╗
║                                    ║
║        ┌──────────────────┐        ║
║        │    Register      │        ║
║        ├──────────────────┤        ║
║        │                  │        ║
║        │ Username         │        ║
║        │ [____________]   │        ║
║        │                  │        ║
║        │ Email            │        ║
║        │ [____________]   │        ║
║        │                  │        ║
║        │ Password         │        ║
║        │ [____________]   │        ║
║        │                  │        ║
║        │  [  Register ]   │        ║
║        │                  │        ║
║        │ Have an account? │        ║
║        │     Login        │        ║
║        └──────────────────┘        ║
║                                    ║
╚════════════════════════════════════╝
```

### Features
- Username validation (min 3 chars)
- Email format validation
- Password strength (min 6 chars)
- Success/error messages
- Auto-login after registration
- Link to login page

---

## Page 3: Profile Page (profile.html)

### Layout
```
╔════════════════════════════════════╗
║                                    ║
║        ┌──────────────────┐        ║
║        │  User Profile    │        ║
║        ├──────────────────┤        ║
║        │                  │        ║
║        │ User ID          │        ║
║        │ 1                │        ║
║        │                  │        ║
║        │ Username         │        ║
║        │ testuser         │        ║
║        │                  │        ║
║        │ Email            │        ║
║        │ test@example.com │        ║
║        │                  │        ║
║        │ Role             │        ║
║        │ ROLE_USER        │        ║
║        │                  │        ║
║        │ Account Status   │        ║
║        │ Active           │        ║
║        │                  │        ║
║        │  [  Logout  ]    │        ║
║        └──────────────────┘        ║
║                                    ║
╚════════════════════════════════════╝
```

### Features
- Displays all user information
- Protected by JWT authentication
- Auto-redirect if not logged in
- Logout functionality
- Clean information cards
- Token validation

---

## Authentication Flow Diagram

```
┌──────────────┐
│   Frontend   │
│  (Browser)   │
└──────┬───────┘
       │
       │ 1. User enters credentials
       ▼
┌──────────────┐
│  login.js    │
│  Collects    │
│  form data   │
└──────┬───────┘
       │
       │ 2. Calls api.login()
       ▼
┌──────────────┐
│   auth.js    │
│  Prepares    │
│   request    │
└──────┬───────┘
       │
       │ 3. POST /api/auth/login
       │    {username, password}
       ▼
┌──────────────┐
│   Backend    │
│ Spring Boot  │
└──────┬───────┘
       │
       │ 4. Authenticate
       ▼
┌──────────────┐
│AuthService   │
│ validate user │
└──────┬───────┘
       │
       │ 5. Hash password check
       ▼
┌──────────────┐
│ UserRepository│
│  Find user   │
└──────┬───────┘
       │
       │ 6. User found
       ▼
┌──────────────┐
│  JwtService  │
│ Generate token│
└──────┬───────┘
       │
       │ 7. Return JWT token
       ▼
┌──────────────┐
│   Frontend   │
│Receive token │
└──────┬───────┘
       │
       │ 8. Store in localStorage
       ▼
┌──────────────┐
│  profile.js  │
│Redirect user │
└──────┬───────┘
       │
       │ 9. GET /api/profile
       │    Authorization: Bearer <token>
       ▼
┌──────────────┐
│   Backend    │
│Validate token│
└──────┬───────┘
       │
       │ 10. Return user profile
       ▼
┌──────────────┐
│Display profile│
│   to user    │
└──────────────┘
```

---

## JWT Token Flow

```
Registration/Login
       │
       ▼
┌─────────────────────────┐
│  Backend generates JWT  │
│                         │
│  Header:                │
│  {                      │
│    "alg": "HS256",      │
│    "typ": "JWT"         │
│  }                      │
│                         │
│  Payload:               │
│  {                      │
│    "userId": 1,         │
│    "username": "user",  │
│    "email": "...",      │
│    "role": "ROLE_USER", │
│    "exp": 1234567890    │
│  }                      │
│                         │
│  Signature:             │
│  HMACSHA256(            │
│    base64UrlEncode(header) + "." +
│    base64UrlEncode(payload),
│    secret-key           │
│  )                      │
└─────────────────────────┘
       │
       ▼
  Base64 encoded
       │
       ▼
eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsInVzZXJuYW1lIjoidGVzdHVzZXIiLCJlbWFpbCI6InRlc3RAZXhhbXBsZS5jb20iLCJyb2xlIjoiUk9MRV9VU0VSIiwiZXhwIjoxNzM1Njg5NjAwfQ.signature
       │
       ▼
  Sent to frontend
       │
       ▼
Stored in localStorage
       │
       ▼
Included in requests:
Authorization: Bearer <token>
       │
       ▼
Backend validates:
1. Check signature
2. Check expiration
3. Extract user info
       │
       ▼
Return protected resource
```

---

## Database Schema

```
┌────────────────────────────────────┐
│            USERS Table             │
├────────────────────────────────────┤
│ id (BIGINT, PK, AUTO_INCREMENT)    │
│ username (VARCHAR, UNIQUE, NOT NULL)│
│ email (VARCHAR, UNIQUE, NOT NULL)  │
│ password (VARCHAR, NOT NULL)       │ ← BCrypt hashed
│ role (VARCHAR, DEFAULT 'ROLE_USER')│
│ enabled (BOOLEAN, DEFAULT TRUE)    │
│ created_at (TIMESTAMP)             │
│ updated_at (TIMESTAMP)             │
└────────────────────────────────────┘

Sample Data:
+----+----------+------------------+--------------+-----------+---------+
| id | username | email            | password     | role      | enabled |
+----+----------+------------------+--------------+-----------+---------+
| 1  | testuser | test@example.com | $2a$10$...   | ROLE_USER | TRUE    |
+----+----------+------------------+--------------+-----------+---------+
```

---

## Security Layers

```
┌─────────────────────────────────────┐
│   Layer 1: Frontend Validation      │
│   - Required fields                 │
│   - Email format                    │
│   - Password length                 │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│   Layer 2: Backend Validation       │
│   - @Valid annotations              │
│   - Business logic checks           │
│   - Duplicate check                 │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│   Layer 3: Password Security        │
│   - BCrypt hashing                  │
│   - Automatic salting               │
│   - Never stored plain text         │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│   Layer 4: JWT Authentication       │
│   - Signed tokens                   │
│   - Expiration check                │
│   - Signature validation            │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│   Layer 5: Spring Security          │
│   - Filter chain                    │
│   - Role-based access               │
│   - CSRF protection                 │
└─────────────────────────────────────┘
```

---

## File Upload/Download Flow

Not implemented (authentication only)

---

## Error Handling Flow

```
User Action
    │
    ▼
API Request
    │
    ▼
Error Occurs?
    │
    ├─ Yes (400 Bad Request)
    │   │
    │   ▼
    │  Show error message
    │  "Invalid credentials"
    │
    ├─ Yes (401 Unauthorized)
    │   │
    │   ▼
    │  Clear token
    │  Redirect to login
    │
    ├─ Yes (403 Forbidden)
    │   │
    │   ▼
    │  Access denied
    │
    └─ No (Success)
        │
        ▼
       Process response
       Update UI
```

---

## Technology Stack Visualization

```
┌───────────────────────────────────────────┐
│           PRESENTATION LAYER              │
│  ┌─────────────────────────────────────┐  │
│  │  HTML5 Pages                        │  │
│  │  - login.html                       │  │
│  │  - register.html                    │  │
│  │  - profile.html                     │  │
│  └─────────────────────────────────────┘  │
│  ┌─────────────────────────────────────┐  │
│  │  CSS3 Styling                       │  │
│  │  - Responsive design                │  │
│  │  - Gradient backgrounds             │  │
│  │  - Modern UI components             │  │
│  └─────────────────────────────────────┘  │
│  ┌─────────────────────────────────────┐  │
│  │  JavaScript (ES6+)                  │  │
│  │  - Fetch API                        │  │
│  │  - Async/await                      │  │
│  │  - localStorage                     │  │
│  └─────────────────────────────────────┘  │
└───────────────────────────────────────────┘
                    │
                    │ HTTP/JSON
                    ▼
┌───────────────────────────────────────────┐
│           APPLICATION LAYER               │
│  ┌─────────────────────────────────────┐  │
│  │  Spring Boot 3.2.0                  │  │
│  │  - REST Controllers                 │  │
│  │  - Service Layer                    │  │
│  │  - Repository Layer                 │  │
│  └─────────────────────────────────────┘  │
│  ┌─────────────────────────────────────┐  │
│  │  Spring Security                    │  │
│  │  - Authentication Manager           │  │
│  │  - Security Filters                 │  │
│  │  - Password Encoder                 │  │
│  └─────────────────────────────────────┘  │
│  ┌─────────────────────────────────────┐  │
│  │  JWT Implementation                 │  │
│  │  - Token Generation                 │  │
│  │  - Token Validation                 │  │
│  │  - Claim Extraction                 │  │
│  └─────────────────────────────────────┘  │
└───────────────────────────────────────────┘
                    │
                    │ JPA/Hibernate
                    ▼
┌───────────────────────────────────────────┐
│            DATA LAYER                     │
│  ┌─────────────────────────────────────┐  │
│  │  H2 Database (Dev)                  │  │
│  │  - In-memory storage                │  │
│  │  - Web console available            │  │
│  └─────────────────────────────────────┘  │
│  ┌─────────────────────────────────────┐  │
│  │  MySQL (Production Ready)           │  │
│  │  - Persistent storage               │  │
│  │  - Production configuration         │  │
│  └─────────────────────────────────────┘  │
└───────────────────────────────────────────┘
```

---

This visual guide helps understand the complete flow of the JWT authentication system!

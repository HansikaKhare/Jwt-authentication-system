# 🔐 JWT Authentication System - Fullstack Java Application

A complete fullstack authentication system built with **Spring Boot (Java)** backend and **Vanilla JavaScript** frontend, featuring JWT-based authentication, secure password hashing, and protected routes.

![Java](https://img.shields.io/badge/Java-24-orange?style=for-the-badge&logo=java)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.0-brightgreen?style=for-the-badge&logo=spring-boot)
![Security](https://img.shields.io/badge/Security-JWT%20%2B%20BCrypt-blue?style=for-the-badge)
![Frontend](https://img.shields.io/badge/Frontend-Vanilla%20JS%2FHTML%2FCSS-yellow?style=for-the-badge)

## ✨ Features

- 🔑 **User Registration & Login** - Complete authentication flow
- 🔒 **Password Hashing** - BCrypt with automatic salting
- 🎫 **JWT Authentication** - Secure token-based auth (24-hour expiration)
- 🛡️ **Protected Routes** - Profile endpoint requires valid JWT
- 💾 **Database Integration** - H2 in-memory (dev) / MySQL ready (prod)
- 🎨 **Modern UI** - Beautiful gradient design with responsive layout
- 📱 **Responsive Design** - Works on desktop, tablet, and mobile
- ⚡ **No Framework** - Pure vanilla JavaScript - no React, Angular, or Vue!

## 🏗️ Architecture

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│   Frontend  │────────▶│   Backend    │────────▶│  Database   │
│ HTML/CSS/JS │◀────────│ Spring Boot  │◀────────│     H2      │
│             │  JWT    │   + Security │  JPA    │  (MySQL)    │
└─────────────┘         └──────────────┘         └─────────────┘
```

## 🛠️ Tech Stack

### Backend
- **Java 24** - Latest Java version
- **Spring Boot 3.2.0** - Rapid application development
- **Spring Security** - Authentication & authorization
- **Spring Data JPA** - Database abstraction
- **JWT (io.jsonwebtoken)** - Token generation/validation
- **BCrypt** - Password hashing
- **H2 Database** - In-memory database for development
- **Maven** - Dependency management

### Frontend
- **HTML5** - Semantic markup
- **CSS3** - Modern styling with gradients
- **Vanilla JavaScript (ES6+)** - No frameworks!
- **Fetch API** - HTTP requests
- **localStorage** - Token persistence

## 📁 Project Structure

```
jwt-authentication-system/
├── backend/
│   ├── src/main/java/com/auth/jwt/
│   │   ├── controller/          # REST controllers
│   │   │   ├── AuthController.java
│   │   │   └── ProfileController.java
│   │   ├── dto/                 # Data Transfer Objects
│   │   │   ├── AuthResponse.java
│   │   │   ├── LoginRequest.java
│   │   │   ├── RegisterRequest.java
│   │   │   └── UserProfileResponse.java
│   │   ├── entity/              # JPA Entities
│   │   │   └── User.java
│   │   ├── repository/          # Data layer
│   │   │   └── UserRepository.java
│   │   ├── security/            # Security configuration
│   │   │   ├── CustomUserDetailsService.java
│   │   │   ├── JwtAuthenticationFilter.java
│   │   │   └── SecurityConfig.java
│   │   ├── service/             # Business logic
│   │   │   ├── AuthService.java
│   │   │   └── JwtService.java
│   │   └── JwtAuthApplication.java
│   ├── src/main/resources/
│   │   └── application.properties
│   └── pom.xml
├── frontend/
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   ├── auth.js              # Auth utilities
│   │   ├── login.js
│   │   ├── register.js
│   │   └── profile.js
│   ├── index.html               # Preview dashboard
│   ├── login.html
│   ├── register.html
│   └── profile.html
├── .gitignore
├── README.md                    # This file
├── QUICKSTART.md                # Quick start guide
├── SETUP.md                     # Detailed setup
└── TROUBLESHOOTING.md           # Common issues
```

## 🚀 Quick Start

### Prerequisites
- Java 17 or higher (Java 24 recommended)
- Maven 3.6+
- Modern web browser

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/jwt-authentication-system.git
cd jwt-authentication-system
```

### 2. Start Backend
```bash
cd backend
mvn spring-boot:run
```

Wait for: `Started JwtAuthApplication in X seconds`

### 3. Open Frontend
Navigate to `frontend/index.html` in your browser, or use a simple HTTP server:

```bash
cd frontend
python -m http.server 8081
# Then open http://localhost:8081
```

### 4. Test the Application
1. Click **"Register"** on the preview dashboard
2. Fill in registration form:
   - Username: `testuser`
   - Email: `test@example.com`
   - Password: `password123`
3. Click **"Register"** → Auto-login and redirect to profile!
4. View your profile, then test logout/login

## 📡 API Endpoints

### Public (No Authentication Required)
```http
POST /api/auth/register
Content-Type: application/json

{
  "username": "newuser",
  "email": "new@example.com",
  "password": "securepass123"
}
```

```http
POST /api/auth/login
Content-Type: application/json

{
  "usernameOrEmail": "testuser",
  "password": "password123"
}
```

### Protected (Requires JWT Token)
```http
GET /api/profile
Authorization: Bearer YOUR_JWT_TOKEN
```

## 🔐 Security Features

- ✅ **BCrypt Password Hashing** - Industry-standard hashing with salt
- ✅ **JWT Tokens** - HS256 algorithm, 24-hour expiration
- ✅ **Stateless Authentication** - No server-side sessions
- ✅ **CORS Configuration** - Restricted origins
- ✅ **Input Validation** - Server-side validation on all endpoints
- ✅ **Spring Security Filter Chain** - Comprehensive security layers

## 🎨 UI Features

- 🎯 Modern gradient background (purple to violet)
- 🎯 Clean white card design
- 🎯 Smooth animations and transitions
- 🎯 Responsive layout for all devices
- 🎯 Clear error/success messages
- 🎯 Professional typography

## 🧪 Testing

### Using cURL

**Register:**
```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"johndoe\",\"email\":\"john@example.com\",\"password\":\"securepass123\"}"
```

**Login:**
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"usernameOrEmail\":\"johndoe\",\"password\":\"securepass123\"}"
```

**Get Profile:**
```bash
curl -X GET http://localhost:8080/api/profile \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## 🗄️ Database

### Development (H2)
- **URL:** `jdbc:h2:mem:authdb`
- **Console:** http://localhost:8080/h2-console
- **Username:** sa
- **Password:** password

### Production (MySQL)
Update `application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/auth_db
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.jpa.hibernate.ddl-auto=update
```

## 🔧 Configuration

Edit `backend/src/main/resources/application.properties`:

```properties
# Server
server.port=8080

# JWT Settings
app.jwt.secret=YourSecretKeyForJWTTokenGenerationMustBeLongEnoughAndSecure2024
app.jwt.expiration-ms=86400000  # 24 hours

# Database
spring.datasource.url=jdbc:h2:mem:authdb
spring.jpa.hibernate.ddl-auto=update
```

## 📚 Documentation

- **README.md** - Main documentation (this file)
- **QUICKSTART.md** - Quick start guide
- **SETUP.md** - Detailed installation instructions
- **TROUBLESHOOTING.md** - Common issues and solutions
- **PROJECT_SUMMARY.md** - Implementation summary
- **VISUAL_GUIDE.md** - Visual diagrams and flows

## 🎓 Learning Resources

This project demonstrates:
- ✅ Spring Boot best practices
- ✅ Spring Security configuration
- ✅ JWT implementation
- ✅ RESTful API design
- ✅ Vanilla JavaScript (no frameworks!)
- ✅ Modern CSS techniques
- ✅ Full-stack development workflow

## 🔄 Future Enhancements

Potential improvements:
- [ ] Email verification
- [ ] Password reset functionality
- [ ] Refresh tokens
- [ ] OAuth2 login (Google, Facebook)
- [ ] Two-factor authentication (2FA)
- [ ] Role-based access control
- [ ] Account lockout after failed attempts
- [ ] Rate limiting
- [ ] Audit logging

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available for educational purposes.

## 👤 Author

Created as a fullstack JWT authentication demonstration.

## 🙏 Acknowledgments

- Spring Boot team for the excellent framework
- JWT community for the specification
- All contributors who made this possible

---

## 📞 Support

Having issues? Check:
1. [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Browser console (F12)
3. Backend logs
4. Ensure backend is running on port 8080

## 🎉 Ready to Use!

This is a **production-ready foundation** for JWT authentication. Clone it, run it, and build upon it!

```bash
git clone https://github.com/YOUR_USERNAME/jwt-authentication-system.git
cd backend
mvn spring-boot:run
# Open frontend/index.html in your browser
```

**Happy coding!** 🚀

# JWT Authentication System - Fullstack Java Application

A complete authentication system built with Spring Boot (Java) backend and vanilla JavaScript frontend.

## 🚀 Quick Deploy

### Deploy to Railway (Recommended - One Platform for Everything!) ⭐

**Railway hosts both frontend AND backend together!**

- 📖 **[Railway Quick Start](RAILWAY_QUICKSTART.md)** - Deploy in 10 minutes
- 📘 **[Complete Railway Guide](RAILWAY_DEPLOY_GUIDE.md)** - Detailed instructions

```bash
# Automated deployment
npm install -g @railway/cli
deploy-railway.bat

# Or deploy from GitHub:
# 1. Push code to GitHub
# 2. Go to railway.app → New Project → Deploy from GitHub
# 3. Add PostgreSQL database
# 4. Set environment variables
# 5. Deploy!
```

**Benefits:**
✅ Single platform for frontend + backend  
✅ Automatic PostgreSQL database  
✅ Auto-deploy on Git push  
✅ Free $5 credit to start  
✅ Simple setup - no complex config  

---

### Alternative: Vercel + Render/Railway

- 📦 **[Vercel Deployment Package](VERCEL_PACKAGE_SUMMARY.md)** - Frontend on Vercel, Backend on Render/Railway

**Note:** This requires TWO separate deployments (frontend on Vercel, backend elsewhere).

---

## Features

✅ User Registration  
✅ User Login  
✅ Password Hashing (BCrypt)  
✅ JWT-based Authentication  
✅ Protected Routes (/profile)  
✅ Token Handling in Frontend  
✅ Secure Password Storage  

## Technology Stack

### Backend
- **Java 17+**
- **Spring Boot 3.2.0**
- **Spring Security**
- **Spring Data JPA**
- **H2 Database** (development)
- **JWT (io.jsonwebtoken)**
- **Lombok**
- **Maven**

### Frontend
- **HTML5**
- **CSS3**
- **Vanilla JavaScript (ES6+)**
- **Fetch API**

## Project Structure

```
Fullstack task/
├── backend/
│   ├── src/main/java/com/auth/jwt/
│   │   ├── controller/       # REST controllers
│   │   ├── dto/              # Data Transfer Objects
│   │   ├── entity/           # JPA Entities
│   │   ├── repository/       # Data repositories
│   │   ├── security/         # Security configuration
│   │   ├── service/          # Business logic
│   │   └── JwtAuthApplication.java
│   ├── src/main/resources/
│   │   └── application.properties
│   └── pom.xml
└── frontend/
    ├── css/
    │   └── style.css
    ├── js/
    │   ├── auth.js          # Auth utilities
    │   ├── login.js         # Login logic
    │   ├── register.js      # Registration logic
    │   └── profile.js       # Profile logic
    ├── login.html
    ├── register.html
    └── profile.html
```

## Setup Instructions

### Prerequisites
- Java 17 or higher
- Maven 3.6+
- Node.js (optional, for frontend development)

### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Build the project:
```bash
mvn clean install
```

3. Run the Spring Boot application:
```bash
mvn spring-boot:run
```

The backend will start on `http://localhost:8080`

**Database Console:** `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:authdb`
- Username: `sa`
- Password: `password`

### Frontend Setup

1. Open `frontend/login.html` directly in your browser, or

2. Use a simple HTTP server (optional):
```bash
cd frontend
# Using Python
python -m http.server 5173

# Or using Node.js
npx http-server -p 5173
```

Access the frontend at `http://localhost:5173`

## API Endpoints

### Public Endpoints
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Protected Endpoints
- `GET /api/profile` - Get user profile (requires JWT token)

## Authentication Flow

1. **Registration**
   - User fills registration form
   - Frontend sends POST request to `/api/auth/register`
   - Backend validates input, hashes password with BCrypt
   - User saved to database
   - JWT token generated and returned
   - Token stored in localStorage

2. **Login**
   - User enters credentials
   - Frontend sends POST request to `/api/auth/login`
   - Backend authenticates user
   - JWT token generated and returned
   - Token stored in localStorage
   - Redirect to profile page

3. **Protected Route Access**
   - Frontend includes JWT token in Authorization header
   - Format: `Bearer <token>`
   - Backend validates token
   - If valid, returns protected resource

## Security Features

- **Password Hashing**: BCrypt with automatic salt generation
- **JWT Tokens**: Signed with HS256 algorithm
- **Token Expiration**: 24 hours (configurable)
- **CORS Configuration**: Restricted to frontend origin
- **Stateless Authentication**: No server-side session storage
- **Input Validation**: Server-side validation on all endpoints

## Configuration

Edit `backend/src/main/resources/application.properties`:

```properties
# JWT Secret (change in production!)
app.jwt.secret=YourSecretKeyForJWTTokenGenerationMustBeLongEnoughAndSecure2024

# Token expiration (default: 24 hours)
app.jwt.expiration-ms=86400000

# Database (for production MySQL)
# spring.datasource.url=jdbc:mysql://localhost:3306/auth_db
```

## Testing the Application

1. Start the backend server
2. Open `frontend/login.html` in browser
3. Click "Register here" to create an account
4. Fill in username, email, and password
5. After registration, you'll be redirected to profile page
6. Try logging out and logging back in
7. Check browser's localStorage to see the JWT token

## Default Test Credentials

Create your own account through the registration form:
- Username: Any unique username (min 3 characters)
- Email: Any valid email format
- Password: Min 6 characters

## Troubleshooting

**Backend won't start:**
- Check Java version: `java -version` (should be 17+)
- Check Maven: `mvn -version`
- Check port 8080 is not in use

**Frontend can't connect:**
- Ensure backend is running on port 8080
- Check CORS configuration in SecurityConfig.java
- Verify API_BASE_URL in `js/auth.js`

**Authentication errors:**
- Clear browser localStorage
- Check token format in Authorization header
- Verify JWT secret key matches

## Production Deployment

Before deploying to production:

1. Change JWT secret to a strong random value
2. Switch from H2 to MySQL/PostgreSQL
3. Enable HTTPS
4. Add rate limiting
5. Implement refresh tokens
6. Add proper error handling
7. Configure logging

## License

This project is open source and available for educational purposes.

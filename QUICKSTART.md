# Quick Start Guide - JWT Authentication System

## Prerequisites

Before running the application, ensure you have:

1. **Java 17 or higher** installed
   - Check: `java -version`
   - Download: https://adoptium.net/

2. **Maven 3.6+** installed (optional, if not using IDE)
   - Check: `mvn -version`
   - Download: https://maven.apache.org/download.cgi

3. **IDE** (recommended)
   - IntelliJ IDEA, Eclipse, or VS Code with Java extensions

## Running the Application

### Option 1: Using Batch Scripts (Windows)

1. **Start Backend:**
   - Double-click `start-backend.bat`
   - Or run in terminal: `.\start-backend.bat`
   - Wait for "Started JwtAuthApplication" message

2. **Start Frontend:**
   - Double-click `start-frontend.bat`
   - Or run in terminal: `.\start-frontend.bat`
   - Login page will open in your browser

### Option 2: Using Command Line

1. **Start Backend:**
   ```bash
   cd backend
   mvn spring-boot:run
   ```

2. **Open Frontend:**
   - Open `frontend/login.html` in your web browser
   - Or serve it with a simple HTTP server:
   ```bash
   cd frontend
   python -m http.server 5173
   ```
   - Then navigate to: http://localhost:5173

### Option 3: Using IDE

1. **Backend:**
   - Open `backend` folder in your IDE
   - Run `JwtAuthApplication.java`

2. **Frontend:**
   - Open `frontend/login.html` in browser

## Testing the Application

### 1. Register a New User

1. Navigate to login page
2. Click "Register here"
3. Fill in the form:
   - Username: `testuser`
   - Email: `test@example.com`
   - Password: `password123`
4. Click "Register"
5. You'll be redirected to profile page

### 2. Login

1. If logged out, navigate to login page
2. Enter credentials:
   - Username or Email: `testuser` or `test@example.com`
   - Password: `password123`
3. Click "Login"
4. You'll see your profile

### 3. View Profile

- After login, you're redirected to profile page
- You can see: ID, Username, Email, Role, Account Status
- Click "Logout" to sign out

## Verifying JWT Token

### In Browser:

1. Open Browser DevTools (F12)
2. Go to Application tab
3. Under Local Storage, find `jwt_token`
4. Copy the token

### Decode Token:

1. Go to https://jwt.io/
2. Paste your token
3. View decoded payload with user info

## Database Access

### H2 Console (Development)

- URL: http://localhost:8080/h2-console
- JDBC URL: `jdbc:h2:mem:authdb`
- Username: `sa`
- Password: `password`

### Query Users:

```sql
SELECT * FROM users;
```

## API Testing with cURL

### Register User:
```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"testuser\",\"email\":\"test@example.com\",\"password\":\"password123\"}"
```

### Login:
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"usernameOrEmail\":\"testuser\",\"password\":\"password123\"}"
```

### Get Profile (with token):
```bash
curl -X GET http://localhost:8080/api/profile \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE"
```

## Troubleshooting

### Backend won't start:

**Error: Port 8080 already in use**
```bash
# Windows - Find and kill process
netstat -ano | findstr :8080
taskkill /PID <PID_NUMBER> /F
```

**Error: Java version**
- Ensure Java 17+ is installed
- Update JAVA_HOME environment variable

### Frontend issues:

**CORS Error:**
- Make sure backend is running on port 8080
- Check CORS configuration in `SecurityConfig.java`

**Token not working:**
- Clear browser localStorage
- Login again to get fresh token

### Database issues:

**Can't connect to H2:**
- Backend must be running
- Check database credentials in application.properties

## Switching to MySQL (Production)

1. Add MySQL dependency to `pom.xml`:
```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
```

2. Update `application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/auth_db?useSSL=false&serverTimezone=UTC
spring.datasource.driverClassName=com.mysql.cj.jdbc.Driver
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect
spring.jpa.hibernate.ddl-auto=update
```

3. Create database:
```sql
CREATE DATABASE auth_db;
```

## Next Steps

- Add password reset functionality
- Implement email verification
- Add refresh tokens
- Add role-based access control
- Implement OAuth2 login (Google, Facebook)
- Add rate limiting
- Add account lockout after failed attempts

## Support

For issues or questions, check:
- Spring Security Documentation
- JWT Best Practices
- OWASP Authentication Guidelines

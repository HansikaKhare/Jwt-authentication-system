# Complete Setup Instructions - JWT Authentication System

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Running the Application](#running-the-application)
4. [Testing](#testing)
5. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### 1. Java Development Kit (JDK) ✅

**Required:** Java 17 or higher

**Check if installed:**
```bash
java -version
```

**Install:**
- Download from: https://adoptium.net/
- Or use Oracle JDK: https://www.oracle.com/java/technologies/downloads/
- Follow installation wizard
- Set JAVA_HOME environment variable

**Verify installation:**
```bash
java -version
javac -version
```

### 2. Apache Maven

**Required:** Maven 3.6+

**Option A: Install Maven (Recommended)**
1. Download from: https://maven.apache.org/download.cgi
2. Extract to `C:\Program Files\Apache\maven`
3. Add to PATH: `C:\Program Files\Apache\maven\bin`
4. Verify: `mvn -version`

**Option B: Use IDE Maven (Alternative)**
- IntelliJ IDEA and Eclipse include Maven
- No separate installation needed

**Option C: Use Maven Wrapper**
- Project includes Maven wrapper scripts
- Automatically downloads correct Maven version

### 3. Web Browser

- Chrome, Firefox, Edge, or Safari
- Modern browser with DevTools support

---

## Installation

### Step 1: Clone/Download Project

You already have the project in:
```
c:\Users\91983\OneDrive\Desktop\Fullstack task\
```

### Step 2: Install Dependencies

**Backend:**
```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\backend"
mvn clean install
```

**First-time build may take a few minutes** as it downloads all dependencies.

### Step 3: Verify Build

Check for successful compilation:
```bash
cd backend
mvn compile
```

Expected output: `BUILD SUCCESS`

---

## Running the Application

### Method 1: Using Scripts (Easiest)

#### Windows Users:

1. **Start Backend:**
   ```
   Double-click: start-backend.bat
   ```
   
   Wait for message: `Started JwtAuthApplication in X seconds`

2. **Start Frontend:**
   ```
   Double-click: start-frontend.bat
   ```
   
   Browser will open automatically

### Method 2: Command Line

#### Start Backend:

```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\backend"
mvn spring-boot:run
```

**Expected output:**
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v3.2.0)

... (various startup logs)

Started JwtAuthApplication in 5.123 seconds
```

**Server runs on:** http://localhost:8080

#### Open Frontend:

**Option A:** Direct file access
- Navigate to: `frontend/login.html`
- Double-click to open in browser

**Option B:** HTTP Server (Recommended)
```bash
cd frontend
python -m http.server 5173
```
Then open: http://localhost:5173

### Method 3: From IDE

#### IntelliJ IDEA:
1. File → Open → Select `backend` folder
2. Wait for Maven import
3. Run `JwtAuthApplication.java`
4. Right-click → Run

#### Eclipse:
1. File → Import → Existing Maven Projects
2. Select `backend` folder
3. Run `JwtAuthApplication.java`
4. Right-click → Run As → Java Application

#### VS Code:
1. Install Java Extension Pack
2. Open `backend` folder
3. Run from Run view or terminal

---

## Testing the Application

### 1. Register New User

1. Open login page in browser
2. Click **"Register here"** link
3. Fill registration form:
   ```
   Username: testuser
   Email: test@example.com
   Password: password123
   ```
4. Click **"Register"** button
5. Success! Redirects to profile page

### 2. Login

1. Enter credentials:
   ```
   Username or Email: testuser
   Password: password123
   ```
2. Click **"Login"**
3. See profile page

### 3. View Protected Profile

After login:
- Profile displays user information
- Shows: ID, Username, Email, Role, Status
- JWT token stored in localStorage

### 4. Logout

Click **"Logout"** button
- Token removed from localStorage
- Redirects to login page

### 5. Verify JWT Token

**In Browser:**
1. Press F12 (DevTools)
2. Application tab → Local Storage
3. Find key: `jwt_token`
4. Copy the value

**Decode Token:**
1. Visit: https://jwt.io/
2. Paste token in left panel
3. See decoded payload in right panel:
   ```json
   {
     "userId": 1,
     "username": "testuser",
     "email": "test@example.com",
     "role": "ROLE_USER",
     "sub": "testuser",
     "iat": 1234567890,
     "exp": 1234654290
   }
   ```

---

## API Endpoints Reference

### Public Endpoints (No Auth Required)

#### Register User
```
POST http://localhost:8080/api/auth/register
Content-Type: application/json

{
  "username": "newuser",
  "email": "new@example.com",
  "password": "securepass123"
}
```

**Response:**
```json
{
  "id": 1,
  "username": "newuser",
  "email": "new@example.com",
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "tokenType": "Bearer",
  "expiresIn": 86400000
}
```

#### Login User
```
POST http://localhost:8080/api/auth/login
Content-Type: application/json

{
  "usernameOrEmail": "testuser",
  "password": "password123"
}
```

**Response:** Same as register

### Protected Endpoints (Requires JWT Token)

#### Get User Profile
```
GET http://localhost:8080/api/profile
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response:**
```json
{
  "id": 1,
  "username": "testuser",
  "email": "test@example.com",
  "role": "ROLE_USER",
  "enabled": true
}
```

---

## Database Access

### H2 Database Console

**Access URL:** http://localhost:8080/h2-console

**Connection Details:**
```
JDBC URL: jdbc:h2:mem:authdb
Username: sa
Password: password
```

**Sample Queries:**

View all users:
```sql
SELECT id, username, email, role, enabled, created_at 
FROM users;
```

Count users:
```sql
SELECT COUNT(*) FROM users;
```

Find by username:
```sql
SELECT * FROM users WHERE username = 'testuser';
```

---

## Troubleshooting

### Backend Issues

#### Problem: Port 8080 already in use

**Solution (Windows):**
```bash
# Find process using port 8080
netstat -ano | findstr :8080

# Kill the process (replace PID with actual number)
taskkill /PID <PID_NUMBER> /F
```

**Alternative:** Change port in `application.properties`:
```properties
server.port=8081
```

#### Problem: Java not found

**Solution:**
1. Verify Java installation: `java -version`
2. Set JAVA_HOME environment variable:
   - Right-click "This PC" → Properties
   - Advanced system settings
   - Environment Variables
   - New system variable:
     ```
     Variable name: JAVA_HOME
     Variable value: C:\Program Files\Java\jdk-17
     ```
3. Add to PATH: `%JAVA_HOME%\bin`
4. Restart terminal/IDE

#### Problem: Maven not found

**Solution:**
1. Download Maven: https://maven.apache.org/download.cgi
2. Extract to: `C:\Program Files\Apache\maven`
3. Add environment variables:
   ```
   M2_HOME: C:\Program Files\Apache\maven
   Path: %M2_HOME%\bin
   ```
4. Verify: `mvn -version`

### Frontend Issues

#### Problem: CORS Error

**Symptoms:**
```
Access to fetch at 'http://localhost:8080' has been blocked by CORS policy
```

**Solutions:**
1. Ensure backend is running on port 8080
2. Check CORS config in `SecurityConfig.java`
3. Make sure frontend requests use correct URL

#### Problem: Token not working / 401 Unauthorized

**Solutions:**
1. Clear localStorage in browser
2. Login again to get fresh token
3. Check token format in Authorization header:
   ```
   Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
   ```
   (Note the space after "Bearer")

#### Problem: Page doesn't load

**Solutions:**
1. Check browser console for errors (F12)
2. Verify backend is running
3. Check network tab for failed requests
4. Try different browser

### Compilation Errors

#### Problem: Lombok errors

**Solutions:**
1. In IDE, enable annotation processing:
   - IntelliJ: Settings → Build → Compiler → Annotation Processors
   - Eclipse: Window → Preferences → Java → Compiler → Annotation Processing
2. Run: `mvn clean install`
3. Restart IDE

#### Problem: Package not found

**Solution:**
```bash
cd backend
mvn clean
mvn dependency:purge-local-repository
mvn install
```

### Database Issues

#### Problem: Can't connect to H2

**Solutions:**
1. Backend must be running
2. Check credentials in `application.properties`
3. URL is case-sensitive: `jdbc:h2:mem:authdb`

#### Problem: Data lost after restart

**Note:** H2 in-memory database resets on restart

**Solution:** Use file-based H2 or MySQL:
```properties
# File-based H2
spring.datasource.url=jdbc:h2:file:./data/authdb
```

---

## Performance Tips

### First Startup Slow?
- Normal! Maven downloads dependencies
- Subsequent startups are faster
- Dependencies cached in local repository

### Memory Usage
- Default JVM heap: 256MB
- Increase if needed:
  ```bash
  set JAVA_OPTS=-Xmx512m
  mvn spring-boot:run
  ```

---

## Security Notes

### Development vs Production

**Current Setup (Development):**
- H2 in-memory database
- Debug logging enabled
- Simple password for H2 console

**Before Production:**
1. Change JWT secret to random 256-bit key
2. Switch to MySQL/PostgreSQL
3. Disable H2 console
4. Enable HTTPS
5. Add rate limiting
6. Implement refresh tokens
7. Add proper error handling

### Generate Secure JWT Secret

Use: https://generate-secret.vercel.app/32

Update in `application.properties`:
```properties
app.jwt.secret=your-new-secure-random-key-here
```

---

## Additional Resources

- Spring Security Docs: https://spring.io/projects/spring-security
- JWT Guide: https://jwt.io/introduction
- OWASP Auth: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
- REST API Best Practices: https://restfulapi.net/

---

## Support & Next Steps

### Successfully Running?

Try these enhancements:
1. Add email verification
2. Implement password reset
3. Add social login (Google, Facebook)
4. Add two-factor authentication (2FA)
5. Implement role-based access control
6. Add account lockout after failed attempts

### Need Help?

1. Check this guide thoroughly
2. Review error messages carefully
3. Search Stack Overflow
4. Check Spring documentation

---

**🎉 You're all set!** Run the application and start testing JWT authentication!

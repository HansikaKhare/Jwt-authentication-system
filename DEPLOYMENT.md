# 🚀 Deploy to Vercel + Railway Guide

## Overview
- **Frontend** (HTML/CSS/JS) → Deploy on **Vercel**
- **Backend** (Spring Boot) → Deploy on **Railway** or **Render**
- **Why?** Vercel doesn't support Java/Spring Boot

---

## Part 1: Deploy Backend to Railway.app

### Step 1: Prepare Your Backend

1. **Update `application.properties` for Production**

Create `backend/src/main/resources/application-prod.properties`:

```properties
# Server
server.port=${PORT:8080}

# JWT Settings
app.jwt.secret=${JWT_SECRET:YourSecretKeyForJWTTokenGenerationMustBeLongEnoughAndSecure2024}
app.jwt.expiration-ms=86400000

# Database (Railway provides MySQL automatically)
spring.datasource.url=${DATABASE_URL}
spring.datasource.username=${DATABASE_USERNAME}
spring.datasource.password=${DATABASE_PASSWORD}
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect

# CORS - Allow your Vercel frontend
cors.allowed-origins=https://your-app.vercel.app
```

2. **Update main `application.properties`**

Edit `backend/src/main/resources/application.properties`:

```properties
# Development settings
spring.profiles.active=dev

# Server
server.port=8080

# JWT Secret
app.jwt.secret=YourSecretKeyForJWTTokenGenerationMustBeLongEnoughAndSecure2024
app.jwt.expiration-ms=86400000

# Database
spring.datasource.url=jdbc:h2:mem:authdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=update

# H2 Console (dev only)
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

# Logging
logging.level.com.auth.jwt=DEBUG
logging.level.org.springframework.security=DEBUG

# Profile-specific
spring.config.activate.on-profile=dev
```

3. **Add MySQL dependency to `pom.xml`**

Add this to your dependencies:

```xml
<!-- MySQL Connector -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
```

### Step 2: Deploy to Railway

1. **Go to https://railway.app**
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose your repository: `Jwt-authentication-system`
5. Railway will auto-detect it's a Java/Maven project
6. Add environment variables:
   ```
   JWT_SECRET=YourVeryLongAndSecureSecretKeyHere2024
   PORT=8080
   ```
7. Click **"Deploy"**
8. Wait for deployment (5-10 minutes)
9. Copy your backend URL (e.g., `https://your-app.up.railway.app`)

---

## Part 2: Deploy Frontend to Vercel

### Step 1: Update API Configuration

Edit `frontend/js/auth.js`:

Replace:
```javascript
const API_BASE_URL = 'http://localhost:8080/api';
```

With:
```javascript
// Use environment variable or Railway URL
const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://your-railway-app.up.railway.app/api';
```

**Actually, since we're using vanilla JS, create `frontend/config.js`:**

```javascript
// Frontend API Configuration
const API_CONFIG = {
    BASE_URL: 'https://your-railway-app.up.railway.app/api'  // Replace with your Railway URL
};

const API_BASE_URL = API_CONFIG.BASE_URL;
```

Then update all JS files to use `API_BASE_URL` (it's already defined globally).

### Step 2: Create Vercel Configuration

Create `vercel.json` in the root:

```json
{
  "version": 2,
  "public": true,
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

### Step 3: Deploy to Vercel

#### Method A: Using Vercel CLI (Recommended)

1. **Install Vercel CLI:**
   ```bash
   npm install -g vercel
   ```

2. **Navigate to frontend folder:**
   ```bash
   cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\frontend"
   ```

3. **Login to Vercel:**
   ```bash
   vercel login
   ```

4. **Deploy:**
   ```bash
   vercel --prod
   ```

5. **Follow prompts:**
   - Set up and deploy? **Y**
   - Which scope? **Choose your account**
   - Link to existing project? **N**
   - Project name? **jwt-auth-frontend**
   - Directory? **./frontend**
   - Override settings? **N**

6. **Add Environment Variables:**
   ```bash
   vercel env add REACT_APP_API_URL production
   # Enter your Railway backend URL
   ```

7. **Redeploy:**
   ```bash
   vercel --prod
   ```

#### Method B: Using Vercel Website

1. **Go to https://vercel.com/new**
2. Click **"Import Git Repository"**
3. Select your GitHub account
4. Choose repository: `Jwt-authentication-system`
5. Configure:
   - **Framework Preset:** Other
   - **Root Directory:** `frontend`
   - **Build Command:** Leave blank
   - **Output Directory:** Leave blank
6. Add Environment Variable:
   - Name: `REACT_APP_API_URL`
   - Value: `https://your-railway-app.up.railway.app/api`
7. Click **"Deploy"**

---

## Part 3: Update CORS on Backend

Edit `backend/src/main/java/com/auth/jwt/security/SecurityConfig.java`:

Find the `CorsConfiguration` section and update:

```java
private CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration configuration = new CorsConfiguration();
    
    // Add your Vercel frontend URL
    configuration.setAllowedOrigins(List.of(
        "https://your-app.vercel.app",  // Your Vercel URL
        "http://localhost:8081",         // Local dev
        "file://"                        // Local file access
    ));
    
    configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
    configuration.setAllowedHeaders(List.of("*"));
    configuration.setAllowCredentials(true);
    configuration.setMaxAge(3600L);
    
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**", configuration);
    return source;
}
```

---

## Part 4: Test Everything

### 1. Test Backend (Railway)
```bash
# Test registration
curl -X POST https://your-railway-app.up.railway.app/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"test@example.com","password":"password123"}'
```

### 2. Test Frontend (Vercel)
1. Open your Vercel URL (e.g., `https://your-app.vercel.app`)
2. Try registering a user
3. Login
4. View profile

---

## Quick Deployment Commands

### For Railway (Backend):
```bash
# Commit and push changes
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task"
git add .
git commit -m "Prepare for deployment"
git push origin main

# Railway auto-deploys on push to main
```

### For Vercel (Frontend):
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
cd frontend
vercel --prod
```

---

## Environment Variables Summary

### Railway (Backend):
```
JWT_SECRET=your-very-secure-secret-key-here
PORT=8080
DATABASE_URL=mysql://...
DATABASE_USERNAME=root
DATABASE_PASSWORD=your-password
```

### Vercel (Frontend):
```
REACT_APP_API_URL=https://your-railway-app.up.railway.app/api
```

---

## Troubleshooting

### Frontend Can't Connect to Backend
- ✅ Check CORS configuration
- ✅ Verify Railway backend is running
- ✅ Check API URLs in frontend config
- ✅ Ensure HTTPS on both ends

### Backend Not Starting on Railway
- ✅ Check logs in Railway dashboard
- ✅ Verify `pom.xml` has all dependencies
- ✅ Ensure PORT environment variable is set
- ✅ Check Java version compatibility

### Build Fails on Vercel
- ✅ Vercel is for static files only
- ✅ Make sure Root Directory is set to `frontend`
- ✅ No build command needed for vanilla JS

---

## Alternative: Deploy Both on Render.com

If this seems complicated, try Render instead:

1. Go to https://render.com
2. Create **Web Service** for backend
3. Create **Static Site** for frontend
4. Same configuration, different platform

---

## Cost Breakdown

| Service | Plan | Cost |
|---------|------|------|
| Railway | Hobby | $5/month |
| Vercel | Hobby | FREE |
| **Total** | | **~$5/month** |

Or use Render:
| Service | Plan | Cost |
|---------|------|------|
| Render Web Service | Free | FREE* |
| Render Static Site | Free | FREE |
| **Total** | | **FREE** |

*Railway has a 500MB free tier, Render has limited hours on free tier

---

## Ready to Deploy?

Start with Railway for the backend, then deploy frontend to Vercel!

Need help? Check:
- Railway docs: https://docs.railway.app
- Vercel docs: https://vercel.com/docs

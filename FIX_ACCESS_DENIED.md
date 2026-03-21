# 🚫 "Access Denied" Error - Quick Fix

## Problem
Your Railway deployment shows "Access Denied" or won't load.

## ✅ Immediate Solutions

### Solution 1: Check Environment Variables (Most Common)

**In Railway Dashboard → Variables tab**, ensure you have these:

```
SPRING_PROFILES_ACTIVE=production
PORT=10000
JWT_SECRET=YourSuperSecretProductionKey2024!MustBeLongEnough
DATABASE_URL=jdbc:h2:mem:authdb
DATABASE_USERNAME=sa
DATABASE_PASSWORD=password
cors.allowed.origins=*
```

**Missing any of these will cause the app to crash!**

---

### Solution 2: Check if App Actually Started

**In Railway Dashboard:**

1. Click your project
2. Go to "Deployments" tab
3. Click latest deployment
4. Click "View Logs"

**Look for:**
- ✅ "Started JwtAuthApplication in X seconds"
- ✅ "Tomcat started on port(s): 10000"
- ❌ Any error messages

**If you see errors**, the app crashed and needs fixing.

---

### Solution 3: Fix Port Binding Issue

The Docker container must listen on Railway's assigned PORT.

#### Update `Dockerfile`:

```dockerfile
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Install Git (needed for Maven)
RUN apk add --no-cache git

# Copy pom.xml first for better caching
COPY backend/pom.xml ./backend/pom.xml
WORKDIR /app/backend
RUN mvn dependency:go-offline -f pom.xml

# Copy source code and build
COPY backend/src ./src
RUN mvn clean package -DskipTests -f pom.xml

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the built JAR
COPY --from=build /app/backend/target/*.jar app.jar

# Expose port (Railway sets PORT env var)
EXPOSE ${PORT:10000}

# Set active profile AND PORT
ENV SPRING_PROFILES_ACTIVE=production
ENV PORT=${PORT:10000}

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
```

**Key change:** Added `ENV PORT=${PORT:10000}` so Java knows which port to use.

---

### Solution 4: Verify application-production.properties

Make sure this file exists and has correct settings:

**File:** `backend/src/main/resources/application-production.properties`

```properties
spring.profiles.active=production

# CRITICAL: Must use PORT environment variable
server.port=${PORT:10000}

# JWT Secret
app.jwt.secret=${JWT_SECRET:DefaultSecretKeyForProductionUse2024!ChangeMe}
app.jwt.expiration-ms=86400000

# Database Configuration
spring.datasource.url=${DATABASE_URL:jdbc:h2:mem:authdb}
spring.datasource.driverClassName=${DATABASE_DRIVER:org.h2.Driver}
spring.datasource.username=${DATABASE_USERNAME:sa}
spring.datasource.password=${DATABASE_PASSWORD:password}

# For PostgreSQL (when Railway PostgreSQL addon is added):
# spring.datasource.driverClassName=org.postgresql.Driver
# spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect

spring.jpa.database-platform=${DATABASE_DIALECT:org.hibernate.dialect.H2Dialect}
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=false

# CORS Configuration
cors.allowed.origins=${CORS_ALLOWED_ORIGINS:*}

# Logging
logging.level.com.auth=INFO
logging.level.org.springframework.security=INFO
logging.pattern.console=%d{yyyy-MM-dd HH:mm:ss} - %msg%n
```

**Critical line:** `server.port=${PORT:10000}` - without this, app won't start!

---

### Solution 5: Remove Health Check (Temporarily)

Sometimes health check prevents initial startup.

#### Update `railway.json`:

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "DOCKERFILE"
  },
  "deploy": {
    "startCommand": "java -jar app.jar",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 3
  }
}
```

**Removed:**
- `healthcheckPath` - Can cause issues during first startup
- `healthcheckTimeout` - Let Railway use default

Add back later once app is running stable.

---

## 🎯 Step-by-Step Redeployment

### Step 1: Delete Current Project

Railway Dashboard → Project → Settings → Delete Project

### Step 2: Update Files Locally

Make the changes above (especially Dockerfile and environment variables).

### Step 3: Push to GitHub

```bash
git add .
git commit -m "Fix Access Denied error - proper port configuration"
git push origin main
```

### Step 4: Create New Railway Project

1. Railway Dashboard → New Project
2. Deploy from GitHub → Select your repo
3. **IMMEDIATELY add environment variables** (before it finishes building!)

### Step 5: Add ALL Environment Variables

Don't skip this step! Add these BEFORE deployment completes:

```
SPRING_PROFILES_ACTIVE=production
PORT=10000
JWT_SECRET=YourSuperSecretProductionKey2024!MustBeLongEnough
DATABASE_URL=jdbc:h2:mem:authdb
DATABASE_USERNAME=sa
DATABASE_PASSWORD=password
cors.allowed.origins=*
```

### Step 6: Watch Deployment

Deployments tab → View Logs

You should see:
```
Building Docker image...
Starting container...
...
Started JwtAuthApplication in 5.123 seconds
Tomcat started on port(s): 10000
```

---

## 🔍 How to Diagnose

### Check Deployment Status

**Green checkmark?** ✅ = Running successfully  
**Red X?** ❌ = Crashed, check logs  
**Yellow warning?** ⚠️ = Starting but having issues  

### Check Logs

**Good signs:**
```
Initializing Spring root DispatcherServlet
Starting service [Tomcat]
Tomcat started on port(s): 10000 (http)
Started JwtAuthApplication in X.XXX seconds
```

**Bad signs (crashes):**
```
FAILED to start
Port already in use
Cannot acquire connection from DataSource
BeanCreationException
```

### Test Manually

Once deployed, test directly:
```bash
curl https://jwt-auth-frontend-production-18a6.up.railway.app/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"usernameOrEmail":"test","password":"test"}'
```

Should return 400 or 401 (not connection refused).

---

## 💡 Common Causes

### Cause 1: Missing PORT Variable

**Symptom:** App starts on wrong port

**Fix:** Set `PORT=10000` in Railway variables

### Cause 2: Wrong Profile

**Symptom:** Uses development config instead of production

**Fix:** Set `SPRING_PROFILES_ACTIVE=production`

### Cause 3: Database Connection Failed

**Symptom:** App crashes on startup

**Fix:** Either:
- Add PostgreSQL addon, OR
- Use H2 with proper DATABASE_URL

### Cause 4: Health Check Too Aggressive

**Symptom:** Railway kills app before it fully starts

**Fix:** Remove healthcheckPath temporarily

### Cause 5: Container Binds to Wrong Interface

**Symptom:** Starts but not accessible externally

**Fix:** Add to `application-production.properties`:
```properties
server.address=0.0.0.0
```

---

## ✅ Success Indicators

You'll know it's working when:

1. ✅ Railway shows green checkmark
2. ✅ Logs show "Tomcat started on port(s): 10000"
3. ✅ Can access URL without "Access Denied"
4. ✅ API returns response (even 400/401)
5. ✅ No crash errors in logs

---

## 🆘 Still Not Working?

### Try This Emergency Config:

**Minimal Dockerfile:**
```dockerfile
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY backend/target/*.jar app.jar

EXPOSE 10000

ENV SPRING_PROFILES_ACTIVE=production
ENV SERVER_PORT=10000

ENTRYPOINT ["java", "-jar", "app.jar"]
```

**Minimal railway.json:**
```json
{
  "build": {
    "builder": "DOCKERFILE"
  },
  "deploy": {
    "startCommand": "java -jar app.jar"
  }
}
```

**Environment Variables:**
```
SPRING_PROFILES_ACTIVE=production
SERVER_PORT=10000
PORT=10000
DATABASE_URL=jdbc:h2:mem:authdb
DATABASE_USERNAME=sa
DATABASE_PASSWORD=password
JWT_SECRET=testsecret2024
```

This bare-bones config should work for testing.

---

## 📊 Quick Reference

| Error | Likely Cause | Fix |
|-------|--------------|-----|
| Access Denied | App not running | Check logs, add env vars |
| Connection Refused | Wrong port | Set PORT=10000 |
| 502 Bad Gateway | App crashed | Check logs for errors |
| Timeout | Health check failed | Remove healthcheckPath |
| 404 Not Found | Wrong path | Check server.context-path |

---

## 🎉 Final Checklist

Before redeploying:

- [ ] `application-production.properties` has `server.port=${PORT:10000}`
- [ ] Dockerfile sets `ENV PORT=${PORT:10000}`
- [ ] All environment variables added in Railway
- [ ] Health check removed (temporarily)
- [ ] Logs checked for specific errors
- [ ] Database configured (H2 or PostgreSQL)

---

**Next Steps:**
1. Check current logs in Railway dashboard
2. Identify specific error message
3. Apply appropriate fix from above
4. Redeploy with correct configuration

*Access Denied Fix Guide v1.0 | Last Updated: March 20, 2026*

# 🚨 Backend Deployment Failed - Complete Fix Guide

## 🔍 Common Reasons for Backend Failure on Railway

### 1. Java Version Mismatch
### 2. Maven Build Issues  
### 3. Port Configuration Problems
### 4. Database Connection Failures
### 5. Missing Environment Variables

---

## ✅ Step-by-Step Diagnosis & Fix

### Step 1: Check Your Build Logs

**In Railway Dashboard:**
1. Go to your project
2. Click "Deployments" tab
3. Click failed deployment
4. Click "View Logs"
5. **Copy the error message**

Look for keywords like:
- `java.lang.UnsupportedClassVersionError` → Java version issue
- `Could not find or load main class` → Build path issue
- `Port already in use` or `Failed to bind` → Port issue
- `Cannot acquire connection from DataSource` → Database issue

---

## 🔧 Solution 1: Fix Java Version (Most Common)

Your `pom.xml` says Java 17, but Railway might be using different version.

### Update `nixpacks.toml`:

```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = ["cd backend && mvn clean install -DskipTests"]

[start]
cmd = "cd backend && java -jar target/*.jar"
```

✅ **Already correct!** If still failing, try explicit JDK:

```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.build]
args = ["JAVA_VERSION=17"]

[phases.install]
cmds = ["cd backend && mvn clean package -DskipTests -Dmaven.test.skip=true"]

[start]
cmd = "cd backend && java -jar target/*.jar"
```

---

## 🔧 Solution 2: Fix Port Configuration

Railway assigns a dynamic port via `$PORT` environment variable.

### Check `application-production.properties`:

Make sure it has:
```properties
server.port=${PORT:10000}
```

If missing, create the file or update existing:

**File location:** `backend/src/main/resources/application-production.properties`

Should contain:
```properties
spring.profiles.active=production

# Server Configuration
server.port=${PORT:10000}

# JWT Secret
app.jwt.secret=${JWT_SECRET:DefaultSecretKeyForDevelopmentOnly2024!ChangeMe}
app.jwt.expiration-ms=86400000

# Database
spring.datasource.url=${DATABASE_URL:jdbc:h2:mem:authdb}
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=${DATABASE_USERNAME:sa}
spring.datasource.password=${DATABASE_PASSWORD:password}

# For production with PostgreSQL:
# spring.datasource.driverClassName=org.postgresql.Driver
# spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect

# CORS
cors.allowed.origins=${CORS_ALLOWED_ORIGINS:*}
```

---

## 🔧 Solution 3: Set Required Environment Variables

**In Railway Dashboard → Variables tab**, add these:

```
SPRING_PROFILES_ACTIVE=production
JWT_SECRET=YourSuperSecretProductionKey2024!MustBeLongEnough
PORT=10000
DATABASE_URL=jdbc:h2:mem:authdb
DATABASE_USERNAME=sa
DATABASE_PASSWORD=password
cors.allowed.origins=*
```

**If using PostgreSQL** (after adding Railway PostgreSQL addon):
```
SPRING_PROFILES_ACTIVE=production
JWT_SECRET=YourSuperSecretProductionKey2024!MustBeLongEnough
PORT=10000
cors.allowed.origins=*
```

Railway automatically adds `DATABASE_URL` when you add PostgreSQL.

---

## 🔧 Solution 4: Simplify Build Process

Sometimes Maven build is too complex. Try this simpler approach:

### Option A: Use Spring Boot Maven Plugin Directly

Update `railway.json`:

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "cd backend && ./mvnw spring-boot:run -DskipTests",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 3
  }
}
```

Update `nixpacks.toml`:

```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = ["cd backend && mvn dependency:go-offline -DskipTests"]

[start]
cmd = "cd backend && ./mvnw spring-boot:run -Dspring.profiles.active=production"
```

### Option B: Pre-built JAR (Recommended)

Keep current config but ensure proper build:

`nixpacks.toml`:
```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = [
  "cd backend",
  "mvn clean package -DskipTests -Dmaven.test.skip=true",
  "ls target/*.jar"
]

[start]
cmd = "cd backend && java -jar target/*.jar"
```

This verifies the JAR exists before starting.

---

## 🔧 Solution 5: Fix Database Issues

### If NOT using PostgreSQL addon:

Use H2 in-memory database (simpler):

Environment variables:
```
SPRING_PROFILES_ACTIVE=production
DATABASE_URL=jdbc:h2:mem:authdb
DATABASE_USERNAME=sa
DATABASE_PASSWORD=password
JWT_SECRET=YourSecret2024!
```

### If USING PostgreSQL addon:

1. Make sure PostgreSQL is added in Railway dashboard
2. Railway auto-sets `DATABASE_URL`
3. Don't override it manually

---

## 🔧 Solution 6: Check Application Properties

Verify you have BOTH property files:

### `application.properties` (Development)
Location: `backend/src/main/resources/application.properties`

```properties
spring.application.name=jwt-auth-system
spring.profiles.active=development

server.port=8080

# H2 Database
spring.datasource.url=jdbc:h2:mem:authdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password

spring.h2.console.enabled=true
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=update

app.jwt.secret=YourSecretKeyForJWTTokenGenerationMustBeLongEnoughAndSecure2024
app.jwt.expiration-ms=86400000

logging.level.com.auth=DEBUG
logging.level.org.springframework.security=DEBUG
```

### `application-production.properties` (Production)
Location: `backend/src/main/resources/application-production.properties`

```properties
spring.profiles.active=production

server.port=${PORT:10000}

app.jwt.secret=${JWT_SECRET:DefaultSecretKeyForProductionUse2024!ChangeMe}
app.jwt.expiration-ms=86400000

# Use DATABASE_URL from Railway or fallback to H2
spring.datasource.url=${DATABASE_URL:jdbc:h2:mem:authdb}
spring.datasource.driverClassName=${DATABASE_DRIVER:org.h2.Driver}
spring.datasource.username=${DATABASE_USERNAME:sa}
spring.datasource.password=${DATABASE_PASSWORD:password}

spring.jpa.database-platform=${DATABASE_DIALECT:org.hibernate.dialect.H2Dialect}
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=false

logging.level.com.auth=INFO
logging.level.org.springframework.security=INFO

cors.allowed.origins=${CORS_ALLOWED_ORIGINS:*}
```

---

## 🆘 Emergency Fallback: Use Docker

If Nixpacks keeps failing, use Docker instead:

### Create `Dockerfile` in root:

```dockerfile
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Install Git (needed for Maven to download dependencies)
RUN apk add --no-cache git

# Copy backend
COPY backend /app/backend

WORKDIR /app/backend

# Build backend
RUN ./mvnw clean package -DskipTests -f pom.xml

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy built JAR
COPY --from=build /app/backend/target/*.jar app.jar

# Expose port
EXPOSE ${PORT:10000}

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### Update `railway.json`:

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "DOCKERFILE"
  },
  "deploy": {
    "startCommand": "java -jar app.jar",
    "healthcheckPath": "/api/auth/login",
    "healthcheckTimeout": 100,
    "restartPolicyType": "ON_FAILURE"
  }
}
```

---

## 📊 Quick Checklist

Before redeploying, verify:

- [ ] `pom.xml` has Java 17 in properties
- [ ] `application-production.properties` exists
- [ ] `server.port=${PORT:10000}` is set
- [ ] Environment variables set in Railway
- [ ] PostgreSQL addon added (if using)
- [ ] No syntax errors in configuration files
- [ ] `nixpacks.toml` uses correct paths

---

## 🎯 Redeployment Steps

### 1. Delete Failed Deployment

Railway Dashboard → Project → Settings → Delete Project

### 2. Push Latest Code

```bash
git add .
git commit -m "Fix backend deployment issues"
git push origin main
```

### 3. Redeploy

Railway Dashboard → New Project → Deploy from GitHub

### 4. Add Environment Variables

Immediately after creating project:

Variables → Add:
```
SPRING_PROFILES_ACTIVE=production
JWT_SECRET=YourSuperSecretProductionKey2024!MustBeLongEnough
PORT=10000
```

### 5. Add PostgreSQL (Optional)

New → Database → PostgreSQL

### 6. Watch Deployment

Deployments tab → Click deployment → View Logs

---

## 💡 Most Likely Solution

Based on common failures, here's what probably fixes it:

### The Problem:
Railway can't find or build your Spring Boot application.

### The Fix:

**1. Update `nixpacks.toml`** (already done in latest commit):
```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = ["cd backend && mvn clean install -DskipTests"]

[start]
cmd = "cd backend && java -jar target/*.jar"
```

**2. Set environment variables in Railway:**
```
SPRING_PROFILES_ACTIVE=production
JWT_SECRET=YourSecret2024!
PORT=10000
DATABASE_URL=jdbc:h2:mem:authdb
DATABASE_USERNAME=sa
DATABASE_PASSWORD=password
```

**3. Redeploy on Railway**

Delete project and create fresh deployment.

---

## 📞 Still Failing?

### Share These Details:

1. **Build logs** from Railway dashboard
2. **Error message** (exact text)
3. **Which step fails** (Maven build, Java startup, etc.)
4. **Environment variables** you've set

### Get Help:

- Railway Discord: https://discord.gg/railway
- Railway Docs: https://docs.railway.app
- Stack Overflow: Tag with `railway.app` and `spring-boot`

---

## ✅ Working Configuration Summary

Your current setup should work if:

1. ✅ Java 17 configured in nixpacks
2. ✅ Maven builds successfully  
3. ✅ PORT environment variable set
4. ✅ Production profile exists
5. ✅ Environment variables configured

**Most common fix:** Delete Railway project, redeploy fresh with correct env vars.

---

*Last Updated: March 20, 2026*  
*Backend Troubleshooting Guide v1.0*

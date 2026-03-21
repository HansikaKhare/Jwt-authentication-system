# Railway Deployment - Troubleshooting Guide

## 🚨 Common Build Failures & Solutions

### Issue 1: Both Frontend and Backend Build Failed

**Most common causes:**
- Wrong build order
- Missing dependencies
- Path issues in nixpacks.toml

---

## ✅ Solution: Simplified Deployment Strategy

### Option A: Deploy Backend Only on Railway (Recommended) ⭐

Deploy backend as API service, frontend separately on Vercel/Netlify.

#### Step 1: Update railway.json for Backend Only

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "cd backend && java -jar target/*.jar",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 3
  }
}
```

#### Step 2: Update nixpacks.toml for Backend Only

```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = ["cd backend && mvn clean install -DskipTests"]

[start]
cmd = "cd backend && java -jar target/*.jar"
```

#### Step 3: Deploy to Railway

1. Go to Railway dashboard
2. Delete current deployment
3. Redeploy with new config

---

### Option B: Fix Full-Stack Build (Advanced)

If you want both on Railway, use this approach:

#### Updated nixpacks.toml

```toml
[phases.setup]
nixPkgs = ["jdk17", "maven", "nodejs-18"]

[phases.install]
cmds = [
  "npm install --prefix frontend",
  "mvn clean install -pl backend -am -DskipTests"
]

[phases.build]
cmds = [
  "npm run build --prefix frontend",
  "mkdir -p backend/target/classes/static",
  "cp -r frontend/dist/* backend/target/classes/static/"
]

[start]
cmd = "java -jar backend/target/*.jar"
```

#### Updated railway.json

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "java -jar backend/target/*.jar",
    "env": {
      "SPRING_PROFILES_ACTIVE": "production"
    }
  }
}
```

---

## 🔍 Debugging Steps

### 1. Check Build Logs

In Railway dashboard:
- Click your project
- Go to "Deployments" tab
- Click failed deployment
- Click "View Logs"

Look for specific error messages.

### 2. Common Error Patterns

#### Maven Build Failure

**Error:** `mvn: command not found` or build fails

**Solution:**
```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]
```

#### Node.js Build Failure

**Error:** `npm: command not found` or build fails

**Solution:**
```toml
[phases.setup]
nixPkgs = ["nodejs-18"]
```

#### Path Issues

**Error:** `No such file or directory`

**Solution:** Use absolute paths or correct relative paths

---

## 💡 Recommended Approach: Separate Services

### Deploy Backend on Railway

**Configuration Files:**

`railway.json`:
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "cd backend && ./mvnw spring-boot:run",
    "restartPolicyType": "ON_FAILURE"
  }
}
```

`nixpacks.toml`:
```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = ["cd backend && mvn clean install -DskipTests"]

[start]
cmd = "cd backend && java -jar target/*.jar"
```

**Environment Variables:**
```
JWT_SECRET=YourSecretKey2024!
SPRING_PROFILES_ACTIVE=production
PORT=10000
DATABASE_URL=<from Railway PostgreSQL>
```

### Deploy Frontend on Vercel/Netlify

**Vercel Configuration:**

`vercel.json`:
```json
{
  "buildCommand": "cd frontend && npm install && npm run build",
  "outputDirectory": "frontend/dist",
  "devCommand": "cd frontend && npm run dev",
  "framework": "vite"
}
```

**Environment Variable:**
```
VITE_API_BASE_URL=https://your-backend.up.railway.app/api
```

---

## 🛠️ Quick Fix Commands

### Test Locally First

```bash
# Test backend build
cd backend
./mvnw clean package -DskipTests

# Test frontend build
cd frontend
npm install
npm run build

# If both work locally, issue is with Railway config
```

### Update Railway Config

```bash
# Use simpler backend-only config
cat > railway.json << 'EOF'
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "cd backend && java -jar target/*.jar"
  }
}
EOF

cat > nixpacks.toml << 'EOF'
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = ["cd backend && mvn clean install -DskipTests"]

[start]
cmd = "cd backend && java -jar target/*.jar"
EOF
```

---

## 📊 Deployment Comparison

| Approach | Complexity | Success Rate | Recommendation |
|----------|------------|--------------|----------------|
| **Backend only on Railway** | Low | High | ⭐⭐⭐⭐⭐ Recommended |
| **Frontend on Vercel, Backend on Railway** | Medium | High | ⭐⭐⭐⭐⭐ Best of both |
| **Both on Railway (single service)** | High | Medium | ⭐⭐ Advanced only |

---

## 🎯 Action Plan

### If You Want Quick Success:

1. **Use backend-only config on Railway**
2. **Deploy frontend to Vercel**
3. **Connect them via environment variables**

### If You Insist on Both on Railway:

1. **Check build logs carefully**
2. **Fix path issues**
3. **Ensure correct build order**
4. **Test each step locally**

---

## 🆘 Still Having Issues?

### Get Help:

1. **Share Build Logs**
   - Railway dashboard → Deployments → View Logs
   - Copy error messages
   
2. **Check Documentation**
   - Railway Docs: https://docs.railway.app
   - Nixpacks Docs: https://nixpacks.com

3. **Community Support**
   - Railway Discord: https://discord.gg/railway
   - Stack Overflow

---

## ✅ Working Configuration Examples

### Example 1: Backend Only (Recommended)

**railway.json:**
```json
{
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "cd backend && java -jar target/*.jar"
  }
}
```

**nixpacks.toml:**
```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = ["cd backend && mvn clean install -DskipTests"]

[start]
cmd = "cd backend && java -jar target/*.jar"
```

### Example 2: Separate Builds

**Backend on Railway, Frontend on Vercel**

This is the most reliable approach and what I recommend!

---

**Next Steps:**
1. Decide: Backend-only on Railway OR Both on Railway
2. Update configs accordingly
3. Redeploy
4. Share error logs if still failing

*Last Updated: March 20, 2026*

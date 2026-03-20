# Railway Deployment Guide - Complete Setup

## 🚀 Deploy Full-Stack App on Railway (Backend + Frontend)

Railway is perfect for your full-stack app because it can host:
- ✅ **Spring Boot Backend** (Java service)
- ✅ **Vite Frontend** (Static site or served by backend)

---

## 📋 Overview

**What You'll Get:**
- Backend API: `https://your-app-production.up.railway.app/api`
- Frontend: Same URL (served by Spring Boot) or separate static site
- PostgreSQL Database: Automatic setup
- Environment Variables: Easy management
- Auto-deploy: On Git push

**Cost:** $5 free credit/month (enough for testing)

---

## 🎯 Step-by-Step Deployment

### Phase 1: Prepare Your Code

#### 1. Update Backend for Railway

The backend is already configured! Just verify:

✅ `application-production.properties` exists  
✅ Uses `${PORT}` environment variable  
✅ Uses `${DATABASE_URL}` for PostgreSQL  
✅ CORS configured with `cors.allowed-origins=*`  

#### 2. Create Railway Configuration File

Create a file called `railway.json` in the root directory:

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "java -jar backend/target/*.jar",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 3
  }
}
```

#### 3. Create Nixpacks Configuration

Railway uses Nixpacks to build Java apps. Create `nixpacks.toml`:

```toml
[phases.setup]
nixPkgs = ["jdk17", "maven"]

[phases.install]
cmds = ["cd backend && mvn clean package -DskipTests"]

[phases.build]
cmds = ["echo 'Build completed'"]

[start]
cmd = "java -jar backend/target/*.jar"
```

---

### Phase 2: Deploy to Railway

#### Method 1: Deploy from GitHub (Recommended) ⭐

**Step 1: Push Code to GitHub**
```bash
git add .
git commit -m "Add Railway deployment config"
git push origin main
```

**Step 2: Connect Railway to GitHub**

1. Go to [Railway.app](https://railway.app)
2. Sign up/Login with GitHub
3. Click **"New Project"**
4. Select **"Deploy from GitHub repo"**
5. Choose your repository: `HansikaKhare/jwt-authentication-system`

**Step 3: Configure Build**

Railway will auto-detect Java, but verify:

- **Root Directory**: Leave empty (uses root)
- **Build Command**: `cd backend && mvn clean package -DskipTests`
- **Start Command**: `java -jar backend/target/*.jar`

**Step 4: Add Environment Variables**

In Railway dashboard → Variables tab, add:

```
JWT_SECRET=YourSuperSecretProductionKey2024!ChangeThis
SPRING_PROFILES_ACTIVE=production
cors.allowed.origins=https://your-app-production.up.railway.app
PORT=10000
```

**Step 5: Add PostgreSQL Database**

1. In your Railway project, click **"New"** → **"Database"** → **"PostgreSQL"**
2. Railway automatically creates database and adds `DATABASE_URL` variable
3. The backend will auto-connect using `application-production.properties`

**Step 6: Deploy!**

Click **"Deploy"** and wait 5-10 minutes.

---

#### Method 2: Deploy via Railway CLI

**Step 1: Install Railway CLI**
```bash
npm install -g @railway/cli
```

**Step 2: Login to Railway**
```bash
railway login
```

**Step 3: Initialize Project**
```bash
railway init
```

Select your GitHub repo or create new project.

**Step 4: Add Database**
```bash
railway add postgresql
```

**Step 5: Set Environment Variables**
```bash
railway variables set JWT_SECRET=YourSecretKey2024!
railway variables set SPRING_PROFILES_ACTIVE=production
railway variables set PORT=10000
```

**Step 6: Deploy**
```bash
railway up
```

---

### Phase 3: Configure Frontend

#### Option A: Serve Frontend from Backend (Simplest) ⭐ Recommended

Spring Boot can serve your static frontend files directly!

**1. Update `pom.xml`** (backend)

Add resource configuration to copy frontend files to backend:

```xml
<build>
    <plugins>
        <!-- Existing plugins -->
        
        <!-- Copy frontend resources -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-resources-plugin</artifactId>
            <version>3.3.0</version>
            <executions>
                <execution>
                    <id>copy-frontend-resources</id>
                    <phase>process-resources</phase>
                    <goals>
                        <goal>copy-resources</goal>
                    </goals>
                    <configuration>
                        <outputDirectory>${project.build.outputDirectory}/static</outputDirectory>
                        <resources>
                            <resource>
                                <directory>${project.basedir}/../frontend/dist</directory>
                                <filtering>false</filtering>
                            </resource>
                        </resources>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

**2. Build Frontend First**
```bash
cd frontend
npm install
npm run build
cd ..
```

**3. Deploy to Railway**

Railway will build both backend and frontend together.

**Access:** Everything available at `https://your-app.up.railway.app`
- Frontend: `https://your-app.up.railway.app/`
- API: `https://your-app.up.railway.app/api/*`

---

#### Option B: Separate Frontend Service

Deploy frontend as a separate static site service on Railway.

**1. Create Frontend Service**

In Railway dashboard:
1. Click **"New"** → **"Empty Service"**
2. Name it "frontend"
3. Configure:
   - **Build Command**: `cd frontend && npm install && npm run build`
   - **Start Command**: `cd frontend && npx serve dist -p $PORT`
   - **Port**: `5000`

**2. Add Environment Variable**

Frontend needs to know backend URL:
```
VITE_API_BASE_URL=https://your-backend.up.railway.app/api
```

**3. Update Frontend Config**

Update `frontend/config.js`:
```javascript
window.API_CONFIG = {
    BASE_URL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/api'
};
```

**Access:**
- Frontend: `https://your-frontend.up.railway.app`
- Backend: `https://your-backend.up.railway.app`

---

### Phase 4: Update CORS Configuration

**Important:** Update backend CORS to allow Railway URLs.

In `SecurityConfig.java`:
```java
String allowedOrigins = env.getProperty("cors.allowed.origins", 
    "http://localhost:5173,http://localhost:3000");
```

Set in Railway environment variables:
```
cors.allowed.origins=https://your-app.up.railway.app,http://localhost:5173
```

---

### Phase 5: Test Your Deployment

**1. Get Your Railway URL**

In Railway dashboard → Settings → Domains
- Example: `https://jwt-auth-production.up.railway.app`

**2. Test Frontend**
```
Visit: https://your-app.up.railway.app
```

**3. Test API Endpoints**
```
POST https://your-app.up.railway.app/api/auth/register
POST https://your-app.up.railway.app/api/auth/login
GET    https://your-app.up.railway.app/api/profile
```

**4. Test Full Flow**
- ✅ Register new user
- ✅ Login
- ✅ Access profile page
- ✅ Check browser console (no errors)
- ✅ Verify JWT token in localStorage

---

## 🔧 Troubleshooting

### Build Fails

**Problem:** Maven build fails on Railway

**Solution:**
```bash
# Test build locally first
cd backend
./mvnw clean package -DskipTests
```

Check `pom.xml` for errors.

---

### Database Connection Error

**Problem:** Cannot connect to PostgreSQL

**Solution:**
1. Ensure PostgreSQL addon is added in Railway
2. Check `DATABASE_URL` environment variable exists
3. Verify `application-production.properties` uses `${DATABASE_URL}`

---

### CORS Errors

**Problem:** Frontend blocked by CORS policy

**Solution:**
```
cors.allowed.origins=https://your-app.up.railway.app
```

Add this to Railway environment variables and redeploy.

---

### Port Binding Error

**Problem:** Application won't start, port errors

**Solution:**
Ensure `PORT` environment variable is set:
```
PORT=10000
```

And in `application-production.properties`:
```properties
server.port=${PORT:10000}
```

---

### Frontend Not Loading

**Problem:** Blank page or 404

**Solution:**
1. Check if frontend built successfully (`npm run build`)
2. Verify static files are in correct location
3. Check browser console for errors
4. Ensure API calls use correct backend URL

---

## 📊 Monitoring & Logs

### View Logs in Railway Dashboard

1. Go to your project
2. Click on service (backend/frontend)
3. Click **"Deployments"** tab
4. Click latest deployment → **"View Logs"**

### Real-time Logs (CLI)
```bash
railway logs
```

---

## 💰 Cost Management

### Railway Pricing

- **Free Tier:** $5 credit/month
- **Hobby Plan:** $5/month (includes $5 credit)
- **Pro Plans:** Available for production

### Estimate Your Costs

**Typical usage for this app:**
- Backend (Java): ~$3-5/month
- Frontend (Static): ~$0-1/month
- PostgreSQL: ~$0-1/month
- **Total:** ~$4-7/month (covered by Hobby plan)

### Monitor Usage

Railway dashboard → Usage tab
- Track compute time
- Monitor bandwidth
- Check database usage

---

## 🔄 Continuous Deployment

Railway automatically deploys on Git push!

**Workflow:**
```bash
# Make changes
git add .
git commit -m "Fix bug or add feature"
git push origin main
```

Railway detects push → Auto-builds → Auto-deploys

No manual intervention needed!

---

## 🎯 Production Checklist

Before going live:

- [ ] Strong JWT secret set (32+ characters)
- [ ] CORS configured for production URL
- [ ] PostgreSQL database connected
- [ ] All environment variables set
- [ ] Tested registration, login, profile access
- [ ] No console errors
- [ ] HTTPS working (automatic on Railway)
- [ ] Monitoring enabled
- [ ] Backup strategy in place

---

## 📈 Scaling Options

As your app grows:

1. **Upgrade Railway Plan** - More credits, more resources
2. **Add Custom Domain** - Use your own domain
3. **Enable Backups** - Automatic database backups
4. **Add Monitoring** - Sentry, LogRocket, etc.
5. **CDN for Static Assets** - Cloudflare, CloudFront

---

## 🆘 Getting Help

- **Railway Docs:** https://docs.railway.app
- **Discord Community:** https://discord.gg/railway
- **Status Page:** https://status.railway.app
- **GitHub Issues:** Your repository issues

---

## 🎉 Success!

After deployment, you'll have:

✅ **Single Platform:** Both frontend and backend on Railway  
✅ **Auto-deploy:** Push to Git → automatic deployment  
✅ **Database:** PostgreSQL managed by Railway  
✅ **HTTPS:** Automatic SSL certificates  
✅ **Environment Variables:** Easy management  
✅ **Monitoring:** Built-in logs and metrics  

**URLs:**
- Frontend: `https://your-app.up.railway.app`
- Backend API: `https://your-app.up.railway.app/api`
- Database: Managed by Railway

---

## Quick Reference

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Initialize project
railway init

# Add database
railway add postgresql

# Set variables
railway variables set JWT_SECRET=YourSecret
railway variables set SPRING_PROFILES_ACTIVE=production

# Deploy
railway up

# View logs
railway logs

# Open dashboard
railway open
```

---

**Ready to deploy? Start with Phase 1!** 🚀

*Last Updated: March 20, 2026*  
*Railway Deployment Guide v1.0*

# 🚀 Deploy to Render - Complete Guide

## Why Render is Better for Your App

✅ **Native Java/Spring Boot support**  
✅ **Free tier available** (750 hours/month)  
✅ **Auto-deploy on Git push**  
✅ **Managed PostgreSQL included**  
✅ **Simpler than Railway for Java apps**  

---

## 🎯 Deployment Options

### Option 1: Backend + Frontend Separate (Recommended) ⭐

- **Backend**: Render Web Service (Spring Boot API)
- **Frontend**: Vercel/Netlify (static hosting)

**Benefits:**
- Easier to configure
- Better performance
- Free tiers for both

---

### Option 2: Both on Render

- **Backend**: Render Web Service
- **Frontend**: Render Static Site

**Benefits:**
- Single platform
- Unified management

---

## 📋 Step-by-Step: Option 1 (Recommended)

### Part 1: Deploy Backend on Render

#### Step 1: Push Code to GitHub

```bash
git add .
git commit -m "Prepare for Render deployment"
git push origin main
```

✅ **Already done!** Your code is on GitHub.

---

#### Step 2: Create Render Account

1. Go to [Render.com](https://render.com)
2. Click **"Get Started for Free"**
3. Sign up with GitHub (recommended) or email

---

#### Step 3: Create New Web Service

1. Click **"New +"** → **"Blueprint"**
2. Connect your GitHub account
3. Select repository: `HansikaKhare/jwt-authentication-system`
4. Render will detect `render.yaml` automatically!

---

#### Step 4: Configure Blueprint

Render shows detected services from `render.yaml`:

**Backend Service:**
- Name: `jwt-auth-backend`
- Environment: `Java`
- Region: `Oregon` (or closest to you)
- Plan: `Free`
- Build Command: `./backend/mvnw clean package -DskipTests -f backend/pom.xml`
- Start Command: `java -jar backend/target/*.jar`

**Frontend Service:**
- Name: `jwt-auth-frontend`
- Environment: `Static Site`
- Build Command: `cd frontend && npm install && npm run build`
- Publish Directory: `frontend/dist`

Click **"Apply"** to start deployment!

---

#### Step 5: Set Environment Variables

**For Backend:**

In Render dashboard → jwt-auth-backend → Environment:

Add these variables:
```
SPRING_PROFILES_ACTIVE=production
JWT_SECRET=YourSuperSecretProductionKey2024!MustBeLongEnough
PORT=10000
DATABASE_URL=jdbc:h2:mem:authdb
DATABASE_USERNAME=sa
DATABASE_PASSWORD=password
cors.allowed.origins=*
```

**OR if using Render PostgreSQL:**

1. First add PostgreSQL database (see below)
2. Then set only:
   ```
   SPRING_PROFILES_ACTIVE=production
   JWT_SECRET=YourSuperSecretProductionKey2024!MustBeLongEnough
   cors.allowed.origins=*
   ```

Render auto-sets `DATABASE_URL` when you add PostgreSQL!

---

#### Step 6: Add PostgreSQL Database (Optional but Recommended)

1. In Render dashboard, click **"New +"**
2. Select **"PostgreSQL"**
3. Choose region (same as your web service)
4. Name: `jwt-auth-db`
5. Click **"Add Database"**

Render creates database and automatically:
- ✅ Sets `DATABASE_URL` environment variable
- ✅ Configures credentials
- ✅ Manages backups

**Update your backend to use it:**

The `application-production.properties` already configured to use `${DATABASE_URL}`!

---

#### Step 7: Wait for Deployment

**Backend deployment takes ~5-10 minutes:**

Watch progress:
- Building... ⏳ (Maven build)
- Starting... ⏳ (Spring Boot startup)
- **Live!** ✅ (Green checkmark)

**Get your backend URL:**

Render dashboard → jwt-auth-backend → Copy URL

Example: `https://jwt-auth-backend-xyz.onrender.com`

---

### Part 2: Deploy Frontend on Vercel

#### Step 1: Update vercel.json

Replace the Railway URL with your Render backend URL:

```json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "https://YOUR-RENDER-BACKEND-URL.onrender.com/api/$1"
    }
  ],
  "env": {
    "VITE_API_BASE_URL": "https://YOUR-RENDER-BACKEND-URL.onrender.com/api"
  }
}
```

#### Step 2: Commit Changes

```bash
git add vercel.json
git commit -m "Update backend URL for Render"
git push origin main
```

---

#### Step 3: Deploy to Vercel

**Method A: Via Vercel Website**

1. Go to [Vercel.com](https://vercel.com)
2. Click **"Add New..."** → **"Project"**
3. Import your GitHub repository
4. Configure:
   - **Framework Preset**: Vite
   - **Root Directory**: `./frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
5. Add Environment Variable:
   - Name: `VITE_API_BASE_URL`
   - Value: `https://your-render-backend.onrender.com/api`
6. Click **"Deploy"**

**Method B: Via Vercel CLI**

```bash
npm install -g vercel
vercel login
vercel
```

Follow prompts and deploy!

---

## 📊 Architecture on Render

```
┌─────────────────┐
│   User Browser  │
└────────┬────────┘
         │
         ├──────────────┐
         │              │
         ▼              ▼
    ┌─────────┐    ┌──────────┐
    │ Vercel  │    │  Render  │
    │(Static) │    │(Backend) │
    └─────────┘    └────┬─────┘
         │              │
         │ API Calls    │ PostgreSQL
         └─────────────►│
                        │
                     Database
```

---

## 💰 Render Pricing

### Free Tier:
- ✅ 750 hours/month free (~24 days)
- ✅ 512MB RAM per service
- ✅ Shared CPU
- ✅ Auto-sleep after 15 min inactivity

**Note:** Free tier services spin down after inactivity. First request after sleep takes ~30 seconds to wake up.

### Starter Plan ($7/month):
- ✅ Always-on (no sleeping)
- ✅ More RAM/CPU
- ✅ Priority support

**Recommendation:** Start with free tier, upgrade if needed.

---

## 🔧 Alternative: Simplified render.yaml

If the current `render.yaml` has issues, here's a cleaner version:

```yaml
services:
  # Backend Service (Spring Boot API)
  - type: web
    name: jwt-auth-backend
    env: java
    region: oregon
    plan: free
    
    buildCommand: cd backend && ./mvnw clean package -DskipTests
    startCommand: java -jar target/*.jar
    
    envVars:
      - key: JAVA_VERSION
        value: 17
      - key: SPRING_PROFILES_ACTIVE
        value: production
      - key: JWT_SECRET
        generateValue: true
      - key: PORT
        value: 10000
      - key: DATABASE_URL
        fromDatabase:
          name: jwt-auth-db
          property: connectionString
  
  databases:
    - name: jwt-auth-db
      databaseName: jwt_auth_db
      diskSizeGB: 1
      plan: free
```

---

## 🆘 Troubleshooting

### Backend Won't Start

**Check logs:**
Render Dashboard → jwt-auth-backend → Logs

**Common issues:**

1. **Maven build fails**
   - Check `pom.xml` syntax
   - Ensure Java 17 configured
   
2. **Port binding error**
   - Set `PORT=10000` in environment variables
   
3. **Database connection fails**
   - Either remove DATABASE_URL (uses H2), OR
   - Add PostgreSQL addon properly

4. **Out of memory**
   - Free tier has 512MB limit
   - Consider upgrading to Starter plan

---

### Frontend Can't Connect

**Issue:** CORS errors or can't reach backend

**Fix:**

1. **Update CORS in backend:**
   ```
   cors.allowed.origins=https://your-app.vercel.app
   ```
   Add to Render environment variables

2. **Verify backend URL in vercel.json:**
   ```json
   "destination": "https://your-backend.onrender.com/api/$1"
   ```

3. **Test backend directly:**
   Visit: `https://your-backend.onrender.com/api/auth/login`
   Should return 400/401

---

### Slow Cold Starts

**Problem:** First request takes 30+ seconds

**Cause:** Free tier spins down after inactivity

**Solutions:**
1. Upgrade to Starter plan ($7/month) - always on
2. Use external uptime monitor to ping every 10 min
3. Accept it for hobby/testing use

---

## ✅ Success Checklist

After deployment:

- [ ] Backend deployed on Render
- [ ] Green checkmark showing
- [ ] Can access backend URL
- [ ] API responds at `/api/auth/login`
- [ ] Frontend deployed on Vercel
- [ ] Can access frontend URL
- [ ] Registration works
- [ ] Login works
- [ ] Profile page accessible
- [ ] No console errors

---

## 🎯 Quick Start Commands

### Deploy Backend Only

```bash
# 1. Push to GitHub
git push origin main

# 2. Go to render.com
# 3. New + → Blueprint
# 4. Connect repo
# 5. Apply
```

### Deploy Frontend to Vercel

```bash
# Update vercel.json with Render backend URL first!

# Then:
vercel --prod
```

---

## 📞 Render vs Railway Comparison

| Feature | Render | Railway |
|---------|--------|---------|
| **Java Support** | ⭐⭐⭐⭐⭐ Native | ⭐⭐⭐ Via Nixpacks/Docker |
| **Free Tier** | ⭐⭐⭐⭐ 750 hrs | ⭐⭐⭐⭐ $5 credit |
| **Cold Start** | ⚠️ 30 sec | ✅ Fast |
| **PostgreSQL** | ⭐⭐⭐⭐⭐ Managed | ⭐⭐⭐⭐ Addon |
| **Ease of Use** | ⭐⭐⭐⭐⭐ Simple | ⭐⭐⭐⭐ Medium |
| **Documentation** | ⭐⭐⭐⭐⭐ Excellent | ⭐⭐⭐⭐ Good |

**Verdict:** Render is better for Spring Boot! ✅

---

## 🎉 What's Next?

1. **Choose deployment option:**
   - Option 1: Backend on Render + Frontend on Vercel (recommended)
   - Option 2: Both on Render

2. **Follow the steps above**

3. **Test your application!**

---

## 📚 Additional Resources

- **Render Docs:** https://docs.render.com
- **Spring Boot on Render:** https://docs.render.com/web-services#java
- **Render Discord:** https://discord.gg/render
- **Your Guides:**
  - `FIX_ACCESS_DENIED.md` - General troubleshooting
  - `BACKEND_DEPLOYMENT_FIX.md` - Backend issues
  - `VERCEL_QUICKSTART.md` - Frontend deployment

---

*Render Deployment Guide v1.0 | Last Updated: March 20, 2026*

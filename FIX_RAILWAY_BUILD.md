# 🚨 Railway Build Failed - Quick Fix!

## Problem
Both frontend and backend builds are failing on Railway.

## ✅ Solution: Deploy Backend Only on Railway

**Why?** Building both together is complex. Better approach:
- **Backend**: Railway (Java Spring Boot)
- **Frontend**: Vercel (static hosting, easier)

---

## 🔧 Step 1: Update Configuration (Already Done!)

I've updated your files for backend-only deployment on Railway:

### Updated Files:
- ✅ `railway.json` - Backend only
- ✅ `nixpacks.toml` - Backend only  
- ✅ `vercel.json` - Frontend for Vercel

---

## 🚀 Step 2: Redeploy on Railway

### Option A: Via Railway Dashboard (Easiest)

1. **Go to Railway dashboard**
2. **Delete current deployment** (if exists)
3. **Click "New Project"**
4. **Deploy from GitHub** → Select your repo
5. **Add PostgreSQL Database**:
   - Click "New" → "Database" → "PostgreSQL"
6. **Set Environment Variables**:
   ```
   JWT_SECRET=YourSuperSecretProductionKey2024!ChangeThis
   SPRING_PROFILES_ACTIVE=production
   PORT=10000
   cors.allowed.origins=*
   ```
7. **Click "Deploy"**

Railway will now ONLY build the backend (much simpler!).

---

### Option B: Via Railway CLI

```bash
# Login to Railway
railway login

# Initialize project (if not done)
railway init

# Add PostgreSQL
railway add postgresql

# Set environment variables
railway variables set JWT_SECRET=YourSecret2024!
railway variables set SPRING_PROFILES_ACTIVE=production
railway variables set PORT=10000

# Deploy
railway up
```

---

## 🎯 Step 3: Deploy Frontend to Vercel

Once backend is deployed on Railway:

### Get Your Railway Backend URL

Railway dashboard → Settings → Domains

Example: `https://your-app-production.up.railway.app`

### Update vercel.json

Replace `your-railway-backend` with your actual URL:

```json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "https://YOUR-ACTUAL-URL.up.railway.app/api/$1"
    }
  ],
  "env": {
    "VITE_API_BASE_URL": "https://YOUR-ACTUAL-URL.up.railway.app/api"
  }
}
```

### Deploy to Vercel

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel
```

Follow prompts and you're done!

---

## ✅ What This Does

### Railway (Backend):
- ✅ Builds only Spring Boot backend
- ✅ Runs on port 10000
- ✅ Provides REST API
- ✅ Manages PostgreSQL database

### Vercel (Frontend):
- ✅ Builds Vite frontend
- ✅ Serves static files
- ✅ Proxies API calls to Railway backend
- ✅ Automatic HTTPS and CDN

---

## 🔍 Troubleshooting

### Backend Still Fails on Railway?

**Check logs:**
Railway dashboard → Deployments → View Logs

**Common issues:**

1. **Maven build error**
   ```bash
   # Test locally
   cd backend
   ./mvnw clean package -DskipTests
   ```

2. **Port binding error**
   - Ensure `PORT=10000` is set in Railway variables

3. **Database connection error**
   - Ensure PostgreSQL addon is added
   - Check DATABASE_URL variable exists

### Frontend Can't Connect to Backend?

1. **Update CORS in Railway**
   ```
   cors.allowed.origins=https://your-app.vercel.app
   ```

2. **Update vercel.json with correct backend URL**

3. **Test backend directly**
   ```
   Visit: https://your-railway-url.up.railway.app/api/auth/login
   Should return 400/401 (not 404 or timeout)
   ```

---

## 📊 Architecture

```
User Browser
     │
     ├──────────────┐
     │              │
     ▼              ▼
┌─────────┐   ┌──────────┐
│ Vercel  │   │ Railway  │
│(Static) │   │  (API)   │
└─────────┘   └──────────┘
     │              │
     │ API Calls    │ Database
     └─────────────►│
                    │
                 PostgreSQL
```

---

## 💰 Cost

- **Railway**: ~$3-5/month (backend + database)
- **Vercel**: Free (frontend static hosting)
- **Total**: ~$3-5/month

---

## 🎉 Success Checklist

- [ ] Backend deployed on Railway
- [ ] PostgreSQL database connected
- [ ] Backend URL obtained
- [ ] Frontend deployed on Vercel
- [ ] vercel.json updated with backend URL
- [ ] Can access frontend
- [ ] Can register/login
- [ ] No console errors

---

## 🆘 Need More Help?

1. **Share Build Logs**
   - Railway dashboard → Deployments → View Logs
   
2. **Check Error Messages**
   - Look for specific error (Maven, Node.js, etc.)
   
3. **Test Locally First**
   ```bash
   cd backend && ./mvnw clean package -DskipTests
   cd ../frontend && npm run build
   ```

---

## 🔄 Alternative: Both on Railway (Advanced)

If you really want both on Railway, see:
- `RAILWAY_TROUBLESHOOTING.md` for advanced configuration
- Requires complex nixpacks setup
- Higher chance of build failures

**Recommended:** Use the separate approach above (Railway + Vercel)

---

**Next Steps:**
1. Delete current Railway deployment
2. Redeploy with new config (backend only)
3. Deploy frontend to Vercel
4. Connect them via environment variables

*Quick Fix v1.0 | Last Updated: March 20, 2026*

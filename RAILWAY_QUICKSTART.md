# 🚀 Railway Quick Start - Deploy in 10 Minutes!

## Why Railway?

✅ **One platform** for both frontend and backend  
✅ **Auto-deploys** on Git push  
✅ **PostgreSQL included** (managed database)  
✅ **Free $5 credit** to start  
✅ **Simple setup** - no complex configuration  

---

## ⚡ Fastest Deployment Method

### Option 1: Using Railway CLI (Recommended)

#### Step 1: Install Railway CLI
```bash
npm install -g @railway/cli
```

#### Step 2: Run the Automated Script
```bash
deploy-railway.bat
```

Follow the prompts, then run:
```bash
railway up
```

**Done!** Your app will deploy in ~10 minutes.

---

### Option 2: Deploy from GitHub (Easiest)

#### Step 1: Push Code to GitHub
```bash
git add .
git commit -m "Add Railway deployment config"
git push origin main
```

#### Step 2: Connect Railway to GitHub

1. Go to [Railway.app](https://railway.app)
2. Login with GitHub
3. Click **"New Project"**
4. Select **"Deploy from GitHub repo"**
5. Choose: `HansikaKhare/jwt-authentication-system`

#### Step 3: Add PostgreSQL Database

1. In your Railway project, click **"New"**
2. Select **"Database"** → **"PostgreSQL"**
3. Railway auto-creates DB and adds connection variables

#### Step 4: Set Environment Variables

In Railway dashboard → Variables tab, add:

```
JWT_SECRET=YourSuperSecretProductionKey2024!ChangeThis
SPRING_PROFILES_ACTIVE=production
PORT=10000
cors.allowed.origins=https://your-app-production.up.railway.app
```

#### Step 5: Deploy!

Click **"Deploy"** button and wait 5-10 minutes.

---

## 🎯 What Happens During Deployment?

Railway will:

1. ✅ Install Java 17 + Maven
2. ✅ Install Node.js 18
3. ✅ Build frontend (`npm run build`)
4. ✅ Build backend (`mvn package`)
5. ✅ Copy frontend files to backend
6. ✅ Create JAR file
7. ✅ Start Spring Boot server
8. ✅ Connect PostgreSQL database

**Result:** Everything runs as one service!

---

## 📊 After Deployment

### Get Your URL

Railway dashboard → Settings → Domains

Example: `https://jwt-auth-production.up.railway.app`

### Test Your App

1. **Visit:** `https://your-app.up.railway.app`
2. **Register** a new user
3. **Login** with credentials
4. **Access profile** page
5. **Check console** (F12) - should have no errors!

### Test API Endpoints

```bash
# Register
POST https://your-app.up.railway.app/api/auth/register

# Login
POST https://your-app.up.railway.app/api/auth/login

# Profile (requires JWT token)
GET https://your-app.up.railway.app/api/profile
```

---

## 🔧 Configuration Files Created

These files make Railway deployment work:

| File | Purpose |
|------|---------|
| `railway.json` | Railway project configuration |
| `nixpacks.toml` | Build instructions (Java + Node.js) |
| `deploy-railway.bat` | Automated setup script |
| `RAILWAY_DEPLOY_GUIDE.md` | Detailed deployment guide |

---

## 💰 Cost Estimate

**Free Tier:**
- $5 credit/month
- Enough for testing and development

**Typical Monthly Cost:**
- Backend (Java): ~$3-5
- Frontend (static): ~$0-1
- PostgreSQL: ~$0-1
- **Total:** ~$4-7 (covered by Hobby plan)

---

## 🔄 Continuous Deployment

Railway auto-deploys on every Git push!

```bash
# Make changes
git add .
git commit -m "Add new feature"
git push origin main

# Railway automatically rebuilds and deploys!
```

No manual intervention needed.

---

## 🆘 Troubleshooting

### Build Fails
```bash
# Test build locally first
cd backend
./mvnw clean package -DskipTests

cd ../frontend
npm run build
```

### Database Connection Error
- Ensure PostgreSQL addon is added in Railway
- Check DATABASE_URL environment variable exists

### CORS Errors
Add to Railway environment variables:
```
cors.allowed.origins=https://your-app.up.railway.app
```

### Port Errors
Ensure PORT variable is set:
```
PORT=10000
```

---

## 📱 Monitoring

### View Logs

**Dashboard:**
Railway project → Deployments → Latest → View Logs

**CLI:**
```bash
railway logs
```

### Open Dashboard
```bash
railway open
```

---

## ✅ Success Checklist

- [ ] Code pushed to GitHub
- [ ] Railway project created
- [ ] PostgreSQL database added
- [ ] Environment variables set
- [ ] Deployment successful
- [ ] Can access frontend
- [ ] Can register users
- [ ] Can login
- [ ] No console errors

---

## 🎉 You're Done!

Your full-stack JWT auth app is now live on Railway!

**URLs:**
- Frontend: `https://your-app.up.railway.app`
- Backend API: `https://your-app.up.railway.app/api`
- Database: Managed PostgreSQL (auto-configured)

**Next Steps:**
1. Test all features
2. Share your URL with friends!
3. Customize in Railway dashboard
4. Set up custom domain (optional)

---

## 📞 Need Help?

- **Railway Docs:** https://docs.railway.app
- **Discord:** https://discord.gg/railway
- **Status:** https://status.railway.app

---

**Happy deploying! 🚀**

*Quick Start v1.0 | Last Updated: March 20, 2026*

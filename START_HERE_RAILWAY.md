# 🎯 START HERE - Deploy to Railway (Recommended!)

## Welcome! 👋

Your full-stack JWT authentication app is ready to deploy on **Railway** - the best choice for hosting both frontend and backend together!

---

## ✅ Why Railway?

| Feature | Railway | Vercel + Separate Backend |
|---------|---------|---------------------------|
| **Frontend + Backend** | ✅ One platform | ❌ Two platforms |
| **Database** | ✅ PostgreSQL included | ❌ Separate setup |
| **Deployment** | ✅ Auto-deploy on Git push | ⚠️ Manual coordination |
| **Complexity** | ✅ Simple setup | ⚠️ More complex |
| **Cost** | ✅ $5 free credit | ✅ Free tiers available |
| **Management** | ✅ Single dashboard | ❌ Multiple dashboards |

---

## 🚀 Deploy in 10 Minutes!

### Option 1: Automated Script (Easiest) ⭐

```bash
# Step 1: Install Railway CLI
npm install -g @railway/cli

# Step 2: Run the automated script
deploy-railway.bat

# Step 3: Deploy!
railway up
```

Follow the prompts and you're done! 🎉

---

### Option 2: GitHub Deployment (Simple)

#### Step 1: Push to GitHub ✅ (Already Done!)

Your code is already on GitHub: `HansikaKhare/jwt-authentication-system`

#### Step 2: Connect Railway

1. Go to [Railway.app](https://railway.app)
2. Login with GitHub
3. Click **"New Project"**
4. Select **"Deploy from GitHub repo"**
5. Choose: `HansikaKhare/jwt-authentication-system`

#### Step 3: Add Database

1. In Railway project, click **"New"**
2. Select **"Database"** → **"PostgreSQL"**
3. Railway auto-creates DB and connection variables

#### Step 4: Set Environment Variables

In Railway dashboard → Variables, add:

```
JWT_SECRET=YourSuperSecretProductionKey2024!ChangeThis
SPRING_PROFILES_ACTIVE=production
PORT=10000
cors.allowed.origins=https://your-app-production.up.railway.app
```

#### Step 5: Deploy!

Click **"Deploy"** and wait 5-10 minutes.

---

## 📊 What Happens During Deployment?

Railway automatically:

1. ✅ Installs Java 17 + Maven
2. ✅ Installs Node.js 18
3. ✅ Builds frontend (`npm run build`)
4. ✅ Builds backend (`mvn package`)
5. ✅ Copies frontend to backend static folder
6. ✅ Creates executable JAR
7. ✅ Starts Spring Boot server
8. ✅ Connects PostgreSQL database

**Result:** Everything runs as ONE service!

---

## 🎯 After Deployment

### Get Your URL

Railway dashboard → Settings → Domains

Example: `https://jwt-auth-production.up.railway.app`

### Test Your App

1. **Visit:** `https://your-app.up.railway.app`
2. **Register** a new user
3. **Login** with credentials
4. **Access profile** page
5. **Check console** (F12) - should have no errors!

### API Endpoints

```
POST https://your-app.up.railway.app/api/auth/register
POST https://your-app.up.railway.app/api/auth/login
GET  https://your-app.up.railway.app/api/profile
```

---

## 📁 Files Created for Railway

| File | Purpose |
|------|---------|
| `railway.json` | Railway project configuration |
| `nixpacks.toml` | Build instructions (Java + Node.js) |
| `deploy-railway.bat` | Automated deployment script |
| `RAILWAY_QUICKSTART.md` | Quick start guide (10 min) |
| `RAILWAY_DEPLOY_GUIDE.md` | Complete detailed guide |
| `backend/pom.xml` | Updated to copy frontend resources |
| `README.md` | Updated with Railway instructions |

---

## 💰 Cost Breakdown

**Free Tier:**
- $5 credit/month (enough for testing)

**Typical Monthly Usage:**
- Backend (Java): ~$3-5
- Frontend (static): ~$0-1
- PostgreSQL: ~$0-1
- **Total:** ~$4-7/month

**Hobby Plan:** $5/month (includes $5 credit)

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

No manual work needed!

---

## 🆘 Troubleshooting

### Build Fails
```bash
# Test locally first
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

## 📱 Monitoring & Logs

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

Before considering deployment complete:

- [ ] Code pushed to GitHub
- [ ] Railway project created
- [ ] PostgreSQL database added
- [ ] Environment variables set
- [ ] Deployment successful
- [ ] Can access frontend
- [ ] Can register users
- [ ] Can login
- [ ] Can access profile
- [ ] No console errors

---

## 🎉 You're Ready!

Your full-stack JWT auth app will be live on Railway!

**URLs:**
- Frontend: `https://your-app.up.railway.app`
- Backend API: `https://your-app.up.railway.app/api`
- Database: Managed PostgreSQL (auto-configured)

**Next Steps:**
1. Test all features
2. Share your URL!
3. Customize in Railway dashboard
4. Set up custom domain (optional)

---

## 📞 Need Help?

Choose a guide based on your preference:

- ⚡ **Fast deployment:** Open `RAILWAY_QUICKSTART.md`
- 📖 **Detailed guide:** Open `RAILWAY_DEPLOY_GUIDE.md`
- 💬 **Railway Docs:** https://docs.railway.app
- 🎮 **Discord:** https://discord.gg/railway

---

## 🤔 Railway vs Vercel?

You have both options configured!

### Railway (Recommended) ⭐
- ✅ One platform for everything
- ✅ Simpler setup
- ✅ Automatic database
- ✅ Auto-deploy on Git push

### Vercel + Render/Railway
- ⚠️ Two separate deployments
- ⚠️ More complex setup
- ⚠️ Need to coordinate deployments

**Recommendation:** Use Railway for simplicity!

---

**Ready to deploy? Let's go!** 🚀

1. Read `RAILWAY_QUICKSTART.md` for fast deployment
2. OR read `RAILWAY_DEPLOY_GUIDE.md` for detailed instructions
3. Deploy your app!
4. Celebrate! 🎉

---

*Last Updated: March 20, 2026*  
*Railway Deployment Package v1.0*

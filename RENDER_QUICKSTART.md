# 🚀 Deploy to Render - Quick Start (10 Minutes!)

## Why Render?

✅ **Better for Spring Boot** than Railway  
✅ **Free tier** (750 hours/month)  
✅ **Managed PostgreSQL** included  
✅ **Auto-deploy** on Git push  
✅ **Simpler configuration**  

---

## ⚡ Fastest Method: Use render.yaml

Your project already has `render.yaml` configured! This makes deployment automatic.

### Step 1: Push to GitHub ✅

Already done! Your code is on GitHub.

---

### Step 2: Deploy on Render

1. **Go to [Render.com](https://render.com)**
2. **Sign up** with GitHub (recommended)
3. **Click "New +"** → **"Blueprint"**
4. **Connect repository:** Select `HansikaKhare/jwt-authentication-system`
5. **Render detects `render.yaml`** automatically!
6. **Click "Apply"**

That's it! Render deploys everything automatically! 🎉

---

### What Gets Deployed:

From your `render.yaml`:

**Backend Service:**
- Name: `jwt-auth-backend`
- Java 17 + Spring Boot
- Auto-builds with Maven
- PostgreSQL database connected
- Port: 10000

**Database:**
- Name: `jwt-auth-db`
- Managed PostgreSQL
- 1GB storage (free tier)
- Auto-connected to backend

---

### ⏱️ Deployment Timeline:

```
0:00 - Click Apply
0:30 - Render starts building
2:00 - Maven build in progress
5:00 - Building Docker image
7:00 - Starting Spring Boot
8:00 - Database connection established
9:00 - Health check passes ✅
9:30 - LIVE!
```

---

### 📊 Get Your URLs:

After deployment completes:

**Backend API:**
Render Dashboard → jwt-auth-backend → Copy URL

Example: `https://jwt-auth-backend-xyz.onrender.com`

**Test it:**
```bash
curl https://your-backend.onrender.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"usernameOrEmail":"test","password":"test"}'
```

Should return 400 or 401 (proves it's working!).

---

## 🎯 Option: Add Frontend on Vercel

Want to deploy frontend too?

### Step 1: Update vercel.json

Replace Railway URL with Render URL:

```json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "https://YOUR-BACKEND.onrender.com/api/$1"
    }
  ]
}
```

### Step 2: Deploy to Vercel

```bash
npm install -g vercel
vercel login
vercel
```

Follow prompts and done!

---

## 🔍 Monitor Deployment

### Watch Logs:

Render Dashboard → jwt-auth-backend → Logs

**Good signs:**
```
Building...
Starting...
Tomcat started on port 10000
Started JwtAuthApplication in 5.123 seconds
```

**Bad signs:**
```
Build failed
Error starting application
Cannot acquire connection
```

---

## 💰 Free Tier Details

**What you get free:**
- ✅ 750 hours/month (~24 days continuous)
- ✅ 512MB RAM
- ✅ Shared CPU
- ✅ 1GB PostgreSQL database
- ✅ Auto-deploy on Git push

**Limitation:**
- ⚠️ Spins down after 15 min inactivity
- ⚠️ First request takes ~30 sec to wake up

**Upgrade to Starter ($7/month):**
- ✅ Always-on (no sleeping)
- ✅ More resources
- ✅ Priority support

---

## 🆘 Troubleshooting

### Build Fails

**Check logs for specific error**

Common fixes:
- Maven can't download dependencies → Wait longer
- Java version mismatch → Already set to Java 17
- Out of memory → Upgrade plan

### App Won't Start

**Most common: Missing environment variables**

But `render.yaml` already sets them all! Check:
- `SPRING_PROFILES_ACTIVE=production` ✅
- `JWT_SECRET` (auto-generated) ✅
- `DATABASE_URL` (from PostgreSQL) ✅
- `PORT=10000` ✅

### Database Connection Fails

Your `render.yaml` auto-connects the database!

If issues:
1. Check PostgreSQL is running (green checkmark)
2. Verify DATABASE_URL exists in environment
3. Restart backend service

---

## ✅ Success Checklist

- [ ] Render account created
- [ ] Blueprint deployed from GitHub
- [ ] Backend shows green checkmark ✅
- [ ] PostgreSQL database running
- [ ] Can access backend URL
- [ ] API responds (400/401 OK)
- [ ] Frontend deployed (optional)
- [ ] Full app working

---

## 🎉 You're Done!

**Your URLs:**
- Backend: `https://jwt-auth-backend-xyz.onrender.com`
- Database: Managed PostgreSQL (auto-connected)
- Frontend: (if deployed on Vercel) `https://your-app.vercel.app`

**Next steps:**
1. Test registration/login
2. Share your URL!
3. Monitor usage in Render dashboard

---

## 📞 Need Help?

- **Render Docs:** https://docs.render.com
- **Discord:** https://discord.gg/render
- **Status:** https://status.render.com

---

*Quick Start v1.0 | Last Updated: March 20, 2026*

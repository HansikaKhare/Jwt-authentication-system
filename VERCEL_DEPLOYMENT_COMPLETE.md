# 🚀 Deploy Your JWT Auth App on Vercel - Complete Guide

## ⚡ Quick Overview

This guide will help you deploy your full-stack JWT authentication application using:
- **Frontend**: Vercel (static hosting)
- **Backend**: Render or Railway (Spring Boot API)

> **Important**: Vercel hosts only the frontend. You need a separate service for the Spring Boot backend.

---

## 📋 What You'll Get After Deployment

- ✅ Frontend URL: `https://your-app.vercel.app`
- ✅ Backend URL: `https://your-app.onrender.com` (or Railway)
- ✅ Automatic HTTPS on both services
- ✅ API proxying through Vercel (`/api/*` → backend)
- ✅ CORS properly configured
- ✅ Environment variables secured

---

## 🎯 Step-by-Step Deployment

### Phase 1: Deploy Backend (Do This First!)

#### Option A: Deploy to Render.com ⭐ Recommended

**1. Prepare Your Repository**
```bash
# Make sure your code is on GitHub
git add .
git commit -m "Prepare for deployment"
git push origin main
```

**2. Deploy on Render**
1. Visit [Render.com](https://render.com) and sign up/login
2. Click **"New +"** → **"Blueprint"**
3. Connect your GitHub account
4. Select your repository
5. Render will detect the `render.yaml` file automatically
6. Click **"Apply"**
7. Wait 3-5 minutes for deployment

**3. Get Your Backend URL**
- Once deployed, copy the URL (e.g., `https://jwt-auth-system-xyz.onrender.com`)
- Test it: Visit `https://your-backend-url.onrender.com/api/auth/login` (should return 400/401)

**4. Set Environment Variables on Render**
In Render dashboard → Environment:
```
JWT_SECRET=YourSuperSecretKeyForProductionUse2024!
cors.allowed.origins=https://your-app.vercel.app,http://localhost:5173
```

---

#### Option B: Deploy to Railway.app

**1. Deploy on Railway**
1. Visit [Railway.app](https://railway.app) and sign up/login
2. Click **"New Project"** → **"Deploy from GitHub repo"**
3. Select your repository
4. Railway auto-detects Java/Maven
5. Wait for deployment (~5 minutes)

**2. Configure Environment Variables**
In Railway dashboard → Variables:
```
JWT_SECRET=YourSuperSecretKeyForProductionUse2024!
cors.allowed.origins=https://your-app.vercel.app,http://localhost:5173
PORT=8080
```

**3. Get Your Backend URL**
- Copy the public URL (e.g., `https://your-app.railway.app`)

---

### Phase 2: Update Configuration Files

**1. Update `vercel.json`**

Open `vercel.json` and replace `YOUR-BACKEND-URL` with your actual backend URL:

```json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "https://YOUR-ACTUAL-BACKEND-URL.onrender.com/api/$1"
    }
  ],
  "env": {
    "VITE_API_BASE_URL": "https://YOUR-ACTUAL-BACKEND-URL.onrender.com/api"
  }
}
```

**Example (with real URL):**
```json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "https://jwt-auth-system-xyz.onrender.com/api/$1"
    }
  ],
  "env": {
    "VITE_API_BASE_URL": "https://jwt-auth-system-xyz.onrender.com/api"
  }
}
```

**2. Commit the Changes**
```bash
git add vercel.json
git commit -m "Configure Vercel for production"
git push origin main
```

---

### Phase 3: Deploy Frontend to Vercel

#### Method 1: Using Vercel CLI (Fastest) ⚡

**1. Install Vercel CLI**
```bash
npm install -g vercel
```

**2. Login to Vercel**
```bash
vercel login
```

**3. Deploy**

Use the automated script:
```bash
deploy-vercel.bat
```

Or run manually:
```bash
vercel
```

**4. Follow the Prompts**
```
Set up and deploy? Y
Which scope? (select your account)
Link to existing project? N
Project name? jwt-auth-system
In which directory is your code? .
Want to override settings? N
```

**5. Note Your Preview URL**
- You'll get a URL like: `https://your-project-git-main.vercel.app`

---

#### Method 2: Using Vercel Website

**1. Create New Project**
1. Visit [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **"Add New..."** → **"Project"**
3. Import your Git repository
4. Select your account/repo

**2. Configure Build Settings**
- **Framework Preset**: Vite
- **Root Directory**: `./frontend`
- **Build Command**: `npm run build`
- **Output Directory**: `frontend/dist`

**3. Add Environment Variable**
Click "Environment Variables" → Add:
- Name: `VITE_API_BASE_URL`
- Value: `https://your-backend-url.onrender.com/api`

**4. Deploy**
Click **"Deploy"** and wait ~2 minutes

---

### Phase 4: Configure CORS in Backend

**Update Backend CORS Settings**

On Render/Railway dashboard, add environment variable:
```
cors.allowed.origins=https://your-app.vercel.app,http://localhost:5173
```

Replace `https://your-app.vercel.app` with your actual Vercel URL.

**Redeploy Backend**
- Render: Auto-redeploys on env change
- Railway: May need manual redeploy

Wait 2-3 minutes for changes to take effect.

---

### Phase 5: Set Vercel Environment Variables

**1. Go to Vercel Dashboard**
- Visit your project → Settings → Environment Variables

**2. Add Variable**
- Name: `VITE_API_BASE_URL`
- Value: `https://your-backend-url.onrender.com/api`
- Environment: Production

**3. Redeploy**
- Go to Deployments → Click latest → Redeploy

---

## ✅ Testing Your Deployment

### 1. Access Your App
Visit: `https://your-app.vercel.app`

### 2. Open Browser DevTools
Press **F12** → Console tab

### 3. Test Registration
- Click "Register" 
- Fill in:
  - Username: `testuser`
  - Email: `test@example.com`
  - Password: `password123`
- Submit

### 4. Verify Success
✅ Should redirect to profile page  
✅ Check localStorage: F12 → Application → Local Storage → `jwt_token` exists  
✅ No console errors

### 5. Test Logout
- Click "Logout"
- Should redirect to login page
- Token removed from localStorage

### 6. Test Login
- Enter credentials
- Should access profile page
- JWT token stored correctly

---

## 🔧 Troubleshooting

### ❌ CORS Errors

**Problem**: Console shows "CORS policy blocked"

**Solution**:
1. In backend (Render/Railway), set:
   ```
   cors.allowed.origins=https://your-app.vercel.app
   ```
2. Redeploy backend
3. Wait 2-3 minutes
4. Clear browser cache and retry

---

### ❌ Cannot Connect to Backend

**Problem**: "Cannot connect to backend server" error

**Solution**:
1. Verify backend URL is correct in `vercel.json`
2. Visit backend directly: `https://your-backend-url.onrender.com/api/auth/login`
3. Check backend logs for errors
4. Ensure backend is running (not crashed)

---

### ❌ Build Failed on Vercel

**Problem**: Vercel build fails

**Solution**:
1. Check `frontend/package.json` exists
2. Verify build command in `vercel.json`:
   ```json
   "buildCommand": "cd frontend && npm install && npm run build"
   ```
3. Review build logs for specific errors
4. Try locally: `cd frontend && npm install && npm run build`

---

### ❌ 404 on Page Refresh

**Problem**: Refreshing page shows 404

**Solution**: Already handled in `vercel.json` with rewrites configuration. If issue persists, check:
1. `vercel.json` has rewrites section
2. All HTML files are in `frontend/dist` after build

---

### ❌ JWT Token Not Working

**Problem**: Can't access protected routes after login

**Solution**:
1. Check token format in localStorage (should be long string)
2. Verify Authorization header: `Bearer <token>`
3. Check backend JWT secret matches deployment
4. Decode token at [jwt.io](https://jwt.io) to verify validity

---

## 📊 Monitoring & Maintenance

### Check Deployment Status

**Vercel**:
- Dashboard → Your project → Analytics
- View deployment history
- Check performance metrics

**Render**:
- Dashboard → Your service → Metrics
- View logs
- Monitor uptime

**Railway**:
- Dashboard → Your project → Activity
- View logs and resource usage

---

### Update Your App

**Frontend Updates**:
```bash
# Make changes, then:
git push origin main
vercel --prod
```

**Backend Updates**:
```bash
# Push to GitHub (Render auto-deploys)
git push origin main

# Or manually trigger redeploy in Railway
```

---

## 💰 Cost Breakdown

### Free Tier Limits

| Service | Free Tier | Paid Plans |
|---------|-----------|------------|
| **Vercel** | Unlimited deployments, 100GB bandwidth/month | Pro: $20/month |
| **Render** | 750 hours/month (spins down after 15min inactivity) | Starter: $7/month |
| **Railway** | $5 credit/month | Pay-as-you-go |

### Recommendation
Start with free tiers. Upgrade if:
- Need always-on backend (Render Starter: $7/month)
- Need custom domain (Vercel Pro: $20/month)
- High traffic (>100GB/month)

---

## 🔐 Security Best Practices

### ✅ Do's
- Use strong JWT secrets (32+ characters)
- Enable HTTPS everywhere (automatic)
- Store secrets in environment variables
- Regular dependency updates
- Monitor for suspicious activity

### ❌ Don'ts
- Never commit `.env` files
- Never hardcode secrets in code
- Don't use weak passwords
- Don't skip CORS configuration
- Don't ignore security warnings

---

## 📚 Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Render Documentation](https://render.com/docs)
- [Railway Documentation](https://docs.railway.app)
- [Spring Boot Guides](https://spring.io/guides)
- [Vite Documentation](https://vitejs.dev/guide/)

---

## 🎉 Success Checklist

Before considering deployment complete, verify:

- [ ] Frontend loads without errors
- [ ] Backend responds to API calls
- [ ] User registration works
- [ ] Login successful
- [ ] Profile page accessible
- [ ] JWT token stored in localStorage
- [ ] Logout functionality works
- [ ] No CORS errors in console
- [ ] HTTPS enabled on both services
- [ ] Mobile responsive design works
- [ ] Tested on multiple browsers

---

## 🆘 Getting Help

If you're stuck:

1. **Check Logs**: Most issues are visible in deployment logs
2. **Search Errors**: Google specific error messages
3. **Documentation**: Read official docs for each service
4. **Community**: Ask on Stack Overflow, Reddit r/webdev
5. **GitHub Issues**: Check if others have similar issues

---

## 🎯 What's Next?

After successful deployment:

1. **Custom Domain**: Buy domain and connect to Vercel
2. **Database**: Upgrade to PostgreSQL/MySQL for production
3. **Monitoring**: Add Sentry, LogRocket, or similar
4. **CI/CD**: Set up automated testing before deployment
5. **Scaling**: Consider load balancing for high traffic

---

**Congratulations! Your JWT authentication app is now live! 🚀**

---

*Last Updated: March 20, 2026*
*Guide Version: 1.0*

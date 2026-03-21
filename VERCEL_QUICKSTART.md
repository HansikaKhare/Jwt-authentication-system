# Quick Start - Deploy to Vercel

## Prerequisites
- Node.js installed (v16 or higher)
- Git installed
- GitHub account
- Vercel account (free)
- Backend deployed on Render, Railway, or similar service

---

## Step 1: Deploy Your Backend First

Since Vercel only hosts frontend, deploy your Spring Boot backend to one of these services:

### Option A: Render.com (Recommended for beginners)
```bash
# Already configured with render.yaml file
# Just push to GitHub and connect on Render
```

1. Push your code to GitHub
2. Go to https://render.com
3. Click "New +" → "Blueprint"
4. Connect your GitHub repo
5. Select `render.yaml` file
6. Click "Apply"

### Option B: Railway.app
1. Go to https://railway.app
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your repository
4. Railway auto-detects Java/Maven projects

**Get your backend URL after deployment** (e.g., `https://myapp.onrender.com`)

---

## Step 2: Update Configuration

### Update vercel.json
Replace `YOUR-BACKEND-URL` with your actual backend URL:

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

### Update CORS in Backend
In your Spring Boot application, add your future Vercel URL to allowed origins:

```java
// In SecurityConfig.java
.allowedOrigins("https://your-app.vercel.app")
```

---

## Step 3: Deploy Frontend to Vercel

### Method 1: Using Vercel CLI (Easiest)

Run the deployment script:
```bash
deploy-vercel.bat
```

Or manually:
```bash
# Install Vercel CLI (if not already installed)
npm install -g vercel

# Login to Vercel
vercel login

# Deploy
vercel
```

Follow the prompts:
- Set up and deploy? **Y**
- Which scope? (select your account)
- Link to existing project? **N**
- Project name? **jwt-auth-system**
- In which directory is your code? **.**
- Want to override settings? **N**

### Method 2: Using Vercel Website

1. Go to https://vercel.com
2. Click "Add New..." → "Project"
3. Import your Git repository
4. Configure:
   - **Framework Preset**: Vite
   - **Root Directory**: `./frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
5. Add environment variable:
   - Name: `VITE_API_BASE_URL`
   - Value: `https://your-backend-url.onrender.com/api`
6. Click "Deploy"

---

## Step 4: Set Environment Variables

In Vercel Dashboard:
1. Go to your project settings
2. Navigate to "Environment Variables"
3. Add:
   - Name: `VITE_API_BASE_URL`
   - Value: Your backend URL (e.g., `https://myapp.onrender.com/api`)
4. Redeploy if needed

---

## Step 5: Test Your Deployment

1. Visit your Vercel app: `https://your-app.vercel.app`
2. Test registration
3. Test login
4. Verify profile page works
5. Check browser console for errors

---

## Common Issues & Solutions

### CORS Errors
**Problem**: Browser shows CORS policy errors

**Solution**: Update backend CORS configuration:
```java
@Bean
public CorsConfigurationSource corsConfigurationSource() {
    CorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    CorsConfiguration config = new CorsConfiguration();
    config.setAllowedOrigins(Arrays.asList(
        "https://your-app.vercel.app",
        "http://localhost:8080"
    ));
    config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
    config.setAllowedHeaders(Collections.singletonList("*"));
    config.setAllowCredentials(true);
    source.registerCorsConfiguration("/**", config);
    return source;
}
```

### Backend Connection Failed
**Problem**: Frontend can't reach backend

**Solution**: 
1. Verify backend URL in `vercel.json` is correct
2. Check backend is running (visit it directly)
3. Ensure environment variables are set in Vercel

### Build Fails
**Problem**: Vercel build fails

**Solution**:
1. Check `package.json` is in `frontend` directory
2. Verify build command: `cd frontend && npm install && npm run build`
3. Check output directory: `frontend/dist`

---

## Deployment Commands Cheat Sheet

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy to preview
vercel

# Deploy to production
vercel --prod

# View deployment logs
vercel ls

# Pull environment variables locally
vercel env pull
```

---

## Production Checklist

- ✅ Backend deployed and accessible
- ✅ Backend URL updated in `vercel.json`
- ✅ CORS configured for Vercel domain
- ✅ Environment variables set in Vercel
- ✅ Tested all features (register, login, profile)
- ✅ No console errors
- ✅ HTTPS working

---

## URLs After Deployment

You'll have:
- **Frontend**: `https://your-app.vercel.app`
- **Backend**: `https://your-app.onrender.com` (or Railway URL)
- **API**: `https://your-app.vercel.app/api/*` (proxies to backend)

---

## Costs

- **Vercel**: Free for hobby projects
- **Render**: Free tier available (spins down after inactivity)
- **Railway**: Pay-as-you-go (~$5/month for light usage)

---

## Need Help?

- Vercel Docs: https://vercel.com/docs
- Render Docs: https://render.com/docs
- Railway Docs: https://docs.railway.app

# Vercel Deployment Guide for JWT Auth System

## Overview
This guide will help you deploy the frontend to Vercel and the backend to a cloud service (Render, Railway, or similar).

## Important Architecture Note
**Vercel is primarily for frontend hosting.** Since this is a full-stack application with a Spring Boot backend, you have two options:

### Option 1: Separate Deployments (Recommended)
- **Frontend**: Deploy to Vercel (static hosting)
- **Backend**: Deploy to Render, Railway, or any cloud service that supports Spring Boot

### Option 2: Backend as Serverless Functions (Complex)
- Convert Spring Boot endpoints to Vercel serverless functions (requires significant refactoring)

---

## Step-by-Step: Option 1 (Recommended)

### Part 1: Deploy Backend First

#### A. Deploy to Render.com
1. Create a `render.yaml` file (already exists in your project)
2. Push your code to GitHub
3. Go to [Render](https://render.com) and create an account
4. Click "New +" → "Blueprint"
5. Connect your GitHub repository
6. Select the `render.yaml` file
7. Click "Apply"

#### B. Deploy to Railway.app
1. Go to [Railway](https://railway.app) and create an account
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your repository
4. Railway will auto-detect it's a Java/Maven project
5. Add environment variables:
   - `JWT_SECRET`: Your secret key
   - Database connection details (if using external DB)

#### C. Get Your Backend URL
After deployment, you'll get a URL like:
- Render: `https://your-app-name.onrender.com`
- Railway: `https://your-app-name.railway.app`

### Part 2: Deploy Frontend to Vercel

#### A. Prepare for Deployment
1. Update `vercel.json` with your actual backend URL:
```json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "https://YOUR-BACKEND-URL.onrender.com/api/$1"
    }
  ],
  "env": {
    "VITE_API_BASE_URL": "https://YOUR-BACKEND-URL.onrender.com/api"
  }
}
```

#### B. Deploy via Vercel CLI
1. Install Vercel CLI:
```bash
npm install -g vercel
```

2. Navigate to project root:
```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task"
```

3. Login to Vercel:
```bash
vercel login
```

4. Deploy:
```bash
vercel
```

5. Follow the prompts:
   - Set up and deploy? **Y**
   - Which scope? (select your account)
   - Link to existing project? **N**
   - Project name? **jwt-auth-system** (or your choice)
   - In which directory is your code? **.** (current directory)
   - Want to override settings? **N**

#### C. Deploy via Vercel Website (Alternative)
1. Go to [Vercel](https://vercel.com)
2. Click "Add New..." → "Project"
3. Import your Git repository
4. Configure build settings:
   - **Framework Preset**: Vite
   - **Root Directory**: `./frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
5. Add environment variable:
   - Name: `VITE_API_BASE_URL`
   - Value: `https://your-backend-url.onrender.com/api`
6. Click "Deploy"

### Part 3: Update CORS Settings in Backend

Update your Spring Boot application to allow requests from your Vercel domain:

In `SecurityConfig.java`, ensure CORS is configured for your Vercel URL:
```java
.allowedOrigins("https://your-app.vercel.app")
```

Or add to `application.properties`:
```properties
cors.allowed.origins=https://your-app.vercel.app
```

---

## Environment Variables

### Frontend (Vercel)
Set these in Vercel dashboard → Project Settings → Environment Variables:
- `VITE_API_BASE_URL`: Your backend URL (e.g., `https://myapp.onrender.com/api`)

### Backend (Render/Railway)
Set these in your cloud service dashboard:
- `JWT_SECRET`: Your secret key for JWT tokens
- Database credentials (if using external database)

---

## Testing After Deployment

1. **Access your Vercel app**: `https://your-app.vercel.app`
2. **Test registration**: Create a new account
3. **Test login**: Verify JWT token is stored
4. **Test profile page**: Ensure API calls work correctly
5. **Check browser console**: Look for any CORS errors

---

## Troubleshooting

### CORS Errors
If you see CORS errors in browser console:
1. Update backend CORS configuration to include your Vercel URL
2. Redeploy the backend after changes

### API Calls Failing
1. Verify backend URL in `vercel.json` is correct
2. Check that backend is running (visit `/api/auth/login` endpoint directly)
3. Ensure environment variables are set correctly in Vercel

### Build Failures
1. Make sure `package.json` is in the `frontend` directory
2. Verify build command: `cd frontend && npm install && npm run build`
3. Check output directory: `frontend/dist`

---

## Quick Deploy Commands

### Deploy Frontend Updates
```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task"
vercel --prod
```

### Redeploy Backend (if using Render)
Render automatically redeploys when you push to your main branch.

---

## Cost Considerations

- **Vercel**: Free tier available for hobby projects
- **Render**: Free tier available but instances spin down after inactivity
- **Railway**: Pay-as-you-go pricing

---

## Production Checklist

- [ ] Backend deployed and accessible
- [ ] Frontend deployed to Vercel
- [ ] Backend URL updated in `vercel.json`
- [ ] CORS configured in backend for Vercel domain
- [ ] Environment variables set in both platforms
- [ ] Tested registration, login, and profile access
- [ ] No console errors in browser
- [ ] HTTPS enabled on both services

---

## Notes

- The free tier of Render spins down after 15 minutes of inactivity (cold start ~30 seconds)
- Vercel deployments are instant and rollback-capable
- Keep your JWT secret secure and never commit it to version control
- Consider using a production database (PostgreSQL/MySQL) instead of H2 for production

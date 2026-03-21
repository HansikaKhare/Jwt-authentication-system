# Vercel Deployment Checklist

## Before You Start

- [ ] Node.js installed (v16+)
- [ ] Git installed and configured
- [ ] GitHub account created
- [ ] Vercel account created (free at vercel.com)
- [ ] Backend service chosen (Render, Railway, etc.)

---

## Phase 1: Deploy Backend (Required First)

### Choose One Platform:

#### Option A: Render.com
- [ ] Push code to GitHub
- [ ] Create account on Render.com
- [ ] Click "New +" → "Blueprint"
- [ ] Connect GitHub repository
- [ ] Select `render.yaml` file
- [ ] Click "Apply"
- [ ] Wait for deployment to complete
- [ ] Copy backend URL (e.g., `https://myapp.onrender.com`)

#### Option B: Railway.app
- [ ] Push code to GitHub
- [ ] Create account on Railway.app
- [ ] Click "New Project" → "Deploy from GitHub"
- [ ] Select your repository
- [ ] Wait for auto-deployment
- [ ] Copy backend URL (e.g., `https://myapp.railway.app`)

#### Option C: Other Services
- [ ] Deploy Spring Boot app to your preferred service
- [ ] Ensure it has HTTPS endpoint
- [ ] Copy backend URL

---

## Phase 2: Update Configuration Files

### Update `vercel.json`
- [ ] Replace `YOUR-BACKEND-URL` with actual backend URL in `vercel.json`
- [ ] Example: `"destination": "https://myapp.onrender.com/api/$1"`
- [ ] Commit changes to Git

### Update Backend CORS
- [ ] Open `SecurityConfig.java`
- [ ] Add your future Vercel URL to allowed origins (line 79):
  ```java
  configuration.setAllowedOrigins(List.of(
      "http://localhost:5173", 
      "http://localhost:3000",
      "https://your-app.vercel.app" // Add this
  ));
  ```
- [ ] Commit and push to GitHub
- [ ] Wait for backend redeployment

---

## Phase 3: Deploy Frontend to Vercel

### Method 1: Using CLI (Recommended)
- [ ] Install Vercel CLI: `npm install -g vercel`
- [ ] Login: `vercel login`
- [ ] Run deployment script: `deploy-vercel.bat`
- [ ] OR run manually: `vercel`
- [ ] Follow prompts:
  - Set up and deploy? **Y**
  - Link to existing project? **N**
  - Project name? **jwt-auth-system**
  - Directory? **.**
- [ ] Note the preview URL

### Method 2: Using Website
- [ ] Go to vercel.com
- [ ] Click "Add New..." → "Project"
- [ ] Import GitHub repository
- [ ] Configure build settings:
  - Framework: Vite
  - Root Directory: `./frontend`
  - Build Command: `npm run build`
  - Output Directory: `frontend/dist`
- [ ] Add environment variable:
  - Name: `VITE_API_BASE_URL`
  - Value: `https://your-backend-url.onrender.com/api`
- [ ] Click "Deploy"

---

## Phase 4: Configure Environment Variables

### In Vercel Dashboard
- [ ] Go to project settings
- [ ] Navigate to "Environment Variables"
- [ ] Add `VITE_API_BASE_URL`
- [ ] Set value to your backend URL
- [ ] Redeploy if needed (Settings → Deployments → Redeploy)

---

## Phase 5: Testing

### Test All Features
- [ ] Visit your Vercel URL
- [ ] Open browser DevTools (F12)
- [ ] Test user registration
- [ ] Test login functionality
- [ ] Verify JWT token stored in localStorage
- [ ] Access profile page
- [ ] Test logout
- [ ] Check for any console errors
- [ ] Test page refresh (token persistence)

### API Tests
- [ ] Test `/api/auth/register` endpoint
- [ ] Test `/api/auth/login` endpoint
- [ ] Test `/api/profile` endpoint
- [ ] Verify all requests include Authorization header

---

## Phase 6: Production Deployment

### Deploy to Production
- [ ] Run: `vercel --prod`
- [ ] Or use Vercel dashboard: Deployments → Promote to Production
- [ ] Note production URL

### Final Checks
- [ ] Test production URL
- [ ] Verify HTTPS is working
- [ ] Check all features work in production
- [ ] Test on different browsers
- [ ] Test on mobile devices

---

## Troubleshooting

### CORS Issues
**Symptoms**: Console shows "CORS policy blocked"

**Fix**:
1. Update backend CORS in `SecurityConfig.java`
2. Add your Vercel URL to allowed origins
3. Redeploy backend
4. Wait 2-3 minutes for changes

### Backend Connection Failed
**Symptoms**: "Cannot connect to backend" error

**Fix**:
1. Verify backend URL in `vercel.json` is correct
2. Visit backend URL directly to ensure it's running
3. Check environment variables in Vercel
4. Verify backend logs (no errors)

### Build Failures
**Symptoms**: Vercel build fails

**Fix**:
1. Check `frontend/package.json` exists
2. Verify build command: `cd frontend && npm install && npm run build`
3. Check output directory: `frontend/dist`
4. Review build logs for specific errors

### JWT Token Not Working
**Symptoms**: Can't access protected routes

**Fix**:
1. Check token is stored in localStorage
2. Verify token format: `Bearer <token>`
3. Check backend JWT secret matches
4. Inspect token at jwt.io (should be valid)

---

## Post-Deployment Monitoring

### Regular Checks
- [ ] Monitor backend uptime (Render/Railway dashboard)
- [ ] Check Vercel analytics
- [ ] Review error logs
- [ ] Test critical paths weekly

### Performance
- [ ] Check initial load time
- [ ] Monitor API response times
- [ ] Optimize bundle size if needed

---

## URLs Summary

After successful deployment, you should have:

1. **Frontend (Vercel)**: `https://your-app.vercel.app`
2. **Backend (Render/Railway)**: `https://your-app.onrender.com` or `https://your-app.railway.app`
3. **API via Proxy**: `https://your-app.vercel.app/api/*`

---

## Cost Tracking

### Free Tier Limits
- **Vercel**: Unlimited deployments, 100GB bandwidth/month
- **Render**: 750 hours/month free (spins down after 15min inactivity)
- **Railway**: $5 credit/month, then pay-as-you-go

### Upgrade Considerations
- Need custom domain? (Vercel Pro: $20/month)
- Need always-on backend? (Render Starter: $7/month)
- High traffic? Monitor usage limits

---

## Security Best Practices

- [ ] Never commit secrets to Git
- [ ] Use environment variables for sensitive data
- [ ] Enable HTTPS everywhere (automatic on Vercel/Render)
- [ ] Set strong JWT secret (min 32 chars)
- [ ] Regular dependency updates
- [ ] Monitor for suspicious activity

---

## Support Resources

- **Vercel Docs**: https://vercel.com/docs
- **Vercel Discord**: https://vercel.com/discord
- **Render Support**: https://render.com/docs
- **Spring Boot Docs**: https://spring.io/projects/spring-boot
- **Project Issues**: Your GitHub repository issues

---

## Quick Commands Reference

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy (preview)
vercel

# Deploy (production)
vercel --prod

# List deployments
vercel ls

# Pull env variables
vercel env pull

# View logs
vercel logs
```

---

## Success Criteria

Your deployment is successful when:
- ✅ Frontend loads without errors
- ✅ Can register new users
- ✅ Can login successfully
- ✅ Can access profile page
- ✅ JWT token stored correctly
- ✅ No CORS errors in console
- ✅ Logout works properly
- ✅ All pages responsive on mobile

---

**Last Updated**: 2026-03-20
**Version**: 1.0

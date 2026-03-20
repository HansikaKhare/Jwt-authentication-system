# Deploy JWT Authentication System to Render

## 🎯 Complete Step-by-Step Guide

Your project is now configured for deployment on Render! Follow these steps:

---

## Part 1: Prepare Your Code

### 1. Commit and Push Changes

```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task"

# Add all the new deployment files
git add .

# Commit
git commit -m "Add Render deployment configuration

- Added render.yaml for infrastructure setup
- Added PostgreSQL support for production database
- Created production profile configuration
- Updated frontend API configuration for production
- Ready for deployment on Render.com"

# Push to GitHub
git push origin main
```

---

## Part 2: Deploy Backend to Render

### Step 1: Create Render Account

1. Go to **https://render.com**
2. Click **"Get Started for Free"**
3. Sign up with your GitHub account (recommended) or email

### Step 2: Create New Web Service

1. Click **"New +"** → **"Web Service"**
2. Choose **"Connect a repository"**
3. Select your repository: **`Jwt-authentication-system`**
4. Configure the service:

```
Name: jwt-auth-backend
Region: Oregon (closest to you)
Branch: main
Root Directory: backend
Runtime: Java
Build Command: ./mvnw clean package -DskipTests
Start Command: java -jar target/jwt-auth-system-1.0.0.jar
```

5. Choose **Free Plan**

### Step 3: Set Environment Variables

Click **"Advanced"** and add these environment variables:

```
SPRING_PROFILES_ACTIVE=production
JWT_SECRET=YourSuperSecretKeyHere_MakeItLongAndRandom_2024!
PORT=10000
JAVA_VERSION=24
```

### Step 4: Create Database

Render will auto-create a PostgreSQL database. Wait for it to provision.

### Step 5: Deploy

Click **"Create Web Service"**

Wait 5-10 minutes for build and deployment.

Copy your backend URL: `https://jwt-auth-backend-xxxx.onrender.com`

---

## Part 3: Deploy Frontend to Render

### Step 1: Create Static Site

1. Click **"New +"** → **"Static Site"**
2. Connect the same repository: **`Jwt-authentication-system`**
3. Configure:

```
Name: jwt-auth-frontend
Region: Oregon (same as backend)
Branch: main
Root Directory: frontend
Build Command: echo "Deploying static frontend..."
Publish Directory: .
```

4. Choose **Free Plan**

### Step 2: Set Environment Variable

Add this environment variable:

```
API_BASE_URL: https://jwt-auth-backend-xxxx.onrender.com/api
(Replace xxxx with your actual backend URL)
```

### Step 3: Deploy

Click **"Create Static Site"**

Wait 2-3 minutes.

Copy your frontend URL: `https://jwt-auth-frontend-xxxx.onrender.com`

---

## Part 4: Update CORS Configuration

Edit your backend security config to allow your frontend domain:

### Edit `backend/src/main/java/com/auth/jwt/security/SecurityConfig.java`

Find the `corsConfigurationSource()` method and update:

```java
private CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration configuration = new CorsConfiguration();
    
    // Add your Render frontend URL
    configuration.setAllowedOrigins(List.of(
        "https://jwt-auth-frontend-xxxx.onrender.com",  // Your frontend URL
        "*"  // Or allow all for development
    ));
    
    configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
    configuration.setAllowedHeaders(List.of("*"));
    configuration.setAllowCredentials(true);
    configuration.setMaxAge(3600L);
    
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**", configuration);
    return source;
}
```

Then commit and push:

```bash
git add .
git commit -m "Update CORS for Render deployment"
git push origin main
```

---

## Part 5: Test Your Deployment

### 1. Test Backend

Open in browser or use curl:

```bash
# Test health
curl https://jwt-auth-backend-xxxx.onrender.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"usernameOrEmail":"test","password":"test"}'
```

### 2. Test Frontend

Visit your frontend URL: `https://jwt-auth-frontend-xxxx.onrender.com`

Try:
- Register a new user
- Login
- View profile

---

## 📊 Deployment Summary

| Component | URL | Status |
|-----------|-----|--------|
| Backend | https://jwt-auth-backend-xxxx.onrender.com | ✅ Running |
| Frontend | https://jwt-auth-frontend-xxxx.onrender.com | ✅ Running |
| Database | Auto-provisioned PostgreSQL | ✅ Ready |

---

## 🔧 Environment Variables

### Backend (Web Service):
```
SPRING_PROFILES_ACTIVE=production
JWT_SECRET=YourSecretKeyHere
PORT=10000
JAVA_VERSION=24
DATABASE_URL=(auto-provided by Render)
DATABASE_USERNAME=(auto-provided by Render)
DATABASE_PASSWORD=(auto-provided by Render)
```

### Frontend (Static Site):
```
API_BASE_URL=https://your-backend-url.onrender.com/api
```

---

## 💰 Cost Breakdown

**Render Free Tier:**
- ✅ 1 Web Service (Backend) - FREE
- ✅ 1 Static Site (Frontend) - FREE  
- ✅ 1 PostgreSQL Database - FREE (with limitations)
- **Total: $0/month** 🎉

*Note: Free tier services spin down after 15 minutes of inactivity. First request after spin-down takes ~30 seconds to wake up.*

---

## 🚨 Troubleshooting

### Backend Won't Start

**Check logs in Render dashboard:**
1. Go to your backend service
2. Click **"Logs"** tab
3. Look for errors

**Common issues:**
- ❌ Java version mismatch → Ensure JAVA_VERSION=24
- ❌ Build fails → Check Maven wrapper permissions
- ❌ Database connection fails → Verify DATABASE_URL env var

### Frontend Can't Connect

**Solutions:**
1. ✅ Check API_BASE_URL environment variable
2. ✅ Verify CORS allows frontend domain
3. ✅ Test backend directly (use curl or Postman)
4. ✅ Check browser console for errors

### Database Errors

**Fix:**
1. ✅ Ensure PostgreSQL dependency is in pom.xml
2. ✅ Check spring.datasource.driverClassName is correct
3. ✅ Verify Render auto-created the database

---

## 🔄 Updating Your Deployment

After initial setup, updates are automatic:

```bash
# Make changes locally
# Then:
git add .
git commit -m "Your changes here"
git push origin main
```

Render will automatically:
1. Detect the push to main branch
2. Rebuild your application
3. Deploy the new version
4. Zero downtime!

---

## 📈 Monitoring

### Check Logs
- Backend: Render Dashboard → jwt-auth-backend → Logs
- Frontend: Render Dashboard → jwt-auth-frontend → Logs

### Metrics
- CPU usage
- Memory usage
- Request count
- Response times

---

## 🎨 Custom Domain (Optional)

### For Frontend:
1. Buy domain (Namecheap, GoDaddy, etc.)
2. In Render: Settings → Custom Domain
3. Add your domain
4. Update DNS records as instructed
5. Free SSL certificate provided!

### For Backend:
Same process for backend service if needed.

---

## ⚡ Performance Tips

1. **Enable Auto-Deploy:** Keep free tier services awake
2. **Use CDN:** Add Cloudflare for caching
3. **Optimize Images:** Compress any images in frontend
4. **Database Indexes:** Add indexes on frequently queried fields

---

## 🎉 Success Checklist

- ✅ Backend deployed and accessible
- ✅ Frontend deployed and accessible
- ✅ User registration works
- ✅ User login works
- ✅ Profile page loads with data
- ✅ JWT tokens are generated and validated
- ✅ Database persists data
- ✅ No errors in logs
- ✅ HTTPS enabled (automatic on Render)

---

## 🆘 Need Help?

**Render Documentation:**
- Web Services: https://docs.render.com/web-services
- Static Sites: https://docs.render.com/static-sites
- Databases: https://docs.render.com/databases

**Still stuck?**
- Check Render community forum
- Review application logs
- Test backend API directly with Postman

---

## 🌟 Next Steps

Once deployed:

1. ✅ Share your live URL
2. ✅ Add to resume/portfolio
3. ✅ Monitor usage in Render dashboard
4. ✅ Consider upgrading plan if needed
5. ✅ Set up custom domain
6. ✅ Enable automatic backups for database

---

**Your JWT Authentication System will be live on Render in under 15 minutes!** 🚀

Ready to deploy? Start with Part 1 (push your code), then follow each step!

# 🎨 Vercel Deployment - Visual Flow Chart

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    USERS ACCESS YOUR APP                     │
│                   https://your-app.vercel.app                │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
         ┌───────────────────────────────────┐
         │          VERCEL (Frontend)         │
         │  - Static Hosting (HTML/CSS/JS)    │
         │  - Automatic HTTPS                 │
         │  - Global CDN                      │
         │  - Automatic Builds on Git Push    │
         └───────────────────────────────────┘
                         │
                         │ API Calls (/api/*)
                         │ (proxied automatically)
                         ▼
         ┌───────────────────────────────────┐
         │      Render/Railway (Backend)      │
         │  - Spring Boot Application         │
         │  - REST API Endpoints              │
         │  - JWT Authentication              │
         │  - Database (H2/PostgreSQL)        │
         └───────────────────────────────────┘
```

---

## Deployment Flow

### Phase 1: Backend Deployment
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Push to    │────▶│ Deploy to    │────▶│ Get Backend  │
│   GitHub     │     │ Render       │     │ URL          │
└──────────────┘     └──────────────┘     └──────────────┘
                                                    │
                                                    ▼
                                         https://myapp.onrender.com
```

### Phase 2: Configuration
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  Update      │────▶│  Commit &    │────▶│  Configure   │
│  vercel.json │     │   Push       │     │  CORS        │
└──────────────┘     └──────────────┘     └──────────────┘
```

### Phase 3: Frontend Deployment
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  Run Vercel  │────▶│  Set Env     │────▶│   Deploy!    │
│  CLI         │     │  Variables   │     │              │
└──────────────┘     └──────────────┘     └──────────────┘
                            │
                            ▼
                  https://myapp.vercel.app
```

---

## Request Flow (How Data Moves)

```
User Browser
     │
     │ 1. User visits: https://your-app.vercel.app
     ▼
┌─────────────────────────┐
│   Vercel Servers        │
│   - Serve HTML/CSS/JS   │
│   - Load frontend app   │
└─────────────────────────┘
     │
     │ 2. User clicks "Login"
     │    Frontend makes API call
     ▼
┌─────────────────────────┐
│   Vercel Proxy          │
│   /api/auth/login       │
│   (rewrites to backend) │
└─────────────────────────┘
     │
     │ 3. Proxied request
     ▼
┌─────────────────────────┐
│   Backend (Render)      │
│   Spring Boot API       │
│   - Validate credentials│
│   - Generate JWT token  │
└─────────────────────────┘
     │
     │ 4. Response with JWT token
     ▼
┌─────────────────────────┐
│   Vercel                │
│   (passes through)      │
└─────────────────────────┘
     │
     │ 5. Token stored in localStorage
     ▼
User Browser
     │
     │ 6. Future requests include:
     │    Authorization: Bearer <token>
     └──────────────────────────► Backend (for protected routes)
```

---

## File Structure for Deployment

```
your-project/
│
├── vercel.json                    ← Vercel configuration
├── render.yaml                    ← Render configuration
├── deploy-vercel.bat              ← Quick deploy script
│
├── frontend/                      ← Deployed to Vercel
│   ├── index.html
│   ├── login.html
│   ├── register.html
│   ├── profile.html
│   ├── config.js                  ← API URL configuration
│   ├── js/
│   │   ├── auth.js
│   │   ├── login.js
│   │   └── register.js
│   ├── css/
│   │   └── style.css
│   ├── package.json
│   └── vite.config.js
│
└── backend/                       ← Deployed to Render/Railway
    ├── pom.xml
    └── src/main/java/com/auth/jwt/
        ├── security/
        │   └── SecurityConfig.java  ← CORS configured here
        ├── controller/
        ├── service/
        ├── repository/
        └── entity/
```

---

## Environment Variables Map

### Frontend (Vercel)
```
┌───────────────────────┬──────────────────────────────────┐
│ Variable Name         │ Value                            │
├───────────────────────┼──────────────────────────────────┤
│ VITE_API_BASE_URL     │ https://backend-url.onrender.com │
└───────────────────────┴──────────────────────────────────┘
```

### Backend (Render/Railway)
```
┌───────────────────────┬──────────────────────────────────┐
│ Variable Name         │ Value                            │
├───────────────────────┼──────────────────────────────────┤
│ JWT_SECRET            │ YourSecretKey2024!               │
│ cors.allowed.origins  │ https://your-app.vercel.app      │
└───────────────────────┴──────────────────────────────────┘
```

---

## Step-by-Step Checklist

```
┌─────────────────────────────────────────────────────────┐
│ PHASE 1: DEPLOY BACKEND                                 │
├─────────────────────────────────────────────────────────┤
│ ☐ 1. Push code to GitHub                                │
│ ☐ 2. Create Render account                              │
│ ☐ 3. Deploy using render.yaml                           │
│ ☐ 4. Copy backend URL                                   │
│ ☐ 5. Set JWT_SECRET env variable                        │
│ ☐ 6. Test backend endpoint                              │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│ PHASE 2: UPDATE CONFIG                                  │
├─────────────────────────────────────────────────────────┤
│ ☐ 1. Update vercel.json with backend URL                │
│ ☐ 2. Commit changes                                     │
│ ☐ 3. Push to GitHub                                     │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│ PHASE 3: DEPLOY FRONTEND                                │
├─────────────────────────────────────────────────────────┤
│ ☐ 1. Install Vercel CLI                                 │
│ ☐ 2. Login to Vercel                                    │
│ ☐ 3. Run: vercel                                        │
│ ☐ 4. Follow prompts                                     │
│ ☐ 5. Note preview URL                                   │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│ PHASE 4: CONFIGURE CORS                                 │
├─────────────────────────────────────────────────────────┤
│ ☐ 1. Add Vercel URL to cors.allowed.origins             │
│ ☐ 2. Redeploy backend                                   │
│ ☐ 3. Wait 2-3 minutes                                   │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│ PHASE 5: TEST                                           │
├─────────────────────────────────────────────────────────┤
│ ☐ 1. Visit Vercel URL                                   │
│ ☐ 2. Open DevTools (F12)                                │
│ ☐ 3. Test registration                                  │
│ ☐ 4. Test login                                         │
│ ☐ 5. Verify JWT token                                   │
│ ☐ 6. Test logout                                        │
│ ☐ 7. Check for console errors                           │
└─────────────────────────────────────────────────────────┘
```

---

## Common Error Patterns

### ✅ Success Pattern
```
Browser Console:
✅ Backend is responding correctly
✅ Login successful
✅ Token stored

Network Tab:
POST https://your-app.vercel.app/api/auth/login
Status: 200 OK
Response: { token: "eyJhbGc...", ... }
```

### ❌ CORS Error Pattern
```
Browser Console:
❌ Access to fetch at 'https://backend.onrender.com/api/auth/login' 
   from origin 'https://your-app.vercel.app' has been blocked by CORS policy

Solution: Update backend CORS configuration
```

### ❌ Connection Error Pattern
```
Browser Console:
❌ Cannot connect to backend server at https://backend.onrender.com
❌ Failed to fetch

Solution: Check backend URL and ensure backend is running
```

---

## Deployment Timeline

```
┌──────────────────────────────────────────────────────────┐
│ TOTAL TIME: ~15-20 minutes                               │
├──────────────────────────────────────────────────────────┤
│                                                          │
│ Backend Setup (Render):     5-7 minutes                  │
│   - Account creation:       2 min                        │
│   - Deployment:             3-5 min                      │
│                                                          │
│ Configuration Updates:      2-3 minutes                  │
│   - Update vercel.json:     1 min                        │
│   - Commit & push:          1 min                        │
│   - Configure CORS:         1 min                        │
│                                                          │
│ Frontend Deployment:        3-5 minutes                  │
│   - Vercel CLI setup:       1 min                        │
│   - Deployment build:       2-3 min                      │
│   - Environment setup:      1 min                        │
│                                                          │
│ Testing:                    5 minutes                    │
│   - Registration test:      1 min                        │
│   - Login test:             1 min                        │
│   - Profile test:           1 min                        │
│   - Debug (if needed):      2 min                        │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

## Before & After Comparison

### Before Deployment (Local Development)
```
┌──────────────┐     ┌──────────────┐
│   Browser    │────▶│  Localhost   │
│ localhost:   │     │  Spring Boot │
│   5173       │     │    :8080     │
└──────────────┘     └──────────────┘

Access: http://localhost:5173
Only you can access it
```

### After Deployment (Production)
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Browser    │────▶│    Vercel    │────▶│    Render    │
│   Anywhere   │     │   (Global)   │     │   (Cloud)    │
└──────────────┘     └──────────────┘     └──────────────┘

Access: https://your-app.vercel.app
Anyone with internet can access
```

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────┐
│  DEPLOYMENT COMMANDS                                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  # Install Vercel CLI                                   │
│  npm install -g vercel                                  │
│                                                         │
│  # Login                                                │
│  vercel login                                           │
│                                                         │
│  # Deploy (preview)                                     │
│  vercel                                                 │
│                                                         │
│  # Deploy (production)                                  │
│  vercel --prod                                          │
│                                                         │
│  # View deployments                                     │
│  vercel ls                                              │
│                                                         │
│  # Pull environment variables                           │
│  vercel env pull                                        │
│                                                         │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  IMPORTANT URLs                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Frontend:    https://your-app.vercel.app               │
│  Backend:     https://your-app.onrender.com             │
│  API Proxy:   https://your-app.vercel.app/api/*         │
│  H2 Console:  https://your-app.onrender.com/h2-console  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

**Ready to deploy? Start with Phase 1!** 🚀

*Visual Guide v1.0 | Last Updated: March 20, 2026*

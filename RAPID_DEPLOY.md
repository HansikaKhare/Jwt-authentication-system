# One-Click Deploy to Render

## Backend Setup
1. Visit: https://render.com/deploy?repo=https://github.com/YOUR_USERNAME/Jwt-authentication-system
2. Select "Web Service"
3. Use settings from render.yaml

## Manual Steps

### Backend (Web Service)
- Root: backend
- Build: ./mvnw clean package -DskipTests
- Start: java -jar target/*.jar
- Env vars:
  - JWT_SECRET=YourSecret2024
  - SPRING_PROFILES_ACTIVE=production
  - PORT=10000

### Frontend (Static Site)
- Root: frontend
- Publish: frontend
- Env var:
  - API_BASE_URL=https://your-backend.onrender.com/api

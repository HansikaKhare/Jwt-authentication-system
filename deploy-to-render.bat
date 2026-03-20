@echo off
color 0A
title Deploy JWT Auth System to Render

echo ================================================
echo   DEPLOY TO RENDER.COM - QUICK START
echo ================================================
echo.
echo Your code is ready for deployment!
echo.
echo STEP 1: Open Render.com
echo -----------------------------------------------
echo.
start https://render.com
echo.
echo ^>^>^> Render.com opened in your browser!
echo.
echo.
echo STEP 2: Sign Up / Login
echo -----------------------------------------------
echo 1. Click "Get Started for Free"
echo 2. Choose "Sign up with GitHub" (recommended)
echo 3. Authorize Render to access your GitHub
echo.
echo Press any key to continue...
pause > nul
echo.
echo.
echo STEP 3: Deploy Backend
echo -----------------------------------------------
echo 1. Click "New +" then "Web Service"
echo 2. Connect repository: HansikaKhare/Jwt-authentication-system
echo 3. Configure:
echo    - Name: jwt-auth-backend
echo    - Root Directory: backend
echo    - Build Command: ./mvnw clean package -DskipTests
echo    - Start Command: java -jar target/jwt-auth-system-1.0.0.jar
echo 4. Add environment variables:
echo    - SPRING_PROFILES_ACTIVE = production
echo    - JWT_SECRET = MySecretKey2024_VeryLongAndSecure_RandomString123!
echo    - PORT = 10000
echo    - JAVA_VERSION = 24
echo 5. Click "Create Web Service"
echo 6. Wait 3-5 minutes for deployment
echo.
echo Copy your backend URL when ready!
echo Example: https://jwt-auth-backend-xxxx.onrender.com
echo.
echo Press any key to continue...
pause > nul
echo.
echo.
echo STEP 4: Deploy Frontend
echo -----------------------------------------------
echo 1. Click "New +" then "Static Site"
echo 2. Connect same repository
echo 3. Configure:
echo    - Name: jwt-auth-frontend
echo    - Root Directory: frontend
echo    - Build Command: echo "Deploying..."
echo    - Publish Directory: .
echo 4. Add environment variable:
echo    - API_BASE_URL = [Your backend URL from Step 3]/api
echo 5. Click "Create Static Site"
echo 6. Wait 1-2 minutes
echo.
echo.
echo STEP 5: Test Your Application
echo -----------------------------------------------
echo.
start https://render.com
echo.
echo ^>^>^> Opened Render Dashboard
echo.
echo 1. Go to your frontend URL
echo 2. Register a test user
echo 3. Login
echo 4. View profile
echo.
echo.
echo ================================================
echo   DEPLOYMENT COMPLETE!
echo ================================================
echo.
echo Your app is now LIVE on the internet!
echo.
echo Frontend: https://jwt-auth-frontend-xxxx.onrender.com
echo Backend:  https://jwt-auth-backend-xxxx.onrender.com
echo.
echo Cost: FREE ($0/month)
echo.
echo ================================================
echo.
pause

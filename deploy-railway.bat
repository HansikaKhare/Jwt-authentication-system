@echo off
REM Railway Deployment Script
REM This script helps you deploy to Railway

echo ========================================
echo   JWT Auth System - Railway Deployment
echo ========================================
echo.

REM Check if Railway CLI is installed
where railway >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [!] Railway CLI not found
    echo.
    echo Installing Railway CLI...
    npm install -g @railway/cli
    echo.
)

echo Current directory: %CD%
echo.
echo Step 1: Building frontend...
echo.

cd frontend
call npm install
call npm run build
cd ..

echo.
echo Step 2: Logging into Railway...
echo.

railway login

echo.
echo Step 3: Initializing Railway project...
echo.

railway init

echo.
echo Step 4: Adding PostgreSQL database...
echo.

railway add postgresql

echo.
echo Step 5: Setting environment variables...
echo.

set /p JWT_SECRET="Enter JWT_SECRET (or press Enter for default): "
if "%JWT_SECRET%"=="" set JWT_SECRET=YourSuperSecretProductionKey2024!ChangeThis

railway variables set JWT_SECRET=%JWT_SECRET%
railway variables set SPRING_PROFILES_ACTIVE=production
railway variables set PORT=10000

echo.
echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Run: railway up
echo 2. Wait for deployment (~5-10 minutes)
echo 3. Get your URL from Railway dashboard
echo 4. Test your application!
echo.
echo For detailed instructions, see RAILWAY_DEPLOY_GUIDE.md
echo.
pause

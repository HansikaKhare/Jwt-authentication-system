@echo off
REM Quick Deploy Script for Vercel
REM This script helps you deploy the frontend to Vercel

echo ========================================
echo   JWT Auth System - Vercel Deployment
echo ========================================
echo.

REM Check if Vercel CLI is installed
where vercel >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [!] Vercel CLI not found
    echo.
    echo Installing Vercel CLI...
    npm install -g vercel
    echo.
)

echo Current directory: %CD%
echo.
echo Starting Vercel deployment...
echo.

REM Run Vercel deployment
vercel

echo.
echo ========================================
echo   Deployment Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Make sure your backend is deployed on Render/Railway
echo 2. Update vercel.json with your actual backend URL
echo 3. Set environment variables in Vercel dashboard
echo 4. Test your deployed application
echo.
pause

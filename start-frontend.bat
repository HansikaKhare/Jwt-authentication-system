@echo off
echo ========================================
echo JWT Authentication System - Frontend
echo ========================================
echo.

REM Navigate to frontend directory
cd /d "%~dp0frontend"

echo Starting Frontend...
echo.
echo Opening login page in your default browser...
echo.

REM Open login page in default browser
start login.html

echo.
echo Frontend is ready!
echo Login page: %CD%\login.html
echo.
echo Make sure the backend server is running on port 8080
echo.

pause

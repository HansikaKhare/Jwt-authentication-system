@echo off
echo ========================================
echo Opening JWT Authentication Frontend
echo ========================================
echo.
echo This will open the login page in your default browser.
echo.
echo IMPORTANT: Make sure the backend is running on port 8080
echo before trying to login or register!
echo.
pause
cd /d "%~dp0frontend"
start login.html
echo.
echo Login page opened!
echo File location: %CD%\login.html
echo.
echo If the page doesn't load correctly, try:
echo 1. Right-click the file → Open with → Your browser
echo 2. Or drag the file into your browser window
echo.
pause

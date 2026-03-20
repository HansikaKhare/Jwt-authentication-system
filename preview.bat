@echo off
echo ========================================
echo JWT Authentication System - Full Preview
echo ========================================
echo.
echo Backend Status: Already Running on port 8080
echo.
echo Opening frontend pages...
echo.

cd /d "%~dp0frontend"

REM Open the preview dashboard
start index.html

echo ✅ Preview Dashboard opened in your browser!
echo.
echo From there you can:
echo   - Click to navigate to Login/Register/Profile pages
echo   - View API endpoints
echo   - Access database console
echo.
echo Backend Server: http://localhost:8080
echo H2 Console: http://localhost:8080/h2-console
echo.
echo Press any key to see test credentials...
pause >nul
echo.
echo Test Credentials:
echo   Username: testuser
echo   Email: test@example.com
echo   Password: password123
echo.
echo Or register your own account through the UI!
echo.
pause

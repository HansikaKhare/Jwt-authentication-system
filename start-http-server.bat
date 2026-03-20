@echo off
echo ========================================
echo Starting Simple HTTP Server for Frontend
echo ========================================
echo.
echo Frontend will be available at: http://localhost:8081
echo.
echo Press Ctrl+C to stop the server
echo.

REM Use Python's built-in HTTP server if available
where python >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo Starting Python HTTP server...
    cd /d "%~dp0frontend"
    python -m http.server 8081
) else (
    echo Python not found. Opening files directly instead...
    echo.
    echo TIP: Install Python or use a browser extension like "Web Server for Chrome"
    echo OR simply open the files by double-clicking them.
    echo.
    start index.html
)

pause

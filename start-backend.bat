@echo off
echo ========================================
echo JWT Authentication System - Startup Script
echo ========================================
echo.

REM Check if Java is installed
where java >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install Java 17 or higher
    pause
    exit /b 1
)

echo Java version:
java -version
echo.

REM Navigate to backend directory
cd /d "%~dp0backend"

echo Starting Spring Boot Backend...
echo Server will start on http://localhost:8080
echo.
echo API Endpoints:
echo - Register: POST http://localhost:8080/api/auth/register
echo - Login: POST http://localhost:8080/api/auth/login
echo - Profile: GET http://localhost:8080/api/profile ^(protected^)
echo.
echo H2 Console: http://localhost:8080/h2-console
echo JDBC URL: jdbc:h2:mem:authdb
echo Username: sa
echo Password: password
echo.
echo Press Ctrl+C to stop the server
echo.

REM Start Spring Boot application
call mvn spring-boot:run

pause

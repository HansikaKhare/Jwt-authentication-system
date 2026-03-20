@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Finding and Using Maven...
echo ========================================
echo.

REM Search for Maven in common locations
set MAVEN_FOUND=

REM Check common locations
for %%p in (
    "C:\Program Files\Apache\maven\bin",
    "C:\apache-maven\bin",
    "%USERPROFILE%\apache-maven\bin",
    "D:\apache-maven\bin",
    "%LOCALAPPDATA%\apache-maven\bin"
) do (
    if exist "%%p\mvn.cmd" (
        echo Found Maven at: %%p
        set MAVEN_HOME=%%p
        set MAVEN_FOUND=yes
        goto :found
    )
)

REM If not found, try to locate it in PATH
where mvn >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo Maven found in PATH
    set MAVEN_HOME=
    set MAVEN_FOUND=yes
    goto :found
)

:notfound
echo.
echo ERROR: Maven not found!
echo.
echo Please either:
echo 1. Extract Maven to a folder (e.g., C:\Program Files\Apache\maven)
echo 2. Add Maven's bin folder to your PATH
echo.
echo See MAVEN_SETUP.md for detailed instructions.
echo.
pause
exit /b 1

:found
echo.
echo Starting Spring Boot Backend...
echo.
echo Server will start on: http://localhost:8080
echo API Endpoints:
echo   - POST /api/auth/register
echo   - POST /api/auth/login
echo   - GET  /api/profile
echo.
echo H2 Console: http://localhost:8080/h2-console
echo.
echo Press Ctrl+C to stop the server
echo.
echo First startup may take 5-10 minutes to download dependencies...
echo.

cd /d "%~dp0backend"

if defined MAVEN_HOME (
    echo Using Maven from: %MAVEN_HOME%
    call "%MAVEN_HOME%\mvn.cmd" spring-boot:run
) else (
    echo Using Maven from PATH
    call mvn spring-boot:run
)

pause

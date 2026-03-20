@echo off
echo ========================================
echo Extracting Apache Maven...
echo ========================================
echo.

set DOWNLOAD=%USERPROFILE%\Downloads\apache-maven-3.9.12-bin.zip
set EXTRACT_TO=%USERPROFILE%\apache-maven

echo Download found: %DOWNLOAD%
echo Will extract to: %EXTRACT_TO%
echo.

REM Check if file exists
if not exist "%DOWNLOAD%" (
    echo ERROR: Download file not found!
    pause
    exit /b 1
)

REM Create extraction directory
if not exist "%EXTRACT_TO%" (
    mkdir "%EXTRACT_TO%"
    echo Created directory: %EXTRACT_TO%
)

REM Extract using PowerShell
echo Extracting files...
powershell -Command "Expand-Archive -Path '%DOWNLOAD%' -DestinationPath '%EXTRACT_TO%' -Force"

echo.
echo Extraction complete!
echo.
echo Maven location: %EXTRACT_TO%\apache-maven-3.9.12
echo.

REM Add to user PATH
echo Adding Maven to your PATH...
setx PATH "%PATH%;%EXTRACT_TO%\apache-maven-3.9.12\bin"
echo.

echo ========================================
echo SUCCESS! Maven is now installed!
echo ========================================
echo.
echo IMPORTANT: Please close this window and open a NEW terminal
echo for the PATH changes to take effect.
echo.
echo Then run:
echo   cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\backend"
echo   mvn spring-boot:run
echo.
pause

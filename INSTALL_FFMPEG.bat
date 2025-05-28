@echo off
echo ========================================
echo Installing FFmpeg for MarkItDown
echo ========================================
echo.

echo This will download and install FFmpeg binaries for complete audio support.
echo FFmpeg enables advanced audio format conversion and transcription.
echo.
choice /C YN /M "Do you want to install FFmpeg"
if errorlevel 2 goto :skip

echo.
echo [1/4] Creating FFmpeg directory...
if not exist "ffmpeg" mkdir ffmpeg
cd ffmpeg

echo.
echo [2/4] Downloading FFmpeg...
echo This may take a few minutes depending on your internet connection...

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip' -OutFile 'ffmpeg.zip'}"

if not exist "ffmpeg.zip" (
    echo ERROR: Failed to download FFmpeg
    echo You can manually download from: https://ffmpeg.org/download.html
    pause
    exit /b 1
)

echo.
echo [3/4] Extracting FFmpeg...
powershell -Command "Expand-Archive -Path 'ffmpeg.zip' -DestinationPath '.' -Force"

echo.
echo [4/4] Setting up FFmpeg binaries...
for /d %%i in (ffmpeg-*) do (
    copy "%%i\bin\ffmpeg.exe" . >nul
    copy "%%i\bin\ffprobe.exe" . >nul
    rmdir /s /q "%%i"
)

del ffmpeg.zip

if exist "ffmpeg.exe" (
    echo.
    echo ========================================
    echo FFmpeg Installation SUCCESSFUL!
    echo ========================================
    echo Location: %CD%
    echo Files: ffmpeg.exe, ffprobe.exe
    echo.
    echo FFmpeg will be automatically included in your MarkItDown build.
    echo You now have COMPLETE audio format support!
    echo.
) else (
    echo.
    echo ========================================
    echo FFmpeg Installation FAILED!
    echo ========================================
    echo Please try manual installation:
    echo 1. Download from: https://ffmpeg.org/download.html
    echo 2. Extract ffmpeg.exe and ffprobe.exe
    echo 3. Place them in the 'ffmpeg' folder
    echo.
)

cd ..
goto :end

:skip
echo.
echo Skipping FFmpeg installation.
echo Note: Audio conversion will have limited functionality.
echo.

:end
pause
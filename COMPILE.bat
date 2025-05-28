@echo off
echo ========================================
echo MarkItDown PyInstaller Compilation
echo Creating Single Executable File
echo ========================================
echo.

echo [1/5] Checking if MarkItDown is installed...
python -c "import markitdown; print('MarkItDown found:', markitdown.__file__)" 2>nul
if errorlevel 1 (
    echo ERROR: MarkItDown is not installed!
    echo Please run INSTALL_DEPENDENCIES.bat first
    pause
    exit /b 1
)

echo.
echo [2/5] Cleaning previous builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
echo Build directories cleaned.

echo.
echo [3/5] Starting PyInstaller compilation...
echo This will create a single executable file with ALL converters included
echo Compilation may take 5-15 minutes depending on your system...
echo.

echo Using spec file for compilation...
python -m PyInstaller markitdown.spec

if errorlevel 1 (
    echo.
    echo ========================================
    echo COMPILATION FAILED!
    echo ========================================
    echo Check the error messages above.
    echo Common issues:
    echo - Missing dependencies: Run INSTALL_DEPENDENCIES.bat
    echo - Insufficient disk space
    echo - Antivirus interference
    pause
    exit /b 1
)

echo.
echo [4/5] Testing the compiled executable...
if exist "dist\markitdown.exe" (
    echo Testing version command...
    "dist\markitdown.exe" --version
    if errorlevel 1 (
        echo WARNING: Executable test failed
    ) else (
        echo SUCCESS: Executable test passed!
    )
) else (
    echo ERROR: markitdown.exe was not created!
    pause
    exit /b 1
)

echo.
echo [5/5] Build summary...
if exist "dist\markitdown.exe" (
    for %%I in ("dist\markitdown.exe") do set size=%%~zI
    set /a sizeMB=!size!/1024/1024
    echo.
    echo ========================================
    echo COMPILATION SUCCESSFUL!
    echo ========================================
    echo Executable: dist\markitdown.exe
    echo Size: !sizeMB! MB
    echo.
    echo The executable includes support for ALL file formats:
    echo - PDF, Word, Excel, PowerPoint
    echo - Images with EXIF metadata
    echo - Audio with transcription
    echo - HTML, CSV, JSON, XML
    echo - Jupyter notebooks
    echo - ZIP archives
    echo - And much more!
    echo.
    echo Usage examples:
    echo   dist\markitdown.exe document.pdf ^> output.md
    echo   dist\markitdown.exe --help
    echo   dist\markitdown.exe --version
    echo.
) else (
    echo COMPILATION FAILED - executable not found
)

echo ========================================
pause
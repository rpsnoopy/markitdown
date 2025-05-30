@echo off
echo ========================================
echo MarkItDown Enhanced - Fast Compilation
echo Building ONLY Enhanced Version
echo ========================================
echo.

echo [1/4] Checking if MarkItDown is installed...
python -c "import markitdown; print('MarkItDown found:', markitdown.__file__)" 2>nul
if errorlevel 1 (
    echo ERROR: MarkItDown is not installed!
    echo Please run INSTALL_DEPENDENCIES.bat first
    pause
    exit /b 1
)

echo.
echo [2/4] Cleaning previous enhanced build...
if exist dist\markitdown_enhanced.exe del /q dist\markitdown_enhanced.exe
if exist build\markitdown_enhanced rmdir /s /q build\markitdown_enhanced
echo Enhanced build directory cleaned.

echo.
echo [3/4] Building Enhanced version with structured output...
echo This creates a single executable with ALL Office + PDF support
echo Compilation time: ~3-5 minutes (faster than full build)
echo.

echo Using enhanced spec file for compilation...
python -m PyInstaller markitdown_enhanced.spec

if errorlevel 1 (
    echo.
    echo ========================================
    echo ENHANCED COMPILATION FAILED!
    echo ========================================
    echo Check the error messages above.
    echo Common issues:
    echo - Missing dependencies: Run INSTALL_OFFICE_DEPENDENCIES.bat
    echo - Corrupted PyInstaller: Run REMOVE_CORRUPTED_DIST_INFO.bat
    echo - Insufficient disk space
    echo - Antivirus interference
    pause
    exit /b 1
)

echo.
echo [4/4] Testing the enhanced executable...
if exist "dist\markitdown_enhanced.exe" (
    echo Testing enhanced version with help command...
    "dist\markitdown_enhanced.exe" --help
    if errorlevel 1 (
        echo WARNING: Enhanced executable test failed
    ) else (
        echo SUCCESS: Enhanced executable test passed!
    )
) else (
    echo ERROR: markitdown_enhanced.exe was not created!
    pause
    exit /b 1
)

echo.
echo ========================================
echo ENHANCED COMPILATION SUCCESSFUL!
echo ========================================

if exist "dist\markitdown_enhanced.exe" (
    for %%I in ("dist\markitdown_enhanced.exe") do set size=%%~zI
    set /a sizeMB=!size!/1024/1024
    echo.
    echo Executable: dist\markitdown_enhanced.exe
    echo Size: !sizeMB! MB
    echo.
    echo Enhanced features included:
    echo - ✅ DOCX, PPTX, XLSX (Office documents)
    echo - ✅ PDF with image extraction (PyMuPDF)
    echo - ✅ Structured JSON output
    echo - ✅ Image analysis and metadata
    echo - ✅ Page images extraction
    echo - ✅ HTML, CSV, JSON, XML support
    echo - ✅ All MarkItDown converters
    echo.
    echo Quick test commands:
    echo   dist\markitdown_enhanced.exe test_files\test.pdf --json-output
    echo   dist\markitdown_enhanced.exe test_files\test.docx --json-output
    echo   dist\markitdown_enhanced.exe --help
    echo.
    echo Ready for testing with TEST_SUITE.bat!
    echo.
) else (
    echo COMPILATION FAILED - enhanced executable not found
)

echo ========================================
pause
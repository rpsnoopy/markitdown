@echo off
echo ========================================
echo MarkItDown Image Extractor
echo Extract page images for OpenAI attachment
echo ========================================
echo.

if "%~1"=="" (
    echo Usage: EXTRACT_IMAGES.bat ^<document_file^> [output_directory] [max_size] [dpi]
    echo.
    echo Examples:
    echo   EXTRACT_IMAGES.bat document.pdf
    echo   EXTRACT_IMAGES.bat presentation.pptx slides 1500
    echo   EXTRACT_IMAGES.bat spreadsheet.xlsx sheets 2000 300
    echo.
    echo Supported formats:
    echo   - PDF: Full page extraction
    echo   - PPTX: Slide images 
    echo   - DOCX: Page content
    echo   - XLSX/XLS: Worksheet images
    echo   - Images: Resize and optimize
    echo.
    pause
    exit /b 1
)

set INPUT_FILE=%~1
set OUTPUT_DIR=%~2
set MAX_SIZE=%~3
set DPI=%~4

if "%OUTPUT_DIR%"=="" set OUTPUT_DIR=extracted_images
if "%MAX_SIZE%"=="" set MAX_SIZE=2000
if "%DPI%"=="" set DPI=200

echo Input file: %INPUT_FILE%
echo Output directory: %OUTPUT_DIR%
echo Max size: %MAX_SIZE%px
echo DPI: %DPI%
echo.

if not exist "%INPUT_FILE%" (
    echo ERROR: File not found: %INPUT_FILE%
    pause
    exit /b 1
)

echo Extracting images...
echo.

if exist "dist\markitdown.exe" (
    echo Using compiled executable...
    python image_extractor.py "%INPUT_FILE%" --output-dir "%OUTPUT_DIR%" --max-size %MAX_SIZE% --dpi %DPI%
) else (
    echo Using Python script...
    python image_extractor.py "%INPUT_FILE%" --output-dir "%OUTPUT_DIR%" --max-size %MAX_SIZE% --dpi %DPI%
)

if errorlevel 1 (
    echo.
    echo ========================================
    echo IMAGE EXTRACTION FAILED!
    echo ========================================
    echo Check the error messages above.
    echo.
    echo Common issues:
    echo - Missing dependencies: pip install pdf2image PyMuPDF Pillow
    echo - Unsupported file format
    echo - Corrupted input file
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo IMAGE EXTRACTION SUCCESSFUL!
echo ========================================
echo.
echo Images saved to: %OUTPUT_DIR%
echo.
echo You can now attach these PNG files to OpenAI:
if exist "%OUTPUT_DIR%" (
    echo   Number of images: 
    for /f %%i in ('dir /b "%OUTPUT_DIR%\*.png" 2^>nul ^| find /c /v ""') do echo     %%i PNG files
    echo.
    echo   Total size:
    for /f "tokens=3" %%i in ('dir "%OUTPUT_DIR%\*.png" 2^>nul ^| find "File(s)"') do echo     %%i bytes
)
echo.
pause
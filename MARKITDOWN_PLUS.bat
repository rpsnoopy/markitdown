@echo off
echo ========================================
echo MarkItDown PLUS - Text + Images
echo Convert documents to Markdown AND extract images
echo ========================================
echo.

if "%~1"=="" (
    echo Usage: MARKITDOWN_PLUS.bat ^<document_file^> [markdown_output] [images_directory]
    echo.
    echo This will:
    echo   1. Convert document to Markdown text
    echo   2. Extract page images (PNG format, max 2000px)
    echo   3. Create a complete package for OpenAI attachment
    echo.
    echo Examples:
    echo   MARKITDOWN_PLUS.bat document.pdf
    echo   MARKITDOWN_PLUS.bat presentation.pptx slides.md slide_images
    echo   MARKITDOWN_PLUS.bat report.docx report.md report_pages
    echo.
    pause
    exit /b 1
)

set INPUT_FILE=%~1
set MARKDOWN_OUTPUT=%~2
set IMAGES_DIR=%~3

if "%MARKDOWN_OUTPUT%"=="" (
    for %%f in ("%INPUT_FILE%") do set MARKDOWN_OUTPUT=%%~nf.md
)

if "%IMAGES_DIR%"=="" (
    for %%f in ("%INPUT_FILE%") do set IMAGES_DIR=%%~nf_images
)

echo Input file: %INPUT_FILE%
echo Markdown output: %MARKDOWN_OUTPUT%
echo Images directory: %IMAGES_DIR%
echo.

if not exist "%INPUT_FILE%" (
    echo ERROR: File not found: %INPUT_FILE%
    pause
    exit /b 1
)

echo [1/2] Converting to Markdown...
if exist "dist\markitdown.exe" (
    "dist\markitdown.exe" "%INPUT_FILE%" -o "%MARKDOWN_OUTPUT%"
) else (
    python -m markitdown "%INPUT_FILE%" -o "%MARKDOWN_OUTPUT%"
)

if errorlevel 1 (
    echo ERROR: Markdown conversion failed
    pause
    exit /b 1
)

echo ✅ Markdown saved: %MARKDOWN_OUTPUT%
echo.

echo [2/2] Extracting page images...
python image_extractor.py "%INPUT_FILE%" --output-dir "%IMAGES_DIR%" --max-size 2000 --dpi 200

if errorlevel 1 (
    echo WARNING: Image extraction failed, but Markdown conversion succeeded
    echo You still have the text conversion: %MARKDOWN_OUTPUT%
    pause
    exit /b 0
)

echo.
echo ========================================
echo CONVERSION COMPLETE!
echo ========================================
echo.
echo 📄 Markdown text: %MARKDOWN_OUTPUT%
echo 🖼️  Images folder: %IMAGES_DIR%
echo.
echo Ready for OpenAI attachment:
echo   1. Upload the Markdown file: %MARKDOWN_OUTPUT%
echo   2. Upload the image files from: %IMAGES_DIR%
echo.

if exist "%MARKDOWN_OUTPUT%" (
    for %%i in ("%MARKDOWN_OUTPUT%") do echo   Markdown size: %%~zi bytes
)

if exist "%IMAGES_DIR%" (
    echo   Image count:
    for /f %%i in ('dir /b "%IMAGES_DIR%\*.png" 2^>nul ^| find /c /v ""') do echo     %%i PNG files
    echo   Images total size:
    for /f "tokens=3" %%i in ('dir "%IMAGES_DIR%\*.png" 2^>nul ^| find "File(s)"') do echo     %%i bytes
)

echo.
echo 🎯 Perfect for OpenAI document analysis with both text and visual content!
echo.
pause
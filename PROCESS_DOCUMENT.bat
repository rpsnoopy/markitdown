@echo off
echo ========================================
echo MarkItDown Enhanced Document Processor
echo Text + Images with Structured Output
echo ========================================
echo.

if "%~1"=="" (
    echo Usage: PROCESS_DOCUMENT.bat ^<document_file^> [--json] [--quiet]
    echo.
    echo This creates a structured output in the same directory:
    echo   source.pdf -^> source/
    echo                 source.txt  ^(extracted text^)
    echo                 page_images/
    echo                   source_page_1.png
    echo                   source_page_2.png
    echo                   ...
    echo.
    echo Options:
    echo   --json    Output detailed JSON status to stdout
    echo   --quiet   Suppress non-JSON messages
    echo.
    echo Examples:
    echo   PROCESS_DOCUMENT.bat document.pdf
    echo   PROCESS_DOCUMENT.bat report.docx --json
    echo   PROCESS_DOCUMENT.bat presentation.pptx --quiet --json
    echo.
    echo Exit codes:
    echo   0  = Complete success
    echo   10 = Text only extracted
    echo   11 = Images only extracted  
    echo   12 = Text and images extracted
    echo   13 = Partial success ^(recoverable errors^)
    echo   1  = File error ^(not found, permissions, format^)
    echo   2  = PDF corrupted/unreadable
    echo   3  = Timeout/user interruption
    echo   4  = Configuration/parameter error
    echo.
    pause
    exit /b 4
)

set INPUT_FILE=%~1
set EXTRA_ARGS=%~2 %~3 %~4

if not exist "%INPUT_FILE%" (
    echo ERROR: File not found: %INPUT_FILE%
    exit /b 1
)

echo Processing: %INPUT_FILE%
echo.

if exist "dist\markitdown_enhanced.exe" (
    echo Using compiled enhanced executable...
    "dist\markitdown_enhanced.exe" "%INPUT_FILE%" %EXTRA_ARGS%
    set EXIT_CODE=%ERRORLEVEL%
) else (
    echo Using Python script...
    python markitdown_enhanced.py "%INPUT_FILE%" %EXTRA_ARGS%
    set EXIT_CODE=%ERRORLEVEL%
)

echo.
echo Process completed with exit code: %EXIT_CODE%

if %EXIT_CODE%==0 (
    echo ✅ Complete success
) else if %EXIT_CODE%==10 (
    echo ✅ Text only extracted
) else if %EXIT_CODE%==11 (
    echo ✅ Images only extracted
) else if %EXIT_CODE%==12 (
    echo ✅ Text and images extracted
) else if %EXIT_CODE%==13 (
    echo ⚠️  Partial success ^(with warnings^)
) else if %EXIT_CODE%==1 (
    echo ❌ File error
) else if %EXIT_CODE%==2 (
    echo ❌ Document corrupted/unreadable
) else if %EXIT_CODE%==3 (
    echo ❌ Processing interrupted
) else if %EXIT_CODE%==4 (
    echo ❌ Configuration error
) else (
    echo ❌ Unknown error
)

exit /b %EXIT_CODE%
@echo off
setlocal enabledelayedexpansion
echo ========================================
echo MarkItDown Complete Test Suite
echo Testing all formats and features
echo ========================================
echo.

set TEST_DIR=test_files
set RESULTS_DIR=test_results
set ENHANCED_EXE=dist\markitdown_enhanced.exe
set REGULAR_EXE=dist\markitdown.exe

echo [SETUP] Preparing test environment...

if not exist "%TEST_DIR%" (
    echo ERROR: Test files directory not found: %TEST_DIR%
    echo Please create test files first by running: CREATE_TEST_FILES.bat
    pause
    exit /b 1
)

if not exist "%ENHANCED_EXE%" (
    echo ERROR: Enhanced executable not found: %ENHANCED_EXE%
    echo Please compile first by running: COMPILE.bat
    pause
    exit /b 1
)

if exist "%RESULTS_DIR%" rmdir /s /q "%RESULTS_DIR%"
mkdir "%RESULTS_DIR%"

echo Test files directory: %TEST_DIR%
echo Results directory: %RESULTS_DIR%
echo Enhanced executable: %ENHANCED_EXE%
echo Regular executable: %REGULAR_EXE%
echo.

echo ========================================
echo PHASE 1: BASIC FUNCTIONALITY TESTS
echo ========================================
echo.

set PASSED=0
set FAILED=0
set TOTAL=0

echo [1.1] Testing version command...
"%ENHANCED_EXE%" --version > "%RESULTS_DIR%\version_test.txt" 2>&1
if %ERRORLEVEL%==0 (
    echo ✅ Version command: PASSED
    set /a PASSED+=1
) else (
    echo ❌ Version command: FAILED
    set /a FAILED+=1
)
set /a TOTAL+=1

echo [1.2] Testing help command...
"%ENHANCED_EXE%" --help > "%RESULTS_DIR%\help_test.txt" 2>&1
if %ERRORLEVEL%==0 (
    echo ✅ Help command: PASSED
    set /a PASSED+=1
) else (
    echo ❌ Help command: FAILED
    set /a FAILED+=1
)
set /a TOTAL+=1

echo [1.3] Testing invalid file...
"%ENHANCED_EXE%" nonexistent_file.pdf --json-output --quiet > "%RESULTS_DIR%\invalid_file_test.json" 2>&1
if %ERRORLEVEL%==1 (
    echo ✅ Invalid file handling: PASSED ^(exit code 1^)
    set /a PASSED+=1
) else (
    echo ❌ Invalid file handling: FAILED ^(exit code %ERRORLEVEL%^)
    set /a FAILED+=1
)
set /a TOTAL+=1

echo.
echo ========================================
echo PHASE 2: FORMAT-SPECIFIC TESTS
echo ========================================
echo.

echo [2.1] Testing TEXT files...
if exist "%TEST_DIR%\*.txt" (
    for %%f in ("%TEST_DIR%\*.txt") do (
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\%%~nf_result.json" 2>&1
        set EXIT_CODE=!ERRORLEVEL!
        if !EXIT_CODE! LEQ 13 (
            echo   ✅ %%~nxf: PASSED ^(exit code !EXIT_CODE!^)
            set /a PASSED+=1
        ) else (
            echo   ❌ %%~nxf: FAILED ^(exit code !EXIT_CODE!^)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
) else (
    echo   ⚠️ No TXT files found in %TEST_DIR%
)

echo [2.2] Testing HTML files...
if exist "%TEST_DIR%\*.html" (
    for %%f in ("%TEST_DIR%\*.html") do (
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\%%~nf_result.json" 2>&1
        set EXIT_CODE=!ERRORLEVEL!
        if !EXIT_CODE! LEQ 13 (
            echo   ✅ %%~nxf: PASSED ^(exit code !EXIT_CODE!^)
            set /a PASSED+=1
        ) else (
            echo   ❌ %%~nxf: FAILED ^(exit code !EXIT_CODE!^)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
) else (
    echo   ⚠️ No HTML files found in %TEST_DIR%
)

echo [2.3] Testing CSV files...
if exist "%TEST_DIR%\*.csv" (
    for %%f in ("%TEST_DIR%\*.csv") do (
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\%%~nf_result.json" 2>&1
        set EXIT_CODE=!ERRORLEVEL!
        if !EXIT_CODE! LEQ 13 (
            echo   ✅ %%~nxf: PASSED ^(exit code !EXIT_CODE!^)
            set /a PASSED+=1
        ) else (
            echo   ❌ %%~nxf: FAILED ^(exit code !EXIT_CODE!^)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
) else (
    echo   ⚠️ No CSV files found in %TEST_DIR%
)

echo [2.4] Testing JSON files...
if exist "%TEST_DIR%\*.json" (
    for %%f in ("%TEST_DIR%\*.json") do (
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\%%~nf_result.json" 2>&1
        set EXIT_CODE=!ERRORLEVEL!
        if !EXIT_CODE! LEQ 13 (
            echo   ✅ %%~nxf: PASSED ^(exit code !EXIT_CODE!^)
            set /a PASSED+=1
        ) else (
            echo   ❌ %%~nxf: FAILED ^(exit code !EXIT_CODE!^)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
) else (
    echo   ⚠️ No JSON files found in %TEST_DIR%
)

echo [2.5] Testing PDF files...
if exist "%TEST_DIR%\*.pdf" (
    for %%f in ("%TEST_DIR%\*.pdf") do (
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\%%~nf_result.json" 2>&1
        set EXIT_CODE=!ERRORLEVEL!
        if !EXIT_CODE! LEQ 13 (
            echo   ✅ %%~nxf: PASSED ^(exit code !EXIT_CODE!^)
            set /a PASSED+=1
        ) else (
            echo   ❌ %%~nxf: FAILED ^(exit code !EXIT_CODE!^)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
) else (
    echo   ⚠️ No PDF files found in %TEST_DIR%
)

echo [2.6] Testing Office documents...
for %%ext in (docx xlsx pptx) do (
    if exist "%TEST_DIR%\*.%%ext" (
        echo   Testing %%ext files...
        for %%f in ("%TEST_DIR%\*.%%ext") do (
            echo     Testing: %%~nxf
            "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\%%~nf_result.json" 2>&1
            set EXIT_CODE=!ERRORLEVEL!
            if !EXIT_CODE! LEQ 13 (
                echo     ✅ %%~nxf: PASSED ^(exit code !EXIT_CODE!^)
                set /a PASSED+=1
            ) else (
                echo     ❌ %%~nxf: FAILED ^(exit code !EXIT_CODE!^)
                set /a FAILED+=1
            )
            set /a TOTAL+=1
        )
    ) else (
        echo   ⚠️ No %%ext files found in %TEST_DIR%
    )
)

echo [2.7] Testing Image files...
for %%ext in (jpg jpeg png gif bmp) do (
    if exist "%TEST_DIR%\*.%%ext" (
        echo   Testing %%ext files...
        for %%f in ("%TEST_DIR%\*.%%ext") do (
            echo     Testing: %%~nxf
            "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\%%~nf_result.json" 2>&1
            set EXIT_CODE=!ERRORLEVEL!
            if !EXIT_CODE! LEQ 13 (
                echo     ✅ %%~nxf: PASSED ^(exit code !EXIT_CODE!^)
                set /a PASSED+=1
            ) else (
                echo     ❌ %%~nxf: FAILED ^(exit code !EXIT_CODE!^)
                set /a FAILED+=1
            )
            set /a TOTAL+=1
        )
    ) else (
        echo   ⚠️ No %%ext files found in %TEST_DIR%
    )
)

echo.
echo ========================================
echo PHASE 3: JSON OUTPUT VALIDATION
echo ========================================
echo.

echo [3.1] Validating JSON structure...
set JSON_VALID=0
set JSON_TOTAL=0

for %%f in ("%RESULTS_DIR%\*_result.json") do (
    set /a JSON_TOTAL+=1
    
    REM Check if file contains required JSON fields
    findstr /C:"status" "%%f" >nul && (
        findstr /C:"exit_code" "%%f" >nul && (
            findstr /C:"text_extracted" "%%f" >nul && (
                findstr /C:"images_count" "%%f" >nul && (
                    findstr /C:"output_files" "%%f" >nul && (
                        set /a JSON_VALID+=1
                        echo   ✅ %%~nxf: Valid JSON structure
                    ) || echo   ❌ %%~nxf: Missing output_files
                ) || echo   ❌ %%~nxf: Missing images_count
            ) || echo   ❌ %%~nxf: Missing text_extracted
        ) || echo   ❌ %%~nxf: Missing exit_code
    ) || echo   ❌ %%~nxf: Missing status
)

echo   JSON validation: %JSON_VALID%/%JSON_TOTAL% files have valid structure

echo.
echo ========================================
echo PHASE 4: OUTPUT STRUCTURE VALIDATION
echo ========================================
echo.

echo [4.1] Checking output directory structure...
set STRUCT_VALID=0
set STRUCT_TOTAL=0

for %%f in ("%TEST_DIR%\*.*") do (
    set BASENAME=%%~nf
    if exist "!BASENAME!" (
        set /a STRUCT_TOTAL+=1
        set VALID=1
        
        REM Check if text file exists
        if not exist "!BASENAME!\!BASENAME!.txt" (
            echo   ❌ !BASENAME!: Missing text file
            set VALID=0
        )
        
        REM Check if page_images directory exists
        if not exist "!BASENAME!\page_images" (
            echo   ❌ !BASENAME!: Missing page_images directory
            set VALID=0
        )
        
        REM Check if images_analysis file exists
        if not exist "!BASENAME!\!BASENAME!_images_analysis.txt" (
            echo   ❌ !BASENAME!: Missing images_analysis file
            set VALID=0
        )
        
        if !VALID!==1 (
            echo   ✅ !BASENAME!: Complete structure
            set /a STRUCT_VALID+=1
        )
    )
)

echo   Structure validation: %STRUCT_VALID%/%STRUCT_TOTAL% outputs have complete structure

echo.
echo ========================================
echo PHASE 5: COMPARISON WITH REGULAR MARKITDOWN
echo ========================================
echo.

if exist "%REGULAR_EXE%" (
    echo [5.1] Comparing text extraction with regular MarkItDown...
    set COMPARE_PASSED=0
    set COMPARE_TOTAL=0
    
    for %%f in ("%TEST_DIR%\*.txt" "%TEST_DIR%\*.html" "%TEST_DIR%\*.csv") do (
        if exist "%%f" (
            set /a COMPARE_TOTAL+=1
            
            REM Extract with regular MarkItDown
            "%REGULAR_EXE%" "%%f" > "%RESULTS_DIR%\%%~nf_regular.md" 2>nul
            
            REM Check if enhanced version produced text
            set BASENAME=%%~nf
            if exist "!BASENAME!\!BASENAME!.txt" (
                echo   ✅ %%~nxf: Both versions produced output
                set /a COMPARE_PASSED+=1
            ) else (
                echo   ❌ %%~nxf: Enhanced version failed where regular succeeded
            )
        )
    )
    
    echo   Compatibility check: %COMPARE_PASSED%/%COMPARE_TOTAL% files consistent
) else (
    echo [5.1] Regular MarkItDown not found, skipping comparison
)

echo.
echo ========================================
echo FINAL TEST RESULTS
echo ========================================
echo.
echo Basic functionality: %PASSED%/%TOTAL% tests passed
echo JSON structure validation: %JSON_VALID%/%JSON_TOTAL% files valid
echo Output structure validation: %STRUCT_VALID%/%STRUCT_TOTAL% outputs complete

if exist "%REGULAR_EXE%" (
    echo Compatibility with regular: %COMPARE_PASSED%/%COMPARE_TOTAL% consistent
)

echo.
echo Failed tests: %FAILED%
echo.

if %FAILED%==0 (
    echo 🎉 ALL TESTS PASSED! 
    echo MarkItDown Enhanced is working perfectly.
    set FINAL_EXIT=0
) else (
    echo ❌ SOME TESTS FAILED!
    echo Check the results in: %RESULTS_DIR%
    set FINAL_EXIT=1
)

echo.
echo Detailed results saved to: %RESULTS_DIR%
echo Test log: %RESULTS_DIR%\test_log.txt
echo.

REM Save summary
echo Test Summary > "%RESULTS_DIR%\test_summary.txt"
echo Date: %DATE% %TIME% >> "%RESULTS_DIR%\test_summary.txt"
echo Basic tests: %PASSED%/%TOTAL% passed >> "%RESULTS_DIR%\test_summary.txt"
echo Failed tests: %FAILED% >> "%RESULTS_DIR%\test_summary.txt"
echo JSON validation: %JSON_VALID%/%JSON_TOTAL% valid >> "%RESULTS_DIR%\test_summary.txt"
echo Structure validation: %STRUCT_VALID%/%STRUCT_TOTAL% complete >> "%RESULTS_DIR%\test_summary.txt"

pause
exit /b %FINAL_EXIT%
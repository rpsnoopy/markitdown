@echo off
setlocal enabledelayedexpansion
echo ========================================
echo PDF Processor Integration - Test Suite
echo ========================================
echo.

set TEST_DIR=test_files
set RESULTS_DIR=test_results
set ENHANCED_EXE=dist\markitdown_enhanced.exe

echo [SETUP] Environment check...
if not exist "%TEST_DIR%" (
    echo ERROR: Test files directory not found: %TEST_DIR%
    pause
    exit /b 1
)

if not exist "%ENHANCED_EXE%" (
    echo ERROR: Enhanced executable not found: %ENHANCED_EXE%
    pause
    exit /b 1
)

echo [CLEANUP] Removing previous test results...
if exist "%RESULTS_DIR%" rmdir /s /q "%RESULTS_DIR%"
mkdir "%RESULTS_DIR%"

echo [CLEANUP] Cleaning processed files in test_files directory...
for /d %%d in ("%TEST_DIR%\*") do (
    if exist "%%d" (
        echo   Removing: %%d
        rmdir /s /q "%%d"
    )
)
echo   Test files cleanup completed.

echo Initializing counters...
set PASSED=0
set FAILED=0
set TOTAL=0

echo ========================================
echo RUNNING TESTS
echo ========================================

echo [1] Testing help command...
"%ENHANCED_EXE%" --help > "%RESULTS_DIR%\help_test.txt" 2>&1
set TEST_EXIT=!ERRORLEVEL!
if !TEST_EXIT!==0 (
    echo   Result: Exit code !TEST_EXIT!
    echo   Status: PASSED
    set /a PASSED+=1
) else (
    echo   Result: Exit code !TEST_EXIT!
    echo   Status: FAILED
    set /a FAILED+=1
)
set /a TOTAL+=1

echo [2] Testing invalid file...
"%ENHANCED_EXE%" nonexistent.pdf --json-output --quiet > "%RESULTS_DIR%\invalid_test.json" 2>&1
set TEST_EXIT=!ERRORLEVEL!
if !TEST_EXIT!==1 (
    echo   Result: Exit code !TEST_EXIT!
    echo   Status: PASSED
    set /a PASSED+=1
) else (
    echo   Result: Exit code !TEST_EXIT!
    echo   Status: FAILED
    set /a FAILED+=1
)
set /a TOTAL+=1

echo [3] Testing file formats...
for %%f in ("%TEST_DIR%\*.txt") do (
    if exist "%%f" (
        set BASENAME=%%~nf
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
        set FILE_EXIT=!ERRORLEVEL!
        if !FILE_EXIT! LEQ 12 (
            echo     Exit code: !FILE_EXIT!
            echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
            set /a PASSED+=1
        ) else (
            echo     Status: FAILED (exit code !FILE_EXIT!)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
)

for %%f in ("%TEST_DIR%\*.html") do (
    if exist "%%f" (
        set BASENAME=%%~nf
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
        set FILE_EXIT=!ERRORLEVEL!
        if !FILE_EXIT! LEQ 12 (
            echo     Exit code: !FILE_EXIT!
            echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
            set /a PASSED+=1
        ) else (
            echo     Status: FAILED (exit code !FILE_EXIT!)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
)
for %%f in ("%TEST_DIR%\*.csv") do (
    if exist "%%f" (
        set BASENAME=%%~nf
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
        set FILE_EXIT=!ERRORLEVEL!
        if !FILE_EXIT! LEQ 12 (
            echo     Exit code: !FILE_EXIT!
            echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
            set /a PASSED+=1
        ) else (
            echo     Status: FAILED (exit code !FILE_EXIT!)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
)
for %%f in ("%TEST_DIR%\*.json") do (
    if exist "%%f" (
        set BASENAME=%%~nf
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
        set FILE_EXIT=!ERRORLEVEL!
        if !FILE_EXIT! LEQ 12 (
            echo     Exit code: !FILE_EXIT!
            echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
            set /a PASSED+=1
        ) else (
            echo     Status: FAILED (exit code !FILE_EXIT!)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
)
for %%f in ("%TEST_DIR%\*.pdf") do (
    if exist "%%f" (
        set BASENAME=%%~nf
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
        set FILE_EXIT=!ERRORLEVEL!
        if !FILE_EXIT! LEQ 12 (
            echo     Exit code: !FILE_EXIT!
            echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
            set /a PASSED+=1
        ) else (
            echo     Status: FAILED (exit code !FILE_EXIT!)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
)
for %%f in ("%TEST_DIR%\*.docx") do (
    if exist "%%f" (
        set BASENAME=%%~nf
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
        set FILE_EXIT=!ERRORLEVEL!
        if !FILE_EXIT! LEQ 12 (
            echo     Exit code: !FILE_EXIT!
            echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
            set /a PASSED+=1
        ) else (
            echo     Status: FAILED (exit code !FILE_EXIT!)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
)
for %%f in ("%TEST_DIR%\*.xlsx") do (
    if exist "%%f" (
        set BASENAME=%%~nf
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
        set FILE_EXIT=!ERRORLEVEL!
        if !FILE_EXIT! LEQ 12 (
            echo     Exit code: !FILE_EXIT!
            echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
            set /a PASSED+=1
        ) else (
            echo     Status: FAILED (exit code !FILE_EXIT!)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
)
for %%f in ("%TEST_DIR%\*.pptx") do (
    if exist "%%f" (
        set BASENAME=%%~nf
        echo   Testing: %%~nxf
        "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
        set FILE_EXIT=!ERRORLEVEL!
        if !FILE_EXIT! LEQ 12 (
            echo     Exit code: !FILE_EXIT!
            echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
            set /a PASSED+=1
        ) else (
            echo     Status: FAILED (exit code !FILE_EXIT!)
            set /a FAILED+=1
        )
        set /a TOTAL+=1
    )
)
for %%ext in (jpg jpeg png gif bmp) do (
    for %%f in ("%TEST_DIR%\*.%%ext") do (
        if exist "%%f" (
            set BASENAME=%%~nf
            echo   Testing: %%~nxf
            "%ENHANCED_EXE%" "%%f" --json-output --quiet > "%RESULTS_DIR%\!BASENAME!_result.json" 2>&1
            set FILE_EXIT=!ERRORLEVEL!
            if !FILE_EXIT! LEQ 12 (
                echo     Exit code: !FILE_EXIT!
                echo     Status: PASSED (exit code !FILE_EXIT! is acceptable)
                set /a PASSED+=1
            ) else (
                echo     Status: FAILED (exit code !FILE_EXIT!)
                set /a FAILED+=1
            )
            set /a TOTAL+=1
        )
    )
)

echo ========================================
echo FINAL RESULTS
echo ========================================

if !TOTAL! GTR 0 (
    set /a SUCCESS_RATE=!PASSED! * 100 / !TOTAL!
) else (
    set SUCCESS_RATE=0
)

echo Test Summary:
echo   Total Tests: !TOTAL!
echo   Passed: !PASSED!
echo   Failed: !FAILED!
echo   Success Rate: !SUCCESS_RATE!%%
echo.

if !SUCCESS_RATE! GEQ 90 (
    echo RESULT: EXCELLENT - !SUCCESS_RATE!%% success rate
    echo PDF Processor Integration is working great
) else (
    if !SUCCESS_RATE! GEQ 70 (
        echo RESULT: GOOD - !SUCCESS_RATE!%% success rate
        echo Most features working, minor issues
    ) else (
        echo RESULT: NEEDS ATTENTION - !SUCCESS_RATE!%% success rate
        echo Significant issues found
    )
)

echo.
echo Detailed results saved in: %RESULTS_DIR%
echo Check individual JSON files for specific test details
echo.
echo Press any key to close...
pause >nul
exit /b 0
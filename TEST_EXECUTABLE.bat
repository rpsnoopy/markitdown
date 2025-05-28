@echo off
echo ========================================
echo Testing MarkItDown Executable
echo ========================================
echo.

if not exist "dist\markitdown.exe" (
    echo ERROR: markitdown.exe not found!
    echo Please run COMPILE.bat first to build the executable.
    pause
    exit /b 1
)

echo [1/6] Testing version command...
"dist\markitdown.exe" --version
if errorlevel 1 (
    echo FAILED: Version command failed
    goto :error
)
echo SUCCESS: Version command works

echo.
echo [2/6] Testing help command...
"dist\markitdown.exe" --help > nul
if errorlevel 1 (
    echo FAILED: Help command failed
    goto :error
) 
echo SUCCESS: Help command works

echo.
echo [3/6] Creating test files...

echo This is a test text file. > test.txt
echo ^<html^>^<body^>^<h1^>Test^</h1^>^<p^>HTML test^</p^>^</body^>^</html^> > test.html
echo name,age,city > test.csv
echo John,30,New York >> test.csv
echo Jane,25,Los Angeles >> test.csv

echo Test files created: test.txt, test.html, test.csv

echo.
echo [4/6] Testing text file conversion...
"dist\markitdown.exe" test.txt > test_output.md 2>nul
if errorlevel 1 (
    echo FAILED: Text conversion failed
    goto :cleanup
)
echo SUCCESS: Text file conversion works

echo.
echo [5/6] Testing HTML file conversion...
"dist\markitdown.exe" test.html > test_html_output.md 2>nul
if errorlevel 1 (
    echo FAILED: HTML conversion failed
    goto :cleanup
)
echo SUCCESS: HTML file conversion works

echo.
echo [6/6] Testing CSV file conversion...
"dist\markitdown.exe" test.csv > test_csv_output.md 2>nul
if errorlevel 1 (
    echo FAILED: CSV conversion failed
    goto :cleanup
)
echo SUCCESS: CSV file conversion works

echo.
echo ========================================
echo ALL TESTS PASSED!
echo ========================================
echo.
echo Your MarkItDown executable is working correctly!
echo You can now use it to convert documents:
echo.
echo   dist\markitdown.exe document.pdf ^> output.md
echo   dist\markitdown.exe presentation.pptx -o presentation.md
echo   dist\markitdown.exe spreadsheet.xlsx
echo.
goto :cleanup

:error
echo ========================================
echo TESTS FAILED!
echo ========================================
echo There may be an issue with the compilation.
echo Try rebuilding with COMPILE.bat
echo.

:cleanup
echo Cleaning up test files...
if exist test.txt del test.txt
if exist test.html del test.html  
if exist test.csv del test.csv
if exist test_output.md del test_output.md
if exist test_html_output.md del test_html_output.md
if exist test_csv_output.md del test_csv_output.md

pause
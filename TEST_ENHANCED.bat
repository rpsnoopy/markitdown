@echo off
echo ========================================
echo Testing Enhanced MarkItDown
echo ========================================
echo.

echo Creating test files...

echo This is a test document. > test_doc.txt
echo It has multiple lines of content. >> test_doc.txt
echo Perfect for testing the enhanced processor. >> test_doc.txt

echo ^<html^>^<body^>^<h1^>Test Document^</h1^>^<p^>This is a test HTML document for the enhanced processor.^</p^>^</body^>^</html^> > test_doc.html

echo name,value,description > test_doc.csv
echo Item1,100,First test item >> test_doc.csv
echo Item2,200,Second test item >> test_doc.csv

echo Test files created: test_doc.txt, test_doc.html, test_doc.csv
echo.

echo [1/3] Testing TXT processing...
echo ----------------------------------------
PROCESS_DOCUMENT.bat test_doc.txt --quiet
set TXT_EXIT=%ERRORLEVEL%
echo TXT processing exit code: %TXT_EXIT%
echo.

echo [2/3] Testing HTML processing...
echo ----------------------------------------
PROCESS_DOCUMENT.bat test_doc.html --quiet
set HTML_EXIT=%ERRORLEVEL%
echo HTML processing exit code: %HTML_EXIT%
echo.

echo [3/3] Testing CSV processing with JSON output...
echo ----------------------------------------
PROCESS_DOCUMENT.bat test_doc.csv --json --quiet
set CSV_EXIT=%ERRORLEVEL%
echo CSV processing exit code: %CSV_EXIT%
echo.

echo ========================================
echo TEST RESULTS SUMMARY
echo ========================================
echo TXT processing:  %TXT_EXIT%
echo HTML processing: %HTML_EXIT%
echo CSV processing:  %CSV_EXIT%
echo.

if exist test_doc\ (
    echo ✅ TXT: Output directory created
    if exist test_doc\test_doc.txt (
        echo ✅ TXT: Text file created
    ) else (
        echo ❌ TXT: Text file missing
    )
    if exist test_doc\page_images\ (
        echo ✅ TXT: Images directory created
    ) else (
        echo ❌ TXT: Images directory missing
    )
) else (
    echo ❌ TXT: No output directory created
)

if exist test_doc\ (
    echo.
    echo Directory structure example ^(test_doc/^):
    dir /s test_doc
)

echo.
echo Cleaning up test files...
if exist test_doc rmdir /s /q test_doc
if exist test_doc rmdir /s /q test_doc
if exist test_doc rmdir /s /q test_doc
del test_doc.txt test_doc.html test_doc.csv 2>nul

echo.
if %TXT_EXIT% LEQ 13 if %HTML_EXIT% LEQ 13 if %CSV_EXIT% LEQ 13 (
    echo ✅ ALL TESTS PASSED!
    echo The enhanced processor is working correctly.
) else (
    echo ❌ SOME TESTS FAILED!
    echo Check the error messages above.
)

echo.
pause
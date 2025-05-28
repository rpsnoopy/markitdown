@echo off
echo ========================================
echo Creating Test Files for MarkItDown
echo ========================================
echo.

set TEST_DIR=test_files

if exist "%TEST_DIR%" (
    echo Removing existing test files...
    rmdir /s /q "%TEST_DIR%"
)

mkdir "%TEST_DIR%"
echo Created test directory: %TEST_DIR%
echo.

echo [1/7] Creating TEXT files...
echo This is a simple text document. > "%TEST_DIR%\simple_text.txt"
echo It contains multiple lines of content. >> "%TEST_DIR%\simple_text.txt"
echo Perfect for testing basic text extraction. >> "%TEST_DIR%\simple_text.txt"
echo. >> "%TEST_DIR%\simple_text.txt"
echo Second paragraph with more content. >> "%TEST_DIR%\simple_text.txt"
echo End of document. >> "%TEST_DIR%\simple_text.txt"

echo UTF-8 Text Document > "%TEST_DIR%\utf8_text.txt"
echo ================== >> "%TEST_DIR%\utf8_text.txt"
echo This document contains special characters: >> "%TEST_DIR%\utf8_text.txt"
echo • Bullet points >> "%TEST_DIR%\utf8_text.txt"
echo ★ Unicode symbols >> "%TEST_DIR%\utf8_text.txt"
echo © Copyright symbols >> "%TEST_DIR%\utf8_text.txt"
echo Émile Français avec accents >> "%TEST_DIR%\utf8_text.txt"

echo ✅ TEXT files created

echo [2/7] Creating HTML files...
echo ^<html^>^<head^>^<title^>Test HTML Document^</title^>^</head^> > "%TEST_DIR%\test_document.html"
echo ^<body^> >> "%TEST_DIR%\test_document.html"
echo ^<h1^>Main Title^</h1^> >> "%TEST_DIR%\test_document.html"
echo ^<p^>This is a ^<strong^>test HTML document^</strong^> for MarkItDown processing.^</p^> >> "%TEST_DIR%\test_document.html"
echo ^<h2^>Features^</h2^> >> "%TEST_DIR%\test_document.html"
echo ^<ul^> >> "%TEST_DIR%\test_document.html"
echo ^<li^>Text extraction^</li^> >> "%TEST_DIR%\test_document.html"
echo ^<li^>Image processing^</li^> >> "%TEST_DIR%\test_document.html"
echo ^<li^>Format conversion^</li^> >> "%TEST_DIR%\test_document.html"
echo ^</ul^> >> "%TEST_DIR%\test_document.html"
echo ^<p^>^<a href="https://example.com"^>Link example^</a^>^</p^> >> "%TEST_DIR%\test_document.html"
echo ^</body^>^</html^> >> "%TEST_DIR%\test_document.html"

echo ^<^!DOCTYPE html^>^<html^>^<head^>^<meta charset="utf-8"^>^<title^>Complex HTML^</title^>^</head^> > "%TEST_DIR%\complex_html.html"
echo ^<body^>^<div class="container"^>^<header^>^<h1^>Complex Document^</h1^>^</header^> >> "%TEST_DIR%\complex_html.html"
echo ^<main^>^<section^>^<h2^>Section 1^</h2^>^<p^>Content with ^<em^>emphasis^</em^> and ^<code^>code^</code^>.^</p^> >> "%TEST_DIR%\complex_html.html"
echo ^<table^>^<tr^>^<th^>Name^</th^>^<th^>Value^</th^>^</tr^>^<tr^>^<td^>Item 1^</td^>^<td^>100^</td^>^</tr^>^</table^> >> "%TEST_DIR%\complex_html.html"
echo ^</section^>^</main^>^<footer^>^<p^>Footer content^</p^>^</footer^>^</div^>^</body^>^</html^> >> "%TEST_DIR%\complex_html.html"

echo ✅ HTML files created

echo [3/7] Creating CSV files...
echo name,age,city,country > "%TEST_DIR%\people_data.csv"
echo John Doe,30,New York,USA >> "%TEST_DIR%\people_data.csv"
echo Jane Smith,25,London,UK >> "%TEST_DIR%\people_data.csv"
echo Marco Rossi,35,Rome,Italy >> "%TEST_DIR%\people_data.csv"
echo Marie Dubois,28,Paris,France >> "%TEST_DIR%\people_data.csv"
echo Hans Mueller,40,Berlin,Germany >> "%TEST_DIR%\people_data.csv"

echo product,price,category,stock > "%TEST_DIR%\inventory.csv"
echo Laptop,999.99,Electronics,50 >> "%TEST_DIR%\inventory.csv"
echo "Book ""Programming""",29.99,Books,100 >> "%TEST_DIR%\inventory.csv"
echo Coffee Mug,12.50,Kitchen,200 >> "%TEST_DIR%\inventory.csv"
echo Desk Chair,189.00,Furniture,25 >> "%TEST_DIR%\inventory.csv"

echo ✅ CSV files created

echo [4/7] Creating JSON files...
echo { > "%TEST_DIR%\config.json"
echo   "application": "MarkItDown Test", >> "%TEST_DIR%\config.json"
echo   "version": "1.0.0", >> "%TEST_DIR%\config.json"
echo   "settings": { >> "%TEST_DIR%\config.json"
echo     "max_file_size": 1000000, >> "%TEST_DIR%\config.json"
echo     "supported_formats": ["pdf", "docx", "html", "txt"], >> "%TEST_DIR%\config.json"
echo     "enable_ocr": true >> "%TEST_DIR%\config.json"
echo   }, >> "%TEST_DIR%\config.json"
echo   "users": [ >> "%TEST_DIR%\config.json"
echo     {"name": "Admin", "role": "administrator"}, >> "%TEST_DIR%\config.json"
echo     {"name": "User", "role": "standard"} >> "%TEST_DIR%\config.json"
echo   ] >> "%TEST_DIR%\config.json"
echo } >> "%TEST_DIR%\config.json"

echo { > "%TEST_DIR%\test_data.json"
echo   "test_suite": "MarkItDown Enhanced", >> "%TEST_DIR%\test_data.json"
echo   "test_cases": [ >> "%TEST_DIR%\test_data.json"
echo     { >> "%TEST_DIR%\test_data.json"
echo       "id": 1, >> "%TEST_DIR%\test_data.json"
echo       "name": "Basic text extraction", >> "%TEST_DIR%\test_data.json"
echo       "expected_result": "success" >> "%TEST_DIR%\test_data.json"
echo     }, >> "%TEST_DIR%\test_data.json"
echo     { >> "%TEST_DIR%\test_data.json"
echo       "id": 2, >> "%TEST_DIR%\test_data.json"
echo       "name": "Image extraction", >> "%TEST_DIR%\test_data.json"
echo       "expected_result": "partial" >> "%TEST_DIR%\test_data.json"
echo     } >> "%TEST_DIR%\test_data.json"
echo   ], >> "%TEST_DIR%\test_data.json"
echo   "metadata": { >> "%TEST_DIR%\test_data.json"
echo     "created": "2024-01-01", >> "%TEST_DIR%\test_data.json"
echo     "author": "Test Suite Generator" >> "%TEST_DIR%\test_data.json"
echo   } >> "%TEST_DIR%\test_data.json"
echo } >> "%TEST_DIR%\test_data.json"

echo ✅ JSON files created

echo [5/7] Creating simple image (PNG)...
REM Create a simple 100x100 white PNG with black text using PowerShell
powershell -Command "& {Add-Type -AssemblyName System.Drawing; $bmp = New-Object System.Drawing.Bitmap(200,100); $graphics = [System.Drawing.Graphics]::FromImage($bmp); $graphics.Clear([System.Drawing.Color]::White); $font = New-Object System.Drawing.Font('Arial',16,[System.Drawing.FontStyle]::Bold); $brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Black); $graphics.DrawString('TEST IMAGE',[System.Drawing.PointF]::new(10,30),$font,$brush); $graphics.DrawString('MarkItDown',[System.Drawing.PointF]::new(10,60),$font,$brush); $bmp.Save('%TEST_DIR%\test_image.png',[System.Drawing.Imaging.ImageFormat]::Png); $graphics.Dispose(); $bmp.Dispose()}" 2>nul

if exist "%TEST_DIR%\test_image.png" (
    echo ✅ PNG image created
) else (
    echo ⚠️ PNG image creation failed ^(PowerShell/GDI+ not available^)
)

echo [6/7] Creating XML file...
echo ^<^?xml version="1.0" encoding="UTF-8"^?^> > "%TEST_DIR%\data.xml"
echo ^<document^> >> "%TEST_DIR%\data.xml"
echo   ^<header^> >> "%TEST_DIR%\data.xml"
echo     ^<title^>XML Test Document^</title^> >> "%TEST_DIR%\data.xml"
echo     ^<author^>Test Suite^</author^> >> "%TEST_DIR%\data.xml"
echo     ^<date^>2024-01-01^</date^> >> "%TEST_DIR%\data.xml"
echo   ^</header^> >> "%TEST_DIR%\data.xml"
echo   ^<content^> >> "%TEST_DIR%\data.xml"
echo     ^<section id="1"^> >> "%TEST_DIR%\data.xml"
echo       ^<title^>Introduction^</title^> >> "%TEST_DIR%\data.xml"
echo       ^<text^>This is a test XML document for MarkItDown processing.^</text^> >> "%TEST_DIR%\data.xml"
echo     ^</section^> >> "%TEST_DIR%\data.xml"
echo     ^<section id="2"^> >> "%TEST_DIR%\data.xml"
echo       ^<title^>Features^</title^> >> "%TEST_DIR%\data.xml"
echo       ^<items^> >> "%TEST_DIR%\data.xml"
echo         ^<item^>XML parsing^</item^> >> "%TEST_DIR%\data.xml"
echo         ^<item^>Content extraction^</item^> >> "%TEST_DIR%\data.xml"
echo       ^</items^> >> "%TEST_DIR%\data.xml"
echo     ^</section^> >> "%TEST_DIR%\data.xml"
echo   ^</content^> >> "%TEST_DIR%\data.xml"
echo ^</document^> >> "%TEST_DIR%\data.xml"

echo ✅ XML file created

echo [7/7] Creating Jupyter notebook...
echo { > "%TEST_DIR%\test_notebook.ipynb"
echo  "cells": [ >> "%TEST_DIR%\test_notebook.ipynb"
echo   { >> "%TEST_DIR%\test_notebook.ipynb"
echo    "cell_type": "markdown", >> "%TEST_DIR%\test_notebook.ipynb"
echo    "metadata": {}, >> "%TEST_DIR%\test_notebook.ipynb"
echo    "source": [ >> "%TEST_DIR%\test_notebook.ipynb"
echo     "# Test Notebook\n", >> "%TEST_DIR%\test_notebook.ipynb"
echo     "\n", >> "%TEST_DIR%\test_notebook.ipynb"
echo     "This is a test Jupyter notebook for MarkItDown processing.\n", >> "%TEST_DIR%\test_notebook.ipynb"
echo     "\n", >> "%TEST_DIR%\test_notebook.ipynb"
echo     "## Features\n", >> "%TEST_DIR%\test_notebook.ipynb"
echo     "\n", >> "%TEST_DIR%\test_notebook.ipynb"
echo     "- Markdown cells\n", >> "%TEST_DIR%\test_notebook.ipynb"
echo     "- Code cells\n", >> "%TEST_DIR%\test_notebook.ipynb"
echo     "- Output cells" >> "%TEST_DIR%\test_notebook.ipynb"
echo    ] >> "%TEST_DIR%\test_notebook.ipynb"
echo   }, >> "%TEST_DIR%\test_notebook.ipynb"
echo   { >> "%TEST_DIR%\test_notebook.ipynb"
echo    "cell_type": "code", >> "%TEST_DIR%\test_notebook.ipynb"
echo    "execution_count": 1, >> "%TEST_DIR%\test_notebook.ipynb"
echo    "metadata": {}, >> "%TEST_DIR%\test_notebook.ipynb"
echo    "outputs": [ >> "%TEST_DIR%\test_notebook.ipynb"
echo     { >> "%TEST_DIR%\test_notebook.ipynb"
echo      "name": "stdout", >> "%TEST_DIR%\test_notebook.ipynb"
echo      "output_type": "stream", >> "%TEST_DIR%\test_notebook.ipynb"
echo      "text": ["Hello, MarkItDown!\n"] >> "%TEST_DIR%\test_notebook.ipynb"
echo     } >> "%TEST_DIR%\test_notebook.ipynb"
echo    ], >> "%TEST_DIR%\test_notebook.ipynb"
echo    "source": ["print('Hello, MarkItDown!')"] >> "%TEST_DIR%\test_notebook.ipynb"
echo   } >> "%TEST_DIR%\test_notebook.ipynb"
echo  ], >> "%TEST_DIR%\test_notebook.ipynb"
echo  "metadata": { >> "%TEST_DIR%\test_notebook.ipynb"
echo   "kernelspec": { >> "%TEST_DIR%\test_notebook.ipynb"
echo    "display_name": "Python 3", >> "%TEST_DIR%\test_notebook.ipynb"
echo    "language": "python", >> "%TEST_DIR%\test_notebook.ipynb"
echo    "name": "python3" >> "%TEST_DIR%\test_notebook.ipynb"
echo   } >> "%TEST_DIR%\test_notebook.ipynb"
echo  }, >> "%TEST_DIR%\test_notebook.ipynb"
echo  "nbformat": 4, >> "%TEST_DIR%\test_notebook.ipynb"
echo  "nbformat_minor": 4 >> "%TEST_DIR%\test_notebook.ipynb"
echo } >> "%TEST_DIR%\test_notebook.ipynb"

echo ✅ Jupyter notebook created

echo.
echo ========================================
echo TEST FILES CREATION COMPLETED
echo ========================================
echo.

echo Created files in %TEST_DIR%:
dir /b "%TEST_DIR%"

echo.
echo Summary:
echo ✅ Text files: simple_text.txt, utf8_text.txt
echo ✅ HTML files: test_document.html, complex_html.html
echo ✅ Data files: people_data.csv, inventory.csv, config.json, test_data.json
echo ✅ XML file: data.xml
echo ✅ Jupyter notebook: test_notebook.ipynb
if exist "%TEST_DIR%\test_image.png" echo ✅ Image file: test_image.png

echo.
echo 📝 MISSING FILES FOR COMPLETE TESTING:
echo.
echo For complete testing, you should add these file types:
echo.
echo 📄 OFFICE DOCUMENTS ^(create these manually^):
echo   - PDF file ^(.pdf^) - any PDF document
echo   - Word document ^(.docx^) - any Word file
echo   - Excel spreadsheet ^(.xlsx^) - any Excel file  
echo   - PowerPoint presentation ^(.pptx^) - any PowerPoint file
echo.
echo 🖼️ ADDITIONAL IMAGES:
echo   - JPEG image ^(.jpg^) - any photo
echo   - GIF image ^(.gif^) - any animated or static GIF
echo   - BMP image ^(.bmp^) - any bitmap image
echo.
echo 📧 EMAIL ^(if available^):
echo   - Outlook message ^(.msg^) - any Outlook email file
echo.
echo 📚 EBOOKS ^(if available^):
echo   - EPUB file ^(.epub^) - any ebook file
echo.
echo 🎵 AUDIO ^(if available^):
echo   - Audio file ^(.mp3, .wav^) - any audio file for transcription testing
echo.
echo ⚠️ PLACE THESE FILES IN THE %TEST_DIR% DIRECTORY
echo ⚠️ THEN RUN: TEST_SUITE.bat
echo.
pause
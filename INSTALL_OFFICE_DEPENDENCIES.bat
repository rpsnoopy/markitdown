@echo off
echo ========================================
echo Installing Office Document Dependencies
echo Required for DOCX, PPTX, XLSX support
echo ========================================
echo.

echo [1/8] Installing python-docx (Word documents)...
python -m pip install python-docx
if errorlevel 1 (
    echo ERROR: Failed to install python-docx
    pause
    exit /b 1
)

echo [2/8] Installing mammoth (Word documents - alternative)...
python -m pip install mammoth
if errorlevel 1 (
    echo ERROR: Failed to install mammoth
    pause
    exit /b 1
)

echo [3/8] Installing lxml (XML processing)...
python -m pip install lxml
if errorlevel 1 (
    echo ERROR: Failed to install lxml
    pause
    exit /b 1
)

echo [4/8] Installing python-pptx (PowerPoint documents)...
python -m pip install python-pptx
if errorlevel 1 (
    echo ERROR: Failed to install python-pptx
    pause
    exit /b 1
)

echo [5/8] Installing openpyxl (Excel documents)...
python -m pip install openpyxl
if errorlevel 1 (
    echo ERROR: Failed to install openpyxl
    pause
    exit /b 1
)

echo [6/8] Installing pandas (Excel support)...
python -m pip install pandas
if errorlevel 1 (
    echo ERROR: Failed to install pandas
    pause
    exit /b 1
)

echo [7/8] Installing PyMuPDF (PDF image extraction)...
python -m pip install PyMuPDF
if errorlevel 1 (
    echo ERROR: Failed to install PyMuPDF
    pause
    exit /b 1
)

echo [8/8] Installing beautifulsoup4 (HTML processing)...
python -m pip install beautifulsoup4
if errorlevel 1 (
    echo ERROR: Failed to install beautifulsoup4
    pause
    exit /b 1
)

echo.
echo ========================================
echo VERIFICATION - Testing Installations
echo ========================================
echo.

echo Testing python-docx...
python -c "import docx; print('✅ python-docx version:', docx.__version__)" 2>nul
if errorlevel 1 (
    echo ❌ python-docx test failed
) else (
    echo ✅ python-docx working
)

echo Testing mammoth...
python -c "import mammoth; print('✅ mammoth available')" 2>nul
if errorlevel 1 (
    echo ❌ mammoth test failed
) else (
    echo ✅ mammoth working
)

echo Testing lxml...
python -c "import lxml; print('✅ lxml available')" 2>nul
if errorlevel 1 (
    echo ❌ lxml test failed
) else (
    echo ✅ lxml working
)

echo Testing python-pptx...
python -c "import pptx; print('✅ python-pptx available')" 2>nul
if errorlevel 1 (
    echo ❌ python-pptx test failed
) else (
    echo ✅ python-pptx working
)

echo Testing openpyxl...
python -c "import openpyxl; print('✅ openpyxl available')" 2>nul
if errorlevel 1 (
    echo ❌ openpyxl test failed
) else (
    echo ✅ openpyxl working
)

echo Testing pandas...
python -c "import pandas; print('✅ pandas version:', pandas.__version__)" 2>nul
if errorlevel 1 (
    echo ❌ pandas test failed
) else (
    echo ✅ pandas working
)

echo Testing PyMuPDF...
python -c "import fitz; print('✅ PyMuPDF available')" 2>nul
if errorlevel 1 (
    echo ❌ PyMuPDF test failed
) else (
    echo ✅ PyMuPDF working
)

echo Testing beautifulsoup4...
python -c "import bs4; print('✅ beautifulsoup4 available')" 2>nul
if errorlevel 1 (
    echo ❌ beautifulsoup4 test failed
) else (
    echo ✅ beautifulsoup4 working
)

echo.
echo ========================================
echo INSTALLATION COMPLETE!
echo ========================================
echo.
echo All Office document dependencies installed.
echo You can now run "C O M P I L E .bat" to rebuild
echo the executable with full Office support.
echo.
echo The following formats will be supported:
echo - ✅ DOCX (Word documents)
echo - ✅ PPTX (PowerPoint presentations)  
echo - ✅ XLSX (Excel spreadsheets)
echo - ✅ PDF with image extraction
echo - ✅ HTML and web content
echo.
pause
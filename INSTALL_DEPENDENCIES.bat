@echo off
echo ========================================
echo MarkItDown PyInstaller Setup
echo ========================================
echo.

echo [1/4] Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.10+ from https://python.org
    echo Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)
python --version

echo.
echo [2/4] Upgrading pip...
python -m pip install --upgrade pip

echo.
echo [3/4] Installing PyInstaller and build dependencies...
python -m pip install pyinstaller>=6.0
python -m pip install setuptools wheel

echo.
echo [4/4] Installing MarkItDown with ALL optional dependencies...
echo This may take several minutes...
python -m pip install -e "packages/markitdown[all]"

echo.
echo ========================================
echo Installation Complete!
echo ========================================
echo.
echo You can now run COMPILE.bat to build the executable
echo.
pause
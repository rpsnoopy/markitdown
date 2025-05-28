# MarkItDown Windows Build Instructions

This directory contains Windows batch files to easily build a standalone MarkItDown executable.

## 🚀 Quick Start

### Step 1: Install Dependencies
Double-click `INSTALL_DEPENDENCIES.bat` or run in command prompt:
```cmd
INSTALL_DEPENDENCIES.bat
```

This will:
- Check Python installation (Python 3.10+ required)
- Install PyInstaller and build tools
- Install MarkItDown with ALL optional dependencies

### Step 1.5: Install FFmpeg (Optional but Recommended)
For **complete audio support**, install FFmpeg:
```cmd
INSTALL_FFMPEG.bat
```

This will:
- Download FFmpeg binaries (~50MB)
- Enable ALL audio formats (MP3, M4A, FLAC, etc.)
- Provide high-quality audio transcription
- Eliminate any audio-related warnings

**Without FFmpeg**: Basic audio support (WAV files only)
**With FFmpeg**: Complete audio support (all formats)

### Step 2: Compile Executable
Double-click `COMPILE.bat` or run in command prompt:
```cmd
COMPILE.bat
```

This will:
- Create a single `markitdown.exe` file in `dist/` folder
- Include ALL file format converters
- Take 5-15 minutes to complete

### Step 3: Test Executable (Optional)
Double-click `TEST_EXECUTABLE.bat` or run:
```cmd
TEST_EXECUTABLE.bat
```

This will verify the executable works correctly.

## 📁 Files Created

After successful compilation:
- `dist/markitdown.exe` - Your standalone executable (150-300 MB)
- `build/` - Temporary build files (can be deleted)

## 🎯 What You Get

A single `markitdown.exe` file that supports:

### Document Formats
- ✅ PDF files (.pdf)
- ✅ Microsoft Word (.docx) 
- ✅ Microsoft Excel (.xlsx, .xls)
- ✅ Microsoft PowerPoint (.pptx)
- ✅ Outlook messages (.msg)
- ✅ EPUB ebooks (.epub)

### Web & Data
- ✅ HTML pages (.html)
- ✅ CSV data (.csv)
- ✅ JSON files (.json)
- ✅ XML files (.xml)
- ✅ Jupyter notebooks (.ipynb)
- ✅ RSS feeds
- ✅ Wikipedia URLs
- ✅ YouTube URLs (transcripts)

### Media Files
- ✅ Images (.jpg, .png, .gif, etc.)
- ✅ Audio files (.wav, .mp3, etc.) with transcription
- ✅ ZIP archives (processes contents)

### Cloud Services
- ✅ Azure Document Intelligence integration

## 💻 Usage Examples

```cmd
# Convert PDF to Markdown
dist\markitdown.exe document.pdf > output.md

# Convert with output file
dist\markitdown.exe presentation.pptx -o presentation.md

# Show help
dist\markitdown.exe --help

# Show version
dist\markitdown.exe --version

# Process from stdin
type document.txt | dist\markitdown.exe
```

## 🔧 Requirements

- **Windows 10/11**
- **Python 3.10 or higher** installed and in PATH
  - Download from: https://python.org
  - ⚠️ **Important**: Check "Add Python to PATH" during installation
- **Internet connection** for downloading dependencies
- **~2-5 GB free disk space** for build process

## 🛠️ Troubleshooting

### "Python is not installed or not in PATH"
1. Install Python from https://python.org
2. During installation, check "Add Python to PATH"
3. Restart command prompt and try again

### "MarkItDown is not installed"
1. Run `INSTALL_DEPENDENCIES.bat` first
2. Wait for it to complete successfully
3. Then run `COMPILE.bat`

### Build fails with import errors
1. Delete `build/` and `dist/` folders
2. Run `INSTALL_DEPENDENCIES.bat` again
3. Run `COMPILE.bat` again

### Executable is very large (300+ MB)
This is normal - the executable includes:
- Python runtime
- All MarkItDown dependencies
- ML models for file detection
- Office document processing libraries
- Audio/video processing tools

### Antivirus blocks the executable
1. This is a false positive (common with PyInstaller)
2. Add `dist/markitdown.exe` to antivirus exceptions
3. Or temporarily disable real-time protection during build

## 📤 Distribution

The final `dist/markitdown.exe` can be:
- ✅ Copied to any Windows computer
- ✅ Run without Python installation
- ✅ Distributed to users via email/USB/network
- ✅ Used in automated scripts and workflows

## 🕒 Build Time Expectations

| Step | Time |
|------|------|
| Install Dependencies | 2-5 minutes |
| PyInstaller Compilation | 5-15 minutes |
| Testing | 1 minute |
| **Total** | **8-21 minutes** |

## ✨ Success!

Once complete, you'll have a portable `markitdown.exe` that converts virtually any document format to Markdown without requiring Python or any dependencies on the target machine!
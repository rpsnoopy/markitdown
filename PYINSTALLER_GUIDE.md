# MarkItDown PyInstaller Distribution Guide

This guide provides everything needed to create a standalone executable of MarkItDown that includes **all possible file format converters** and works without requiring Python installation.

## 🎯 What This Creates

A single executable (or directory) that can convert **all supported file formats**:

### 📄 Document Formats
- **PDF** files (.pdf)
- **Microsoft Word** documents (.docx)
- **Microsoft Excel** spreadsheets (.xlsx, .xls)
- **Microsoft PowerPoint** presentations (.pptx)
- **Outlook** email messages (.msg)
- **EPUB** ebooks (.epub)

### 🌐 Web & Data Formats
- **HTML** web pages and files
- **CSV** data files
- **JSON** data files
- **XML** files
- **RSS/Atom** feeds
- **Wikipedia** pages (URLs)
- **YouTube** videos (transcript extraction)
- **Jupyter** notebooks (.ipynb)

### 🖼️ Media Formats
- **Images** (.jpg, .png, .gif, .bmp, .tiff)
  - EXIF metadata extraction
  - OCR text extraction (with LLM)
- **Audio** files (.wav, .mp3, .m4a, .flac)
  - Speech transcription

### 📦 Archive Formats
- **ZIP** files (processes all contents)

### ☁️ Cloud Services
- **Azure Document Intelligence** integration

## 🚀 Quick Start

### 1. Prerequisites

- Python 3.10 or higher
- Git (to clone the repository)

### 2. Setup

```bash
# Clone the repository
git clone https://github.com/microsoft/markitdown.git
cd markitdown

# Install build dependencies
pip install -r build_requirements.txt

# Install MarkItDown with ALL optional dependencies
pip install -e 'packages/markitdown[all]'
```

### 3. Build the Executable

```bash
# Simple build (creates dist/markitdown/ directory)
python build_markitdown.py

# OR single file build (creates one large executable)
python build_markitdown.py --onefile

# OR clean build (removes previous builds first)
python build_markitdown.py --clean
```

### 4. Test the Build

```bash
# Automatic testing
python test_build.py

# Manual test
./dist/markitdown/markitdown --version
```

### 5. Use the Executable

```bash
# Convert a PDF to Markdown
./dist/markitdown/markitdown document.pdf > output.md

# Convert with output file
./dist/markitdown/markitdown presentation.pptx -o presentation.md

# Process from stdin
cat spreadsheet.xlsx | ./dist/markitdown/markitdown > data.md
```

## 📋 Detailed Instructions

### Build Options

| Command | Description | Output |
|---------|-------------|--------|
| `python build_markitdown.py` | Standard build | `dist/markitdown/` directory |
| `python build_markitdown.py --onefile` | Single executable | `dist/markitdown.exe` (or `markitdown`) |
| `python build_markitdown.py --clean` | Clean previous builds | Removes `build/` and `dist/` |
| `python build_markitdown.py --debug` | Debug build | Includes debug information |
| `python build_markitdown.py --upx` | Compressed build | Smaller file size (requires UPX) |

### Understanding the Output

#### Directory Distribution (`dist/markitdown/`)
- **Pros**: Faster startup, smaller total size
- **Cons**: Multiple files to distribute
- **Best for**: Local use, faster execution

#### Single File Distribution (`dist/markitdown.exe`)
- **Pros**: Single file to distribute, fully portable
- **Cons**: Larger file size, slower startup
- **Best for**: Distribution, portability

### File Size Expectations

| Build Type | Approximate Size |
|------------|------------------|
| Directory distribution | 150-250 MB |
| Single file | 200-350 MB |
| With UPX compression | 100-200 MB |

## 🔧 Advanced Configuration

### External Tools (Optional)

#### ExifTool (for advanced image metadata)

**Windows:**
1. Download from https://exiftool.org/
2. Extract to `C:\Program Files\exiftool\`
3. Add to PATH or place in project directory

**macOS:**
```bash
brew install exiftool
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install exiftool

# RHEL/CentOS/Fedora
sudo yum install perl-Image-ExifTool
```

#### UPX (for compression)

**Windows:** Download from https://upx.github.io/
**macOS:** `brew install upx`
**Linux:** `sudo apt-get install upx`

### Custom Builds

You can modify `markitdown.spec` to:

- **Add/remove dependencies**: Edit `hiddenimports` list
- **Include custom files**: Add to `datas` list
- **Change executable options**: Modify `EXE()` parameters
- **Add custom hooks**: Create files in `hooks/` directory

## 🧪 Testing Your Build

### Automatic Testing

```bash
# Test all file format conversions
python test_build.py

# Verbose testing with output previews
python test_build.py --verbose

# Auto-find executable and test
python test_build.py --find-exe
```

### Manual Testing

```bash
# Basic functionality
./dist/markitdown/markitdown --version
./dist/markitdown/markitdown --help
./dist/markitdown/markitdown --list-plugins

# Test specific formats
echo "Hello World" | ./dist/markitdown/markitdown
./dist/markitdown/markitdown test.html
./dist/markitdown/markitdown data.csv
```

## 🚢 Distribution

### Packaging for Distribution

```bash
# Create a zip archive (cross-platform)
zip -r markitdown-standalone.zip dist/markitdown/

# Create a tar.gz archive (Linux/macOS)
tar -czf markitdown-standalone.tar.gz -C dist markitdown/

# For single file builds, just distribute the executable
cp dist/markitdown.exe /path/to/distribution/
```

### Platform-Specific Notes

#### Windows
- Executable: `markitdown.exe`
- May trigger Windows Defender (false positive)
- Can be code-signed for enterprise distribution
- Works on Windows 10/11 without Python

#### macOS
- Executable: `markitdown` (Unix binary)
- May need "Allow from unidentified developer" in Security settings
- Can be notarized for distribution through App Store
- Works on macOS 10.15+ without Python

#### Linux
- Executable: `markitdown` (ELF binary)
- Make executable: `chmod +x markitdown`
- May need additional system libraries
- Works on most modern Linux distributions

## 🛠️ Troubleshooting

### Common Issues

#### "Module not found" errors
```bash
# Ensure all dependencies are installed
pip install -r build_requirements.txt
pip install -e 'packages/markitdown[all]'

# Rebuild with clean flag
python build_markitdown.py --clean
```

#### Large executable size
```bash
# Use UPX compression
python build_markitdown.py --upx

# Use directory distribution instead of --onefile
python build_markitdown.py
```

#### Slow startup
```bash
# Use directory distribution (faster startup)
python build_markitdown.py

# Avoid debug builds for production
python build_markitdown.py  # (no --debug flag)
```

#### Missing file format support
```bash
# Verify all optional dependencies are installed
pip install 'markitdown[all]'

# Check build output for missing dependencies
python build_markitdown.py --debug
```

#### ExifTool not found
```bash
# Install exiftool system-wide or place in project directory
# The build script will automatically detect and include it
```

### Debug Build

For troubleshooting, create a debug build:

```bash
python build_markitdown.py --debug --clean
```

This includes:
- Verbose logging
- Debug symbols
- Detailed error messages
- Import tracing

### Getting Help

1. **Check the build output** for warnings and errors
2. **Run the test script** to identify specific issues: `python test_build.py --verbose`
3. **Create a debug build** for detailed error information
4. **Check system requirements** (Python version, dependencies)
5. **Verify external tools** (exiftool, etc.) if using advanced features

## 📁 Project Structure

After running the build, your directory will look like:

```
markitdown/
├── build_markitdown.py          # Build script
├── markitdown.spec              # PyInstaller configuration
├── build_requirements.txt       # Build dependencies
├── test_build.py                # Test script
├── hooks/                       # PyInstaller hooks
│   ├── hook-magika.py
│   ├── hook-azure.py
│   ├── hook-speech_recognition.py
│   ├── hook-pydub.py
│   └── hook-markitdown.py
├── build/                       # Build artifacts (created)
├── dist/                        # Final executables (created)
│   └── markitdown/              # Directory distribution
│       ├── markitdown           # Main executable
│       └── ... (dependencies)
└── packages/markitdown/         # Source code
```

## 🎉 Success!

Once built successfully, you'll have a standalone MarkItDown executable that:

- ✅ **Supports all file formats** without additional dependencies
- ✅ **Works without Python** installation
- ✅ **Includes all optional features** (PDF, Office docs, images, audio, etc.)
- ✅ **Can be distributed** as a single package
- ✅ **Maintains full CLI compatibility** with the original MarkItDown

The executable can be used exactly like the regular MarkItDown CLI, but without requiring users to install Python or any dependencies!

---

## 📚 Additional Resources

- **MarkItDown Documentation**: https://github.com/microsoft/markitdown
- **PyInstaller Documentation**: https://pyinstaller.org/
- **ExifTool**: https://exiftool.org/
- **UPX Compressor**: https://upx.github.io/

For issues specific to the PyInstaller build, check the generated `README_PYINSTALLER.md` for additional technical details.
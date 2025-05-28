# MarkItDown Standalone Distribution

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PyInstaller](https://img.shields.io/badge/PyInstaller-6.0+-blue.svg)](https://pyinstaller.org/)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![Python](https://img.shields.io/badge/Python-3.10+-green.svg)](https://python.org)

> **This is an enhanced distribution of the original MarkItDown project that creates standalone executables with complete file format support.**

## 🎯 Overview

This project extends Microsoft's [MarkItDown](https://github.com/microsoft/markitdown) utility by providing a complete **PyInstaller-based distribution system** that creates standalone executables. The resulting executable includes **all optional dependencies** and supports **every file format** without requiring Python installation on target machines.

### 🔄 Relationship to Original MarkItDown

- **Base**: Built on Microsoft's MarkItDown 0.1.2a1
- **Enhancement**: Adds PyInstaller compilation with complete dependency management
- **Compatibility**: 100% compatible with original MarkItDown CLI interface
- **Extension**: Includes advanced audio support with optional FFmpeg integration

## 🌟 Key Features

### 🖼️ **NEW: Image Extraction for OpenAI**
- **Page-by-page image extraction** from PDF, PowerPoint, Word, Excel
- **Configurable resolution** up to 2000px for longest side
- **PNG format optimization** for OpenAI attachment
- **Batch processing** with automated scripts
- **Perfect for** document analysis with both text and visual content

### 🚀 **NEW: Enhanced Structured Processing**
- **Standardized directory structure** with predictable file naming
- **Comprehensive JSON output** with detailed processing metadata
- **Specific exit codes** for automation and error handling
- **Image analysis reports** with detailed extraction statistics
- **Direct executable usage** without batch file dependencies
- **Strict API compatibility** for enterprise automation workflows

### 📄 Complete Document Format Support

#### Office Documents
- **PDF** files (`.pdf`) - Advanced text extraction with layout preservation
- **Microsoft Word** documents (`.docx`) - Full formatting and style preservation  
- **Microsoft Excel** spreadsheets (`.xlsx`, `.xls`) - Table data with formula support
- **Microsoft PowerPoint** presentations (`.pptx`) - Slide content and speaker notes
- **Outlook** email messages (`.msg`) - Email content, attachments, and metadata
- **EPUB** ebooks (`.epub`) - Chapter structure and content extraction

#### Web & Data Formats
- **HTML** pages and files - Clean markup conversion with link preservation
- **CSV** data files - Automatic table formatting
- **JSON** structured data - Hierarchical data representation
- **XML** documents - Structure-aware parsing
- **RSS/Atom** feeds - Article content extraction
- **Jupyter** notebooks (`.ipynb`) - Code cells, markdown, and output preservation

#### Media & Rich Content
- **Images** (`.jpg`, `.png`, `.gif`, `.bmp`, `.tiff`, `.webp`)
  - EXIF metadata extraction (with ExifTool)
  - OCR text extraction (with LLM integration)
  - Image description generation (AI-powered)
- **Audio** files (`.wav`, `.mp3`, `.m4a`, `.flac`, `.ogg`, `.aac`)
  - Speech-to-text transcription
  - Metadata extraction
  - Multi-format support with FFmpeg

#### Web Content & APIs
- **Wikipedia** pages - Article content with proper formatting
- **YouTube** videos - Transcript extraction and video metadata
- **Web pages** - Any HTTP/HTTPS URL content
- **Bing SERP** results - Search result parsing

#### Archive & Container Formats
- **ZIP** archives - Recursive processing of all contained files
- **Email** containers - Multiple message processing

#### Cloud & Enterprise Services
- **Azure Document Intelligence** - Cloud-based OCR and document analysis
- **Custom plugins** - Extensible architecture for third-party converters

## 🚀 Quick Start

### Prerequisites

- **Windows 10/11** (64-bit)
- **Python 3.10 or higher** ([Download](https://python.org))
  - ⚠️ **Important**: Check "Add Python to PATH" during installation
- **2-5 GB** free disk space for build process
- **Internet connection** for downloading dependencies

### Build Process

#### Step 1: Install Core Dependencies
```cmd
INSTALL_DEPENDENCIES.bat
```

This installs:
- PyInstaller 6.0+
- MarkItDown with all optional dependencies
- Build tools and requirements

#### Step 2: Install FFmpeg (Recommended)
```cmd
INSTALL_FFMPEG.bat
```

This enables:
- Complete audio format support (MP3, M4A, FLAC, etc.)
- High-quality audio transcription
- Advanced audio processing capabilities
- No warning messages

**Skip this step for**: Smaller executable size or if audio support is not needed.

#### Step 3: Compile Executable
```cmd
COMPILE.bat
```

Creates: `dist/markitdown.exe` - A standalone executable with all features

#### Step 4: Test (Optional)
```cmd
TEST_EXECUTABLE.bat
```

Validates: All file format converters work correctly

## 📦 Distribution Options

### Option A: Complete Distribution (Recommended)
```cmd
INSTALL_DEPENDENCIES.bat
INSTALL_FFMPEG.bat
COMPILE.bat
```

**Result**: `markitdown.exe` (250-350 MB)
- ✅ **Complete audio support** (all formats)
- ✅ **No warnings or limitations**
- ✅ **Professional-grade functionality**

### Option B: Lite Distribution
```cmd
INSTALL_DEPENDENCIES.bat
COMPILE.bat
```

**Result**: `markitdown.exe` (200-300 MB)
- ⚠️ **Basic audio support** (WAV only)
- ✅ **Smaller file size**
- ✅ **All other formats fully supported**

## 💻 Usage

The standalone executable works identically to the original MarkItDown:

### Basic Conversion
```cmd
# Convert any document to Markdown
markitdown.exe document.pdf > output.md
markitdown.exe presentation.pptx -o slides.md
markitdown.exe spreadsheet.xlsx

# Process from stdin
type document.txt | markitdown.exe
```

### 🖼️ New: Image Extraction for OpenAI
```cmd
# Extract page images for OpenAI attachment (PNG format, up to 2000px)
EXTRACT_IMAGES.bat document.pdf
EXTRACT_IMAGES.bat presentation.pptx slides 1500
python image_extractor.py spreadsheet.xlsx --output-dir sheets --max-size 2000

# Convert to both Markdown AND extract images in one command
MARKITDOWN_PLUS.bat document.pdf
MARKITDOWN_PLUS.bat report.docx report.md report_pages
```

### 🚀 **NEW: Enhanced Structured Processing**
```cmd
# Direct executable usage with structured output
dist\markitdown_enhanced.exe document.pdf
# Creates: document/document.txt + document/document_images_analysis.txt + document/page_images/document_page_N.png

# JSON output for automation (strictly compatible format)
dist\markitdown_enhanced.exe report.docx --json-output --quiet
# Returns JSON with detailed status and standardized exit codes

# Batch wrapper (optional)
PROCESS_DOCUMENT.bat document.pdf --json --quiet

# Exit codes: 0=success, 10=text only, 11=images only, 12=both, 13=partial, 1-4=errors
```

#### **Enhanced Output Structure**
For any processed document, creates a standardized directory structure:
```
source_document.pdf →
  source_document/
  ├── source_document.txt              (extracted text content)
  ├── source_document_images_analysis.txt  (image processing report)
  └── page_images/
      ├── source_document_page_1.png   (max 2000px, optimized PNG)
      ├── source_document_page_2.png
      └── source_document_page_N.png
```

#### **JSON Output Format**
Strictly compatible with automation standards:
```json
{
  "status": "success|partial|error",
  "exit_code": 12,
  "pages_processed": 15,
  "text_extracted": true,
  "images_count": 8,
  "ocr_performed": true,
  "heuristic_applied": true,
  "output_files": {
    "processed": "/path/to/output.txt",
    "images_analysis": "/path/to/images_analysis.txt",
    "page_images_folder": "/path/to/page_images/"
  },
  "processing_time": 12.5,
  "errors": []
}
```

#### **Exit Code Reference**
| Code | Status | Description |
|------|--------|-------------|
| **0** | Complete success | All processing completed successfully |
| **10** | Text only | Text extracted, image processing failed |
| **11** | Images only | Images extracted, text processing failed |
| **12** | Text and images | Both text and images extracted successfully |
| **13** | Partial success | Completed with recoverable warnings |
| **1** | File error | File not found, permissions, or format issues |
| **2** | Document corrupted | PDF or document appears corrupted/unreadable |
| **3** | Timeout/interruption | Processing interrupted by user or timeout |
| **4** | Configuration error | Invalid parameters or missing dependencies |

### Advanced Options
```cmd
# Specify output file
markitdown.exe input.docx -o output.md

# Provide file type hints
markitdown.exe data.bin -x .pdf -m application/pdf

# Use Azure Document Intelligence
markitdown.exe document.pdf -d -e "https://your-endpoint.cognitiveservices.azure.com/"

# Enable plugins
markitdown.exe --use-plugins document.pdf

# List available plugins
markitdown.exe --list-plugins

# Keep data URIs in output
markitdown.exe image.html --keep-data-uris
```

### Command Line Reference
```
markitdown.exe [OPTIONS] [FILENAME]

OPTIONS:
  -o, --output FILE          Save output to file instead of stdout
  -x, --extension EXT        File extension hint (e.g., .pdf)
  -m, --mime-type TYPE       MIME type hint (e.g., application/pdf)
  -c, --charset CHARSET      Character encoding hint (e.g., utf-8)
  -d, --use-docintel         Use Azure Document Intelligence
  -e, --endpoint URL         Document Intelligence endpoint
  -p, --use-plugins          Enable third-party plugins
  --list-plugins             Show installed plugins
  --keep-data-uris          Preserve data URIs in output
  -v, --version             Show version information
  -h, --help                Show help message
```

## 🔧 Advanced Configuration

### External Tools Integration

#### ExifTool (Optional)
For advanced image metadata extraction:

**Automatic Detection**: The build process automatically detects ExifTool in:
- System PATH
- `/usr/bin/exiftool`
- `/usr/local/bin/exiftool`
- `C:\Program Files\exiftool.exe`

**Manual Installation**:
1. Download from [exiftool.org](https://exiftool.org/)
2. Extract to system directory or project folder
3. Rebuild executable to include

#### FFmpeg Configuration
FFmpeg provides advanced audio processing capabilities:

**Supported Formats with FFmpeg**:
- MP3, M4A, FLAC, OGG, AAC, WMA
- Advanced codec support
- High-quality transcription
- Metadata preservation

**Without FFmpeg**:
- WAV files only
- Basic transcription
- Limited audio metadata

### Azure Document Intelligence

For cloud-based document processing:

```cmd
# Set up Azure credentials
set AZURE_CLIENT_ID=your-client-id
set AZURE_CLIENT_SECRET=your-client-secret
set AZURE_TENANT_ID=your-tenant-id

# Use with endpoint
markitdown.exe document.pdf -d -e "https://your-endpoint.cognitiveservices.azure.com/"
```

### Plugin System

MarkItDown supports third-party plugins for custom file types:

```cmd
# Install a plugin
pip install markitdown-plugin-example

# Enable plugins during conversion
markitdown.exe --use-plugins custom-file.xyz

# List installed plugins
markitdown.exe --list-plugins
```

## 🧪 Testing & Validation

### Comprehensive Test Suite
```cmd
# Generate basic test files automatically
CREATE_TEST_FILES.bat

# Run complete test suite (after adding manual files)
TEST_SUITE.bat

# Basic executable testing (legacy)
TEST_EXECUTABLE.bat
```

### Test File Requirements
For complete testing, add these files to `test_files/` directory:

#### **Essential Files (High Priority)**
- **`test.pdf`** - Any PDF document (2-5 pages ideal)
- **`test.docx`** - Word document with formatting and tables
- **`test.xlsx`** - Excel spreadsheet with multiple worksheets
- **`test.pptx`** - PowerPoint presentation (3-5 slides)
- **`photo.jpg`** - JPEG image with clear content

#### **Additional Files (Medium Priority)**
- **`image.gif`** - GIF image file
- **`bitmap.bmp`** - BMP image file  
- **`email.msg`** - Outlook message file
- **`book.epub`** - EPUB ebook file
- **`audio.mp3`** - Audio file for transcription testing

#### **Automatic Test Files**
The `CREATE_TEST_FILES.bat` script automatically generates:
- Text files (UTF-8, special characters)
- HTML files (simple and complex)
- CSV data files
- JSON configuration files
- XML documents
- Jupyter notebooks
- Test images

### Test Coverage
The test suite validates:
- ✅ **All file format conversions** with proper exit codes
- ✅ **JSON output compliance** with API specifications
- ✅ **Directory structure validation** for enhanced processing
- ✅ **Image extraction** for supported formats
- ✅ **Error handling** and edge cases
- ✅ **Compatibility** with original MarkItDown

### Test Results
Results are saved in `test_results/` with:
- Individual processing results (JSON format)
- Structure validation reports
- Performance metrics
- Detailed error logs

For detailed test instructions, see: [`TEST_FILES_INSTRUCTIONS.md`](TEST_FILES_INSTRUCTIONS.md)

### Performance Benchmarks

| File Type | Size | Conversion Time* | Memory Usage* |
|-----------|------|------------------|---------------|
| PDF (10 pages) | 2 MB | 3-8 seconds | 150-300 MB |
| DOCX (complex) | 5 MB | 2-5 seconds | 100-200 MB |
| XLSX (1000 rows) | 1 MB | 1-3 seconds | 80-150 MB |
| PPTX (50 slides) | 10 MB | 5-12 seconds | 200-400 MB |
| Audio (5 minutes) | 5 MB | 30-120 seconds | 200-500 MB |

*Performance varies by system specifications and content complexity

## 📁 Project Structure

```
markitdown/
├── 📁 packages/markitdown/          # Original MarkItDown source
├── 📄 INSTALL_DEPENDENCIES.bat     # Install Python dependencies
├── 📄 INSTALL_FFMPEG.bat          # Install FFmpeg binaries
├── 📄 COMPILE.bat                  # Build standalone executable
├── 📄 TEST_EXECUTABLE.bat         # Validate build
├── 📄 markitdown.spec              # PyInstaller configuration
├── 📄 markitdown_entry.py          # Custom entry point
├── 📄 build_requirements.txt       # Build dependencies list
├── 📁 hooks/                       # PyInstaller hooks
│   ├── hook-magika.py              # ML model inclusion
│   ├── hook-azure.py               # Azure SDK support
│   ├── hook-speech_recognition.py  # Audio processing
│   ├── hook-pydub.py               # Audio libraries
│   └── hook-markitdown.py          # Core module support
├── 📁 runtime_hooks/               # Runtime configuration
│   └── rthook_suppress_warnings.py # Warning suppression
├── 📁 ffmpeg/ (after install)      # FFmpeg binaries
│   ├── ffmpeg.exe                  # Audio converter
│   └── ffprobe.exe                 # Media analyzer
├── 📁 build/ (created)             # Build artifacts
├── 📁 dist/ (created)              # Final executable
│   └── markitdown.exe              # Standalone executable
└── 📄 README.md                    # This file
```

## 🔍 Troubleshooting

### Common Issues

#### "Python is not installed or not in PATH"
**Solution**: 
1. Install Python from [python.org](https://python.org)
2. During installation, check "Add Python to PATH"
3. Restart command prompt

#### "MarkItDown is not installed"
**Solution**:
1. Run `INSTALL_DEPENDENCIES.bat` first
2. Wait for successful completion
3. Then run `COMPILE.bat`

#### Build fails with "ModuleNotFoundError"
**Solution**:
1. Delete `build/` and `dist/` folders
2. Run `INSTALL_DEPENDENCIES.bat` again
3. Ensure all dependencies installed successfully
4. Rebuild with `COMPILE.bat`

#### Executable size very large (>400 MB)
**Causes & Solutions**:
- **Normal**: Base size 200-350 MB includes Python runtime + all libraries
- **With FFmpeg**: Adds ~50-100 MB for complete audio support
- **Optimization**: Use UPX compression (reduces by ~30-50%)

#### Antivirus false positives
**Solution**:
1. Add `dist/markitdown.exe` to antivirus exceptions
2. This is common with PyInstaller executables
3. Consider code signing for distribution

#### Audio conversion warnings/errors
**Without FFmpeg**:
- Limited to WAV format only
- Run `INSTALL_FFMPEG.bat` for complete support

**With FFmpeg**:
- Should handle all audio formats
- Check FFmpeg installation if issues persist

### Debug Mode

For detailed troubleshooting:

```cmd
# Build with debug information
python -m PyInstaller markitdown.spec --debug=all

# Check what's included
python test_build.py --verbose

# Test specific functionality
markitdown.exe --version
markitdown.exe --help
markitdown.exe --list-plugins
```

### Performance Optimization

#### Startup Time
- **Directory distribution**: Faster startup (~2-5 seconds)
- **Single file**: Slower startup (~5-15 seconds)
- **Debug builds**: Significantly slower

#### Memory Usage
- **Typical usage**: 100-300 MB RAM
- **Large files**: May use 500MB-1GB temporarily
- **Audio processing**: Higher memory usage during transcription

#### File Size Reduction
```cmd
# Enable UPX compression
python build_markitdown.py --upx

# Remove debug information
python build_markitdown.py --strip

# Exclude unused dependencies
# Edit markitdown.spec excludes section
```

## 📋 System Requirements

### Build Environment
- **OS**: Windows 10/11 (64-bit)
- **Python**: 3.10, 3.11, 3.12, or 3.13
- **RAM**: 4 GB minimum, 8 GB recommended
- **Storage**: 5 GB free space during build
- **Network**: Internet connection for dependency download

### Runtime Environment (End Users)
- **OS**: Windows 10/11 (64-bit)
- **RAM**: 500 MB minimum, 1 GB recommended  
- **Storage**: 300-500 MB for executable
- **Dependencies**: None (completely standalone)

### Supported Platforms
- **Primary**: Windows 10/11 (x64)
- **Potential**: Linux/macOS with spec file modifications
- **Architecture**: 64-bit only

## 📄 License & Legal

### License Information
This distribution is released under the **MIT License**, consistent with the original MarkItDown project.

### Third-Party Components
This executable includes the following components, each under their respective licenses:

- **MarkItDown**: MIT License (Microsoft Corporation)
- **Python Runtime**: Python Software Foundation License
- **PyInstaller**: GPL v2+ with exception
- **BeautifulSoup4**: MIT License
- **Requests**: Apache 2.0 License
- **Pandas**: BSD 3-Clause License
- **OpenPyXL**: MIT License
- **python-pptx**: MIT License
- **pdfminer.six**: MIT License
- **Pillow**: PIL Software License
- **pydub**: MIT License
- **SpeechRecognition**: BSD 3-Clause License
- **Azure SDK**: MIT License
- **FFmpeg** (if included): LGPL v2.1+

### Usage Rights
- ✅ **Commercial use** permitted
- ✅ **Distribution** permitted
- ✅ **Modification** permitted
- ✅ **Private use** permitted
- ⚠️ **No warranty** provided

### Attribution Requirements
When distributing this executable:
1. Include license information for all components
2. Attribute original MarkItDown project to Microsoft
3. Maintain copyright notices in documentation

### FFmpeg Legal Notice
If FFmpeg is included:
- FFmpeg is licensed under LGPL v2.1+
- Commercial distribution may require compliance with LGPL terms
- Consider legal review for commercial deployment
- Source code availability may be required for LGPL compliance

## 🤝 Contributing

### Reporting Issues
1. **Test first**: Verify issue exists in both original MarkItDown and this distribution
2. **Check documentation**: Review troubleshooting section
3. **Provide details**: Include file types, error messages, system info
4. **Sample files**: Provide problematic files when possible (if not sensitive)

### Enhancement Requests
- **New file formats**: Consider contributing to upstream MarkItDown
- **Build improvements**: PyInstaller configuration enhancements welcome
- **Performance optimizations**: Always appreciated
- **Cross-platform support**: Linux/macOS spec files needed

### Development Setup
```cmd
# Clone repository
git clone https://github.com/microsoft/markitdown.git
cd markitdown

# Install development dependencies
pip install -e "packages/markitdown[all]"
pip install pyinstaller

# Make modifications
# Test changes
python test_build.py

# Build and test
COMPILE.bat
TEST_EXECUTABLE.bat
```

## 🌟 Acknowledgments

- **Microsoft Corporation** - Original MarkItDown project and development team
- **PyInstaller Team** - Excellent Python packaging solution
- **Open Source Community** - All dependency library maintainers
- **Contributors** - Everyone who helped improve this distribution

## 📞 Support

### Documentation
- **This README**: Comprehensive usage and troubleshooting guide
- **Original MarkItDown**: [GitHub Repository](https://github.com/microsoft/markitdown)
- **PyInstaller**: [Official Documentation](https://pyinstaller.org/)

### Community Support
- **Issues**: Report problems via GitHub Issues
- **Discussions**: Join community discussions
- **Updates**: Watch repository for new releases

### Professional Support
For enterprise deployment or commercial support needs, consider:
- Microsoft's official MarkItDown support channels
- Professional Python/PyInstaller consulting services
- Custom integration and deployment services

---

## 🎉 Ready to Convert Everything!

You now have a complete, standalone MarkItDown executable that can convert virtually any document format to Markdown without requiring Python or any dependencies on target machines. 

**Happy converting!** 📝✨
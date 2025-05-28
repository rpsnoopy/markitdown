# Test Files Instructions for MarkItDown Enhanced

This document provides detailed instructions for creating a complete test suite to validate all MarkItDown Enhanced functionality.

## 🚀 Quick Start

1. **Run the automatic test file generator:**
   ```cmd
   CREATE_TEST_FILES.bat
   ```

2. **Add manual test files** (see sections below)

3. **Compile the executables:**
   ```cmd
   COMPILE.bat
   ```

4. **Run the complete test suite:**
   ```cmd
   TEST_SUITE.bat
   ```

## 📁 Test Directory Structure

The test system creates and uses a `test_files/` directory with the following structure:

```
test_files/
├── 📄 Text Files (auto-generated)
│   ├── simple_text.txt
│   └── utf8_text.txt
├── 🌐 Web Files (auto-generated)
│   ├── test_document.html
│   ├── complex_html.html
│   └── data.xml
├── 📊 Data Files (auto-generated)
│   ├── people_data.csv
│   ├── inventory.csv
│   ├── config.json
│   └── test_data.json
├── 📓 Notebook Files (auto-generated)
│   └── test_notebook.ipynb
├── 🖼️ Images (auto-generated)
│   └── test_image.png
└── 📄 Manual Files (ADD THESE)
    ├── test.pdf
    ├── test.docx
    ├── test.xlsx
    ├── test.pptx
    ├── photo.jpg
    ├── image.gif
    └── [other formats...]
```

## 🔧 Auto-Generated Files

The `CREATE_TEST_FILES.bat` script automatically creates these files:

### Text Files
- **`simple_text.txt`** - Basic plain text with multiple paragraphs
- **`utf8_text.txt`** - UTF-8 text with special characters and symbols

### HTML Files
- **`test_document.html`** - Simple HTML with headers, lists, links
- **`complex_html.html`** - Complex HTML with tables, sections, semantic elements

### Data Files
- **`people_data.csv`** - CSV with person data (names, ages, cities)
- **`inventory.csv`** - CSV with product inventory data
- **`config.json`** - JSON configuration file with nested objects
- **`test_data.json`** - JSON test data with arrays and metadata

### Structured Files
- **`data.xml`** - XML document with hierarchical content
- **`test_notebook.ipynb`** - Jupyter notebook with markdown and code cells

### Images
- **`test_image.png`** - Generated PNG image with text content

## 📋 Manual Files Needed

For comprehensive testing, manually add these file types to the `test_files/` directory:

### 📄 Office Documents (HIGH PRIORITY)

#### PDF Files
- **File name**: `test.pdf` or `document.pdf`
- **Content**: Any PDF document with 2-5 pages
- **Ideal features**: 
  - Mixed text and images
  - Tables or structured content
  - Both text and scanned content (if available)
- **Tests**: Text extraction + page image generation

#### Microsoft Word
- **File name**: `test.docx` or `document.docx`
- **Content**: Word document with formatting
- **Ideal features**:
  - Headers and paragraphs
  - Tables and lists
  - Images embedded in text
  - Different font styles
- **Tests**: Text extraction + page rendering

#### Microsoft Excel
- **File name**: `test.xlsx` or `spreadsheet.xlsx`
- **Content**: Excel workbook with data
- **Ideal features**:
  - Multiple worksheets
  - Charts and graphs
  - Formulas and calculations
  - Mixed data types
- **Tests**: Data extraction + worksheet images

#### Microsoft PowerPoint
- **File name**: `test.pptx` or `presentation.pptx`
- **Content**: PowerPoint presentation
- **Ideal features**:
  - 3-5 slides minimum
  - Text content and bullet points
  - Images and graphics
  - Slide transitions/animations
- **Tests**: Content extraction + slide images

### 🖼️ Image Files (MEDIUM PRIORITY)

#### JPEG Images
- **File name**: `photo.jpg` or `image.jpg`
- **Content**: Any JPEG photograph or image
- **Ideal features**:
  - High resolution (1000px+ recommended)
  - Clear text content if available
  - EXIF metadata present
- **Tests**: EXIF extraction + OCR capabilities

#### GIF Images
- **File name**: `animation.gif` or `image.gif`
- **Content**: Any GIF file (static or animated)
- **Tests**: Image processing + metadata extraction

#### BMP Images
- **File name**: `bitmap.bmp`
- **Content**: Any bitmap image
- **Tests**: Image conversion and processing

#### Additional Images
- **TIFF files**: `image.tiff` - For advanced image format testing
- **WebP files**: `image.webp` - For modern image format testing

### 📧 Email & Communication (LOW PRIORITY)

#### Outlook Messages
- **File name**: `email.msg` or `message.msg`
- **Content**: Any Outlook email message file
- **Ideal features**:
  - Text and HTML content
  - Attachments (if any)
  - Email headers and metadata
- **Tests**: Email content extraction + metadata

### 📚 eBooks & Documents (LOW PRIORITY)

#### EPUB Files
- **File name**: `book.epub` or `document.epub`
- **Content**: Any EPUB ebook file
- **Ideal features**:
  - Multiple chapters
  - Table of contents
  - Images and formatting
- **Tests**: Chapter extraction + content structure

### 🎵 Audio Files (LOW PRIORITY)

#### Audio for Transcription
- **File names**: `audio.mp3`, `speech.wav`, `recording.m4a`
- **Content**: Audio files with clear speech
- **Ideal features**:
  - Clear speech content (English preferred)
  - 30 seconds to 2 minutes duration
  - Good audio quality
- **Tests**: Speech transcription + metadata extraction
- **Note**: Requires FFmpeg for full functionality

### 🗄️ Archive Files (LOW PRIORITY)

#### ZIP Archives
- **File name**: `archive.zip`
- **Content**: ZIP file containing various document types
- **Ideal features**:
  - Mix of text, PDF, and image files
  - Nested directory structure
- **Tests**: Recursive processing of archive contents

## 🧪 Test Coverage Matrix

| File Type | Auto-Generated | Manual Required | Text Extraction | Image Extraction | Special Features |
|-----------|----------------|-----------------|-----------------|------------------|------------------|
| **TXT** | ✅ | ❌ | ✅ | ❌ | UTF-8 support |
| **HTML** | ✅ | ❌ | ✅ | ❌ | Link preservation |
| **CSV** | ✅ | ❌ | ✅ | ❌ | Table formatting |
| **JSON** | ✅ | ❌ | ✅ | ❌ | Structure parsing |
| **XML** | ✅ | ❌ | ✅ | ❌ | Hierarchy extraction |
| **IPYNB** | ✅ | ❌ | ✅ | ❌ | Code/markdown cells |
| **PNG** | ✅ | ❌ | ⚠️ OCR | ✅ | Generated content |
| **PDF** | ❌ | ⭐ **HIGH** | ✅ | ✅ | Page extraction |
| **DOCX** | ❌ | ⭐ **HIGH** | ✅ | ✅ | Layout rendering |
| **XLSX** | ❌ | ⭐ **HIGH** | ✅ | ✅ | Worksheet images |
| **PPTX** | ❌ | ⭐ **HIGH** | ✅ | ✅ | Slide images |
| **JPG** | ❌ | ⭐ **MEDIUM** | ⚠️ OCR | ✅ | EXIF metadata |
| **GIF** | ❌ | ⭐ **MEDIUM** | ⚠️ OCR | ✅ | Animation handling |
| **MSG** | ❌ | ⚠️ LOW | ✅ | ❌ | Email parsing |
| **EPUB** | ❌ | ⚠️ LOW | ✅ | ❌ | Chapter structure |
| **MP3** | ❌ | ⚠️ LOW | ⚠️ Transcription | ❌ | Audio processing |

**Legend:**
- ✅ **Supported**: Full functionality expected
- ⚠️ **Conditional**: Depends on content/dependencies
- ❌ **Not applicable**: Feature not relevant for format
- ⭐ **Priority**: Importance for comprehensive testing

## 📊 Test Results

After running `TEST_SUITE.bat`, results are saved in `test_results/`:

### Generated Reports
- **`test_summary.txt`** - Overall test results summary
- **`*_result.json`** - Individual file processing results (JSON format)
- **`*_regular.md`** - Regular MarkItDown output for comparison
- **`version_test.txt`** - Version command output
- **`help_test.txt`** - Help command output

### Success Criteria
- **Basic functionality**: All version/help commands pass
- **JSON validation**: All result files contain required fields
- **Structure validation**: All output directories have correct structure
- **Format coverage**: At least 80% of available formats tested successfully
- **Compatibility**: Results consistent with regular MarkItDown where applicable

## 🔧 Troubleshooting

### Common Issues

#### "No files found" warnings
- **Cause**: Missing manual test files
- **Solution**: Add the missing file types to `test_files/`
- **Impact**: Reduced test coverage but not critical

#### JSON validation failures
- **Cause**: Malformed JSON output from processing
- **Solution**: Check individual `*_result.json` files for syntax errors
- **Impact**: Indicates potential issues with enhanced processing

#### Structure validation failures
- **Cause**: Output directories missing expected files
- **Solution**: Check if text/image extraction is working correctly
- **Impact**: Core functionality problems

#### Test execution failures
- **Cause**: Missing executables or dependencies
- **Solution**: Run `COMPILE.bat` first, ensure all dependencies installed
- **Impact**: Cannot perform testing

### Debug Steps
1. **Check compilation**: Ensure `dist/markitdown_enhanced.exe` exists
2. **Verify test files**: Run `CREATE_TEST_FILES.bat` if `test_files/` is empty
3. **Manual testing**: Try individual file processing manually
4. **Check logs**: Review detailed results in `test_results/` directory

## 🎯 Recommended Test Workflow

### Minimal Testing (Quick Validation)
1. Run `CREATE_TEST_FILES.bat`
2. Add one PDF file to `test_files/`
3. Run `TEST_SUITE.bat`
4. Check that basic functionality works

### Standard Testing (Recommended)
1. Run `CREATE_TEST_FILES.bat`
2. Add PDF, DOCX, XLSX, PPTX files to `test_files/`
3. Add one JPG image to `test_files/`
4. Run `TEST_SUITE.bat`
5. Verify >90% tests pass

### Comprehensive Testing (Full Validation)
1. Run `CREATE_TEST_FILES.bat`
2. Add all file types listed in this document
3. Run `TEST_SUITE.bat`
4. Review all results in `test_results/`
5. Compare with regular MarkItDown output
6. Verify JSON compliance and exit codes

### Automated Testing (CI/CD)
```cmd
CREATE_TEST_FILES.bat
REM Add your standard test files here
COMPILE.bat
TEST_SUITE.bat
if %ERRORLEVEL%==0 (
    echo All tests passed
) else (
    echo Tests failed - check test_results/
    exit /b 1
)
```

This comprehensive testing ensures MarkItDown Enhanced works correctly across all supported formats and provides reliable automation capabilities.
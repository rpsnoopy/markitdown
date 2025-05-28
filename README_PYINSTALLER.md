# MarkItDown PyInstaller Distribution

This directory contains files for creating a standalone executable distribution of MarkItDown using PyInstaller. The resulting executable includes all optional dependencies and can handle all supported file formats without requiring a Python installation.

## Quick Start

1. **Install build dependencies:**
   ```bash
   pip install -r build_requirements.txt
   pip install -e 'packages/markitdown[all]'
   ```

2. **Build the executable:**
   ```bash
   python build_markitdown.py
   ```

3. **Find your executable:**
   - Directory distribution: `dist/markitdown/markitdown` (or `markitdown.exe` on Windows)
   - Single file: `dist/markitdown` (or `markitdown.exe` on Windows)

## Supported File Formats

The PyInstaller distribution includes support for all MarkItDown file formats:

### Core Formats (always available)
- **Plain Text**: `.txt`, `.md`, `.rst`
- **HTML**: `.html`, `.htm`
- **CSV**: `.csv`
- **JSON**: `.json`
- **XML**: `.xml`
- **ZIP**: `.zip` (processes contents)
- **Jupyter Notebooks**: `.ipynb`
- **RSS Feeds**: RSS/Atom feeds
- **Web Pages**: Any HTML content
- **YouTube**: YouTube video URLs (transcript extraction)
- **Wikipedia**: Wikipedia page URLs

### Office Documents
- **PDF**: `.pdf` files (via pdfminer.six)
- **Word**: `.docx` files (via mammoth)
- **Excel**: `.xlsx`, `.xls` files (via pandas/openpyxl/xlrd)
- **PowerPoint**: `.pptx` files (via python-pptx)

### Media Files
- **Images**: `.jpg`, `.jpeg`, `.png`, `.gif`, `.bmp`, `.tiff`
  - EXIF metadata extraction (requires exiftool)
  - OCR text extraction (requires LLM client)
- **Audio**: `.wav`, `.mp3`, `.m4a`, `.flac`, `.ogg`
  - Audio transcription (via SpeechRecognition)

### Email & eBooks
- **Outlook Messages**: `.msg` files (via olefile)
- **eBooks**: `.epub` files

### Cloud Services
- **Azure Document Intelligence**: Cloud-based document processing

## Build Options

### Basic Build (Directory Distribution)
```bash
python build_markitdown.py
```
Creates `dist/markitdown/` directory with executable and dependencies.

### Single File Build
```bash
python build_markitdown.py --onefile
```
Creates a single executable file (larger, slower startup).

### Debug Build
```bash
python build_markitdown.py --debug
```
Includes debug information for troubleshooting.

### Clean Build
```bash
python build_markitdown.py --clean
```
Removes previous build artifacts before building.

## Advanced Configuration

### Custom Spec File

The `markitdown.spec` file contains the PyInstaller configuration. You can modify it to:

- Add/remove hidden imports
- Include additional data files
- Change executable options
- Add hooks for specific libraries

### External Dependencies

#### ExifTool (Optional)
For advanced image metadata extraction:

**Windows:**
1. Download from https://exiftool.org/
2. Extract to `C:\Program Files\exiftool\` or add to PATH

**macOS:**
```bash
brew install exiftool
```

**Linux:**
```bash
sudo apt-get install exiftool  # Ubuntu/Debian
sudo yum install perl-Image-ExifTool  # RHEL/CentOS
```

#### UPX (Optional)
For executable compression:

**Windows:** Download from https://upx.github.io/
**macOS:** `brew install upx`
**Linux:** `sudo apt-get install upx`

## Usage Examples

After building, use the executable like the regular MarkItDown CLI:

```bash
# Convert PDF to Markdown
./dist/markitdown/markitdown document.pdf > output.md

# Convert with output file
./dist/markitdown/markitdown presentation.pptx -o presentation.md

# Process from stdin
cat spreadsheet.xlsx | ./dist/markitdown/markitdown > data.md

# Use Azure Document Intelligence
./dist/markitdown/markitdown document.pdf -d -e "https://your-endpoint.cognitiveservices.azure.com/"

# Show version
./dist/markitdown/markitdown --version

# List plugins
./dist/markitdown/markitdown --list-plugins
```

## Troubleshooting

### Common Issues

1. **Import Errors**
   - Ensure all dependencies are installed: `pip install -r build_requirements.txt`
   - Install MarkItDown with all extras: `pip install -e 'packages/markitdown[all]'`

2. **Missing File Support**
   - Check that optional dependencies are installed
   - Some features require external tools (exiftool, etc.)

3. **Large Executable Size**
   - Use `--onefile` for single file (larger but portable)
   - Use directory distribution for smaller total size
   - Enable UPX compression with `--upx`

4. **Slow Startup**
   - Directory distribution starts faster than single file
   - Debug builds are slower

### Debug Mode

For troubleshooting, build with debug mode:

```bash
python build_markitdown.py --debug
```

This includes verbose logging and error details.

### Platform-Specific Notes

**Windows:**
- Executable will be `markitdown.exe`
- May trigger antivirus warnings (false positive)
- Can be signed with code signing certificate

**macOS:**
- May need to allow unsigned executable in Security settings
- Can be notarized for distribution

**Linux:**
- Executable permissions: `chmod +x dist/markitdown/markitdown`
- May need additional system libraries

## Distribution

The built executable can be distributed without Python installation:

1. **Directory Distribution**: Copy entire `dist/markitdown/` folder
2. **Single File**: Distribute the single executable file
3. **Archive**: Create zip/tar.gz of the distribution

### File Size Expectations

- **Directory distribution**: ~100-200 MB
- **Single file**: ~150-300 MB
- **With UPX compression**: ~50-100 MB

## License

The built executable includes MarkItDown and its dependencies, each under their respective licenses. See the individual package licenses for details.
# MarkItDown Enhanced - Repository Structure

This repository is dedicated to the **Enhanced version** of MarkItDown with structured JSON output and image extraction capabilities.

## 🚀 Quick Start

1. **Install Dependencies**: `INSTALL_DEPENDENCIES.bat`
2. **Compile Enhanced Version**: `COMPILE.bat`
3. **Run Tests**: `TEST_SUITE.bat`

## 📁 Key Files

### Core Enhanced Version
- `markitdown_enhanced.py` - Main enhanced script with JSON output
- `markitdown_enhanced.spec` - PyInstaller build specification
- `image_extractor.py` - Image extraction utilities

### Build & Test
- `COMPILE.bat` - Compile enhanced executable
- `TEST_SUITE.bat` - Complete test suite
- `build_requirements.txt` - Build dependencies
- `hooks/` - PyInstaller hooks for dependencies
- `runtime_hooks/` - Runtime optimization hooks

### Installation
- `INSTALL_DEPENDENCIES.bat` - Install Python dependencies
- `INSTALL_OFFICE_DEPENDENCIES.bat` - Install Office format support
- `INSTALL_FFMPEG.bat` - Install FFmpeg for audio support

### Utilities
- `CREATE_TEST_FILES.bat` - Generate test files
- `EXTRACT_IMAGES.bat` - Extract images from documents
- `PROCESS_DOCUMENT.bat` - Process single document
- `MARKITDOWN_PLUS.bat` - Advanced processing script

## 🎯 Enhanced Features

- **Structured JSON output** with detailed metadata
- **Image extraction** with page-by-page PNG export
- **Standardized directory structure** for outputs
- **Comprehensive error handling** with specific exit codes
- **Complete Office format support** (DOCX, PPTX, XLSX)
- **PDF processing** with image extraction
- **Standalone executable** for distribution

## 📦 Base Library

The `packages/markitdown/` directory contains the core MarkItDown library that provides the foundation for the enhanced version.
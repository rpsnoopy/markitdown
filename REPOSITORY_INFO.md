# PDF Processor Integration Suite

## Repository Overview

This repository contains the **PDF Processor Integration Suite**, a comprehensive document processing system built on Microsoft's MarkItDown library with advanced enhancements.

## Repository Migration

This codebase was refactored from a MarkItDown distribution to focus exclusively on advanced document processing capabilities:

- **Original**: General MarkItDown distribution  
- **Current**: PDF Processor Integration Suite
- **Focus**: Advanced PDF processing, structured output, image extraction

## Key Capabilities

### 📄 Document Processing
- **PDF**: Advanced processing with image extraction
- **Office**: Complete DOCX, PPTX, XLSX support  
- **Web**: HTML, CSV, JSON processing
- **Images**: PNG, JPG, GIF analysis

### 🔧 Technical Features
- **Structured JSON output** with comprehensive metadata
- **Page-by-page image extraction** to PNG files
- **Standardized directory structure** for all outputs
- **Comprehensive error handling** with specific exit codes
- **Standalone executable** for easy distribution

### 🏗️ Build System
- **PyInstaller integration** for standalone executables
- **Dependency management** for all Office formats
- **Complete test suite** with automated validation
- **Cross-platform support** (Windows primary)

## Usage

1. **Setup**: Run `INSTALL_DEPENDENCIES.bat`
2. **Build**: Run `COMPILE.bat` 
3. **Test**: Run `TEST_SUITE.bat`
4. **Process**: Use `markitdown_enhanced.exe` with JSON output

## Repository Structure

- `markitdown_enhanced.py` - Main processing script
- `packages/markitdown/` - Core MarkItDown library
- `test_files/` - Comprehensive test document collection
- `hooks/` - PyInstaller build configuration
- Build and installation scripts

This suite provides enterprise-grade document processing capabilities with robust error handling and structured output for integration workflows.
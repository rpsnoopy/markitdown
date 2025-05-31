# PDFPROCESSOR - Feature Development Lab

[![License: Private](https://img.shields.io/badge/License-Private-red.svg)](LICENSE)
[![PyInstaller](https://img.shields.io/badge/PyInstaller-6.0+-blue.svg)](https://pyinstaller.org/)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![Python](https://img.shields.io/badge/Python-3.10+-green.svg)](https://python.org)

> **Private R&D repository for developing new PDFPROCESSOR features. Experimental document processing capabilities using MarkItDown as foundation.**

## 🎯 Project Purpose

This is a **private R&D repository** for developing new features and capabilities for the PDFPROCESSOR product. We use Microsoft's [MarkItDown](https://github.com/microsoft/markitdown) library as a foundation to prototype and test new document processing features.

### 🔬 Research & Development Focus

- **Experimental Features**: New document processing capabilities for PDFPROCESSOR
- **Proof of Concepts**: Testing advanced extraction and conversion methods
- **Integration Testing**: Validating new features before PDFPROCESSOR integration
- **Private Development**: Internal feature development and testing

### 🔄 Technology Foundation

- **Base Library**: Microsoft's MarkItDown 0.1.2a1 (MIT License)
- **Enhancement Target**: PDFPROCESSOR feature expansion
- **Development Stage**: Feature prototyping and testing
- **Future Integration**: Features will be integrated into main PDFPROCESSOR codebase

## 🧪 Experimental Features in Development

### 🖼️ **Advanced Image Extraction**
- **Page-by-page image extraction** from PDF, PowerPoint, Word, Excel
- **Configurable resolution** up to 2000px for longest side
- **PNG format optimization** for AI integration
- **Batch processing** with automated scripts

### 📊 **Structured JSON Output**
- **Comprehensive metadata** extraction and reporting
- **Processing statistics** and error tracking
- **Standardized output format** for PDFPROCESSOR integration
- **Exit code mapping** for automated workflows

### 🔧 **Enhanced Processing Pipeline**
- **Multi-format support** with unified processing interface
- **Error handling** and recovery mechanisms
- **Progress tracking** and detailed logging
- **Standalone executable** for testing and deployment

## 🏗️ Development Workflow

### Current Phase: Feature Prototyping
1. **Experiment** with new processing capabilities using MarkItDown
2. **Test** feature performance and reliability
3. **Document** API interfaces and usage patterns
4. **Validate** integration readiness

### Future Integration Path
1. **Extract** proven features from this R&D environment
2. **Refactor** code for PDFPROCESSOR architecture
3. **Integrate** into main PDFPROCESSOR codebase
4. **Archive** this development repository as subproject

## 🚀 Quick Start

### Development Setup
```cmd
# Install dependencies
INSTALL_DEPENDENCIES.bat

# Build experimental executable
COMPILE.bat

# Run test suite
TEST_SUITE.bat
```

### Testing New Features
```cmd
# Process document with enhanced features
dist\markitdown_enhanced.exe document.pdf --json-output

# Extract images for AI processing
EXTRACT_IMAGES.bat document.pdf

# Advanced processing with structured output
PROCESS_DOCUMENT.bat report.docx --json --quiet
```

## 📁 Key Files

### Core Development
- `markitdown_enhanced.py` - Main experimental processing script
- `markitdown_enhanced.spec` - PyInstaller build configuration
- `image_extractor.py` - Advanced image extraction utilities

### Testing & Validation
- `TEST_SUITE.bat` - Comprehensive feature testing
- `test_files/` - Test document collection
- `test_results/` - Automated test outputs

### Build System
- `COMPILE.bat` - Build experimental executable
- `hooks/` - PyInstaller integration hooks
- `build_requirements.txt` - Development dependencies

## 📄 Licensing & Attribution

### Private Development Project
- **This repository**: Private development project for PDFPROCESSOR
- **Commercial use**: Internal feature development only
- **Distribution**: Not for public distribution

### Third-Party Components
- **MarkItDown Library**: MIT License (Microsoft Corporation)
  - Used as foundation for document processing experiments
  - Original license terms preserved in `packages/markitdown/LICENSE`
  - No modifications to core MarkItDown library licensing

### Future PDFPROCESSOR Integration
- Developed features will be integrated into PDFPROCESSOR codebase
- This R&D repository will become a subdirectory of main PDFPROCESSOR project
- All experimental code remains private and proprietary

## 🔬 Development Status

**Current Version**: Feature Development Phase  
**Target Integration**: PDFPROCESSOR v2.0+  
**Repository Future**: Will be moved to `/research/markitdown-integration/` in main PDFPROCESSOR repository

---

*This is a private R&D project. For questions about PDFPROCESSOR integration, contact the development team.*
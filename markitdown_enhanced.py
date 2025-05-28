#!/usr/bin/env python3
"""
Enhanced MarkItDown with structured output and JSON reporting.

This script processes documents with the following behavior:
1. Creates a subdirectory with the same name as source file (without extension)
2. Extracts text to SOURCE_NAME.txt in that subdirectory
3. Creates page_images/ subdirectory with SOURCE_NAME_page_N.png files
4. Provides detailed JSON output and specific exit codes

Directory structure example:
  prova.pdf -> 
    prova/
      prova.txt (extracted text)
      page_images/
        prova_page_1.png
        prova_page_2.png
        ...

Exit Codes:
- 0: Complete success
- 10: Text only extracted
- 11: Images only extracted  
- 12: Text and images extracted
- 13: Partial success (recoverable errors)
- 1: File error (not found, permissions, format)
- 2: PDF corrupted/unreadable
- 3: Timeout/user interruption
- 4: Configuration/parameter error
"""

import argparse
import json
import os
import sys
import time
import traceback
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
import signal

# Exit codes
EXIT_SUCCESS = 0
EXIT_TEXT_ONLY = 10
EXIT_IMAGES_ONLY = 11
EXIT_TEXT_AND_IMAGES = 12
EXIT_PARTIAL_SUCCESS = 13
EXIT_FILE_ERROR = 1
EXIT_PDF_CORRUPTED = 2
EXIT_TIMEOUT = 3
EXIT_CONFIG_ERROR = 4


class ProcessingResult:
    """Container for processing results and metadata."""
    
    def __init__(self):
        self.status = "success"
        self.exit_code = EXIT_SUCCESS
        self.pages_processed = 0
        self.text_extracted = False
        self.images_count = 0
        self.ocr_performed = False
        self.heuristic_applied = False
        self.output_files = {}
        self.processing_time = 0.0
        self.errors = []
        self.start_time = time.time()
    
    def set_error(self, error_msg: str, exit_code: int):
        """Set error status and message."""
        self.status = "error"
        self.exit_code = exit_code
        self.errors.append(error_msg)
    
    def set_partial(self, warning_msg: str):
        """Set partial success status."""
        self.status = "partial"
        self.exit_code = EXIT_PARTIAL_SUCCESS
        self.errors.append(warning_msg)
    
    def finalize(self):
        """Calculate final status and exit code."""
        self.processing_time = time.time() - self.start_time
        
        if self.status == "error":
            return  # Keep error status
        
        if self.status == "partial":
            return  # Keep partial status
        
        # Determine success type
        if self.text_extracted and self.images_count > 0:
            self.exit_code = EXIT_TEXT_AND_IMAGES
        elif self.text_extracted:
            self.exit_code = EXIT_TEXT_ONLY
        elif self.images_count > 0:
            self.exit_code = EXIT_IMAGES_ONLY
        else:
            self.exit_code = EXIT_SUCCESS
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON output."""
        return {
            "status": self.status,
            "exit_code": self.exit_code,
            "pages_processed": self.pages_processed,
            "text_extracted": self.text_extracted,
            "images_count": self.images_count,
            "ocr_performed": self.ocr_performed,
            "heuristic_applied": self.heuristic_applied,
            "output_files": self.output_files,
            "processing_time": round(self.processing_time, 2),
            "errors": self.errors
        }


def setup_signal_handlers(result: ProcessingResult):
    """Setup signal handlers for timeout/interruption."""
    
    def signal_handler(signum, frame):
        result.set_error("Processing interrupted by user", EXIT_TIMEOUT)
        if hasattr(result, 'json_output') and result.json_output:
            print(json.dumps(result.to_dict(), indent=2))
        sys.exit(EXIT_TIMEOUT)
    
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)


def validate_input_file(file_path: Path, result: ProcessingResult) -> bool:
    """Validate input file exists and is accessible."""
    
    if not file_path.exists():
        result.set_error(f"File not found: {file_path}", EXIT_FILE_ERROR)
        return False
    
    if not file_path.is_file():
        result.set_error(f"Path is not a file: {file_path}", EXIT_FILE_ERROR)
        return False
    
    try:
        # Test read access
        with open(file_path, 'rb') as f:
            f.read(1024)  # Read first 1KB to test
    except PermissionError:
        result.set_error(f"Permission denied: {file_path}", EXIT_FILE_ERROR)
        return False
    except Exception as e:
        result.set_error(f"File access error: {e}", EXIT_FILE_ERROR)
        return False
    
    return True


def create_output_structure(source_path: Path, result: ProcessingResult) -> Tuple[Path, Path, Path, Path]:
    """Create output directory structure."""
    
    # Get source file name without extension
    source_name = source_path.stem
    source_dir = source_path.parent
    
    # Create main output directory: same name as source file
    output_dir = source_dir / source_name
    
    # Create subdirectories
    images_dir = output_dir / "page_images"
    
    try:
        output_dir.mkdir(exist_ok=True)
        images_dir.mkdir(exist_ok=True)
        
        # Define output files - EXACTLY as per specification
        text_file = output_dir / f"{source_name}.txt"
        images_analysis_file = output_dir / f"{source_name}_images_analysis.txt"
        
        result.output_files = {
            "processed": str(text_file),
            "images_analysis": str(images_analysis_file),
            "page_images_folder": str(images_dir) + os.sep  # Ensure trailing slash
        }
        
        return output_dir, text_file, images_dir, images_analysis_file
        
    except Exception as e:
        result.set_error(f"Failed to create output directories: {e}", EXIT_FILE_ERROR)
        return None, None, None, None


def extract_text_content(source_path: Path, text_file: Path, result: ProcessingResult) -> bool:
    """Extract text content using MarkItDown."""
    
    try:
        # Import MarkItDown
        sys.path.insert(0, str(Path(__file__).parent / 'packages' / 'markitdown' / 'src'))
        from markitdown import MarkItDown
        
        # Initialize MarkItDown
        md = MarkItDown()
        
        # Convert document
        conversion_result = md.convert(str(source_path))
        
        if not conversion_result or not conversion_result.text_content:
            result.set_partial("No text content extracted from document")
            return False
        
        # Write text content
        with open(text_file, 'w', encoding='utf-8') as f:
            f.write(conversion_result.text_content)
        
        result.text_extracted = True
        
        # Check if OCR or heuristics were used (enhanced detection)
        if hasattr(conversion_result, 'metadata'):
            result.ocr_performed = conversion_result.metadata.get('ocr_used', False)
            result.heuristic_applied = conversion_result.metadata.get('heuristic_used', False)
        else:
            # Heuristic detection based on file type and content
            ext = source_path.suffix.lower()
            if ext == '.pdf':
                # For PDFs, assume heuristic was applied for text extraction
                result.heuristic_applied = True
                # OCR detection based on content characteristics
                text_content = conversion_result.text_content
                if text_content and len(text_content.strip()) > 0:
                    # Simple heuristic: if text is very short relative to expected PDF content
                    result.ocr_performed = len(text_content.strip()) < 100
            elif ext in ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff']:
                # Image files likely used OCR
                result.ocr_performed = True
            elif ext in ['.docx', '.pptx', '.xlsx']:
                # Office documents use structured extraction (heuristic)
                result.heuristic_applied = True
        
        return True
        
    except ImportError as e:
        result.set_error(f"MarkItDown not available: {e}", EXIT_CONFIG_ERROR)
        return False
    except Exception as e:
        error_msg = str(e)
        if "corrupted" in error_msg.lower() or "invalid pdf" in error_msg.lower():
            result.set_error(f"Document appears corrupted: {e}", EXIT_PDF_CORRUPTED)
        else:
            result.set_error(f"Text extraction failed: {e}", EXIT_FILE_ERROR)
        return False


def extract_images(source_path: Path, images_dir: Path, images_analysis_file: Path, result: ProcessingResult) -> bool:
    """Extract page images using the image extractor."""
    
    try:
        # Import image extraction functions
        import sys
        sys.path.insert(0, str(Path(__file__).parent))
        from image_extractor import extract_document_images
        
        # Extract images with custom naming
        source_name = source_path.stem
        temp_dir = images_dir / "temp"
        temp_dir.mkdir(exist_ok=True)
        
        # Extract to temporary directory first
        image_files = extract_document_images(
            str(source_path), 
            str(temp_dir), 
            max_size=2000, 
            dpi=200
        )
        
        if not image_files:
            result.set_partial("No images could be extracted from document")
            temp_dir.rmdir()
            return False
        
        # Rename files to required format: SOURCE_NAME_page_N.png
        final_files = []
        for i, temp_file in enumerate(image_files, 1):
            final_name = f"{source_name}_page_{i}.png"
            final_path = images_dir / final_name
            
            # Move and rename
            Path(temp_file).rename(final_path)
            final_files.append(str(final_path))
        
        # Clean up temp directory
        temp_dir.rmdir()
        
        result.images_count = len(final_files)
        result.pages_processed = len(final_files)
        
        # Create images analysis file
        try:
            with open(images_analysis_file, 'w', encoding='utf-8') as f:
                f.write(f"Image Analysis Report for {source_path.name}\n")
                f.write(f"=" * 50 + "\n\n")
                f.write(f"Total images extracted: {len(final_files)}\n")
                f.write(f"Source file: {source_path}\n")
                f.write(f"Processing date: {time.strftime('%Y-%m-%d %H:%M:%S')}\n\n")
                f.write("Extracted image files:\n")
                for i, file_path in enumerate(final_files, 1):
                    file_size = Path(file_path).stat().st_size
                    f.write(f"  {i:2d}. {Path(file_path).name} ({file_size:,} bytes)\n")
                f.write(f"\nAll images saved to: {images_dir}\n")
        except Exception as e:
            result.set_partial(f"Failed to create images analysis file: {e}")
        
        return True
        
    except ImportError as e:
        result.set_error(f"Image extraction not available: {e}", EXIT_CONFIG_ERROR)
        return False
    except Exception as e:
        error_msg = str(e)
        if "corrupted" in error_msg.lower():
            result.set_error(f"Document appears corrupted: {e}", EXIT_PDF_CORRUPTED)
        else:
            result.set_partial(f"Image extraction failed: {e}")
        return False


def process_document(source_path: Path, json_output: bool = False) -> ProcessingResult:
    """Main processing function."""
    
    result = ProcessingResult()
    result.json_output = json_output
    
    # Setup signal handlers
    setup_signal_handlers(result)
    
    # Validate input
    if not validate_input_file(source_path, result):
        return result
    
    # Create output structure
    output_dir, text_file, images_dir, images_analysis_file = create_output_structure(source_path, result)
    if not output_dir:
        return result
    
    # Extract text
    text_success = extract_text_content(source_path, text_file, result)
    
    # Extract images
    images_success = extract_images(source_path, images_dir, images_analysis_file, result)
    
    # If neither succeeded, it's an error
    if not text_success and not images_success:
        if result.status != "error":  # Don't override existing error
            result.set_error("Both text and image extraction failed", EXIT_FILE_ERROR)
    
    # Finalize result
    result.finalize()
    
    return result


def main():
    """Main entry point."""
    
    parser = argparse.ArgumentParser(
        description="Enhanced MarkItDown with structured output and JSON reporting",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python markitdown_enhanced.py document.pdf
  python markitdown_enhanced.py presentation.pptx --json-output
  python markitdown_enhanced.py report.docx --quiet --json-output

Output structure:
  source.pdf ->
    source/
      source.txt (extracted text)
      page_images/
        source_page_1.png
        source_page_2.png
        ...

Exit codes:
  0: Complete success
  10: Text only extracted
  11: Images only extracted
  12: Text and images extracted
  13: Partial success (recoverable errors)
  1: File error (not found, permissions, format)
  2: PDF corrupted/unreadable
  3: Timeout/user interruption
  4: Configuration/parameter error
        """
    )
    
    parser.add_argument(
        "source_file",
        help="Path to the source document file"
    )
    
    parser.add_argument(
        "--json-output", "-j",
        action="store_true",
        help="Output detailed status as JSON to stdout"
    )
    
    parser.add_argument(
        "--quiet", "-q",
        action="store_true",
        help="Suppress non-JSON output messages"
    )
    
    args = parser.parse_args()
    
    # Validate source file path
    source_path = Path(args.source_file)
    
    if not args.quiet and not args.json_output:
        print(f"Processing: {source_path}")
        print(f"Output directory: {source_path.parent / source_path.stem}")
        print()
    
    # Process the document
    result = process_document(source_path, args.json_output)
    
    # Output results
    if args.json_output:
        print(json.dumps(result.to_dict(), indent=2))
    else:
        if not args.quiet:
            # Human-readable output
            if result.status == "success":
                print("✅ Processing completed successfully!")
            elif result.status == "partial":
                print("⚠️  Processing completed with warnings:")
                for error in result.errors:
                    print(f"   - {error}")
            else:
                print("❌ Processing failed:")
                for error in result.errors:
                    print(f"   - {error}")
            
            if result.text_extracted:
                print(f"📄 Text extracted: {result.output_files['processed']}")
            
            if result.images_count > 0:
                print(f"🖼️  Images extracted: {result.images_count} files in {result.output_files['page_images_folder']}")
            
            print(f"⏱️  Processing time: {result.processing_time:.2f} seconds")
    
    # Exit with appropriate code
    sys.exit(result.exit_code)


if __name__ == "__main__":
    main()
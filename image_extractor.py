#!/usr/bin/env python3
"""
Image extractor for MarkItDown documents.
Extracts page images from various document formats at configurable resolution.

Supports:
- PDF files (using pdf2image or PyMuPDF)
- PowerPoint files (slide images)
- Word documents (page rendering)
- Excel spreadsheets (worksheet images)
- Single images (copy/resize)

Usage:
    python image_extractor.py document.pdf --output-dir images --max-size 2000
    python image_extractor.py presentation.pptx --output-dir slides --dpi 300
"""

import argparse
import os
import sys
from pathlib import Path
from typing import List, Tuple, Optional
import tempfile
import shutil

def extract_pdf_images(pdf_path: str, output_dir: str, max_size: int = 2000, dpi: int = 200) -> List[str]:
    """Extract page images from PDF using PyMuPDF or pdf2image."""
    output_files = []
    
    # Try PyMuPDF first (no external dependencies)
    try:
        import fitz  # PyMuPDF
        from PIL import Image
        import io
        print(f"Using PyMuPDF to extract from {pdf_path}")
        
        doc = fitz.open(pdf_path)
        
        for page_num in range(len(doc)):
            page = doc.load_page(page_num)
            
            # Calculate matrix for desired resolution
            mat = fitz.Matrix(dpi/72, dpi/72)
            pix = page.get_pixmap(matrix=mat)
            
            # Convert to PIL Image for resizing
            img_data = pix.tobytes("png")
            img = Image.open(io.BytesIO(img_data))
            
            # Resize if needed
            if max(img.size) > max_size:
                ratio = max_size / max(img.size)
                new_size = (int(img.size[0] * ratio), int(img.size[1] * ratio))
                img = img.resize(new_size, Image.LANCZOS)
            
            # Save page
            output_file = os.path.join(output_dir, f"page_{page_num+1:03d}.png")
            img.save(output_file, "PNG", optimize=True)
            output_files.append(output_file)
            print(f"  Saved page {page_num+1}: {output_file}")
        
        doc.close()
            
    except ImportError:
        # Fallback to pdf2image (requires Poppler)
        try:
            from pdf2image import convert_from_path
            from PIL import Image
            print(f"Using pdf2image to extract from {pdf_path}")
            
            # Convert PDF pages to images
            pages = convert_from_path(pdf_path, dpi=dpi)
            
            for i, page in enumerate(pages, 1):
                # Resize if needed
                if max(page.size) > max_size:
                    ratio = max_size / max(page.size)
                    new_size = (int(page.size[0] * ratio), int(page.size[1] * ratio))
                    page = page.resize(new_size, Image.LANCZOS)
                
                # Save page
                output_file = os.path.join(output_dir, f"page_{i:03d}.png")
                page.save(output_file, "PNG", optimize=True)
                output_files.append(output_file)
                print(f"  Saved page {i}: {output_file}")
                
        except ImportError:
            print("❌ Neither PyMuPDF nor pdf2image available for PDF extraction")
            return []
        try:
            import fitz  # PyMuPDF
            print(f"Using PyMuPDF to extract from {pdf_path}")
            
            doc = fitz.open(pdf_path)
            
            for page_num in range(len(doc)):
                page = doc.load_page(page_num)
                
                # Calculate matrix for desired resolution
                mat = fitz.Matrix(dpi/72, dpi/72)
                pix = page.get_pixmap(matrix=mat)
                
                # Convert to PIL Image for resizing
                img_data = pix.tobytes("png")
                from PIL import Image
                import io
                img = Image.open(io.BytesIO(img_data))
                
                # Resize if needed
                if max(img.size) > max_size:
                    ratio = max_size / max(img.size)
                    new_size = (int(img.size[0] * ratio), int(img.size[1] * ratio))
                    img = img.resize(new_size, Image.LANCZOS)
                
                # Save page
                output_file = os.path.join(output_dir, f"page_{page_num+1:03d}.png")
                img.save(output_file, "PNG", optimize=True)
                output_files.append(output_file)
                print(f"  Saved page {page_num+1}: {output_file}")
            
            doc.close()
            
        except ImportError:
            print("ERROR: Neither pdf2image nor PyMuPDF available for PDF processing")
            print("Install with: pip install pdf2image PyMuPDF")
            return []
    
    return output_files


def extract_pptx_images(pptx_path: str, output_dir: str, max_size: int = 2000) -> List[str]:
    """Extract slide images from PowerPoint presentation."""
    output_files = []
    
    try:
        from pptx import Presentation
        from PIL import Image, ImageDraw, ImageFont
        print(f"Extracting slides from {pptx_path}")
        
        prs = Presentation(pptx_path)
        
        for i, slide in enumerate(prs.slides, 1):
            # Create a white background image
            # Note: This is a simplified approach - real slide rendering requires more complex logic
            img_width = int(prs.slide_width.emu / 9525)  # Convert EMU to pixels (approximate)
            img_height = int(prs.slide_height.emu / 9525)
            
            # Ensure reasonable size
            if img_width > 1920:
                ratio = 1920 / img_width
                img_width = 1920
                img_height = int(img_height * ratio)
            
            img = Image.new('RGB', (img_width, img_height), 'white')
            draw = ImageDraw.Draw(img)
            
            # Extract text content (simplified)
            y_pos = 50
            try:
                font = ImageFont.truetype("arial.ttf", 24)
            except:
                font = ImageFont.load_default()
            
            for shape in slide.shapes:
                if hasattr(shape, "text") and shape.text.strip():
                    # Wrap text if too long
                    text = shape.text.strip()
                    if len(text) > 100:
                        text = text[:97] + "..."
                    
                    draw.text((50, y_pos), text, fill='black', font=font)
                    y_pos += 40
                    
                    if y_pos > img_height - 50:
                        break
            
            # Add slide number
            draw.text((img_width - 100, img_height - 30), f"Slide {i}", fill='gray', font=font)
            
            # Resize if needed
            if max(img.size) > max_size:
                ratio = max_size / max(img.size)
                new_size = (int(img.size[0] * ratio), int(img.size[1] * ratio))
                img = img.resize(new_size, Image.LANCZOS)
            
            # Save slide
            output_file = os.path.join(output_dir, f"slide_{i:03d}.png")
            img.save(output_file, "PNG", optimize=True)
            output_files.append(output_file)
            print(f"  Saved slide {i}: {output_file}")
    
    except ImportError:
        print("ERROR: python-pptx not available for PowerPoint processing")
        print("Install with: pip install python-pptx")
        return []
    except Exception as e:
        print(f"ERROR: Failed to extract PowerPoint slides: {e}")
        return []
    
    return output_files


def extract_docx_images(docx_path: str, output_dir: str, max_size: int = 2000) -> List[str]:
    """Extract page images from Word document (simplified approach)."""
    output_files = []
    
    try:
        from docx import Document
        from PIL import Image, ImageDraw, ImageFont
        print(f"Extracting pages from {docx_path}")
        
        doc = Document(docx_path)
        
        # Simple approach: create images from text content
        # Note: This doesn't preserve exact layout - real page rendering would require more complex tools
        
        img_width = 794  # A4 width in pixels at 96 DPI
        img_height = 1123  # A4 height in pixels at 96 DPI
        
        page_num = 1
        img = Image.new('RGB', (img_width, img_height), 'white')
        draw = ImageDraw.Draw(img)
        
        y_pos = 50
        line_height = 25
        margin = 50
        
        try:
            font = ImageFont.truetype("arial.ttf", 12)
            title_font = ImageFont.truetype("arial.ttf", 16)
        except:
            font = ImageFont.load_default()
            title_font = ImageFont.load_default()
        
        for para in doc.paragraphs:
            if para.text.strip():
                text = para.text.strip()
                
                # Check if this looks like a title (simple heuristic)
                is_title = len(text) < 100 and (text.isupper() or text.istitle())
                current_font = title_font if is_title else font
                
                # Word wrap
                words = text.split()
                lines = []
                current_line = ""
                
                for word in words:
                    test_line = current_line + " " + word if current_line else word
                    bbox = draw.textbbox((0, 0), test_line, font=current_font)
                    if bbox[2] - bbox[0] <= img_width - 2 * margin:
                        current_line = test_line
                    else:
                        if current_line:
                            lines.append(current_line)
                        current_line = word
                
                if current_line:
                    lines.append(current_line)
                
                # Draw lines
                for line in lines:
                    if y_pos + line_height > img_height - margin:
                        # Save current page and start new one
                        output_file = os.path.join(output_dir, f"page_{page_num:03d}.png")
                        
                        # Resize if needed
                        if max(img.size) > max_size:
                            ratio = max_size / max(img.size)
                            new_size = (int(img.size[0] * ratio), int(img.size[1] * ratio))
                            img = img.resize(new_size, Image.LANCZOS)
                        
                        img.save(output_file, "PNG", optimize=True)
                        output_files.append(output_file)
                        print(f"  Saved page {page_num}: {output_file}")
                        
                        # Start new page
                        page_num += 1
                        img = Image.new('RGB', (img_width, img_height), 'white')
                        draw = ImageDraw.Draw(img)
                        y_pos = 50
                    
                    draw.text((margin, y_pos), line, fill='black', font=current_font)
                    y_pos += line_height + (5 if is_title else 0)
                
                y_pos += 10  # Extra space between paragraphs
        
        # Save last page if it has content
        if y_pos > 50:
            output_file = os.path.join(output_dir, f"page_{page_num:03d}.png")
            
            # Resize if needed
            if max(img.size) > max_size:
                ratio = max_size / max(img.size)
                new_size = (int(img.size[0] * ratio), int(img.size[1] * ratio))
                img = img.resize(new_size, Image.LANCZOS)
            
            img.save(output_file, "PNG", optimize=True)
            output_files.append(output_file)
            print(f"  Saved page {page_num}: {output_file}")
    
    except ImportError:
        print("ERROR: python-docx not available for Word processing")
        print("Install with: pip install python-docx")
        return []
    except Exception as e:
        print(f"ERROR: Failed to extract Word pages: {e}")
        return []
    
    return output_files


def extract_xlsx_images(xlsx_path: str, output_dir: str, max_size: int = 2000) -> List[str]:
    """Extract worksheet images from Excel file."""
    output_files = []
    
    try:
        import pandas as pd
        from PIL import Image, ImageDraw, ImageFont
        print(f"Extracting worksheets from {xlsx_path}")
        
        # Read all sheets
        xl_file = pd.ExcelFile(xlsx_path)
        
        for i, sheet_name in enumerate(xl_file.sheet_names, 1):
            df = pd.read_excel(xlsx_path, sheet_name=sheet_name)
            
            # Calculate image size based on data
            num_rows = min(len(df), 50)  # Limit to 50 rows for visibility
            num_cols = min(len(df.columns), 10)  # Limit to 10 columns
            
            cell_width = 120
            cell_height = 25
            margin = 50
            
            img_width = num_cols * cell_width + 2 * margin
            img_height = (num_rows + 2) * cell_height + 2 * margin  # +2 for header
            
            img = Image.new('RGB', (img_width, img_height), 'white')
            draw = ImageDraw.Draw(img)
            
            try:
                font = ImageFont.truetype("arial.ttf", 10)
                header_font = ImageFont.truetype("arial.ttf", 12)
            except:
                font = ImageFont.load_default()
                header_font = ImageFont.load_default()
            
            # Draw sheet name
            draw.text((margin, margin), f"Sheet: {sheet_name}", fill='black', font=header_font)
            
            y_start = margin + 40
            
            # Draw column headers
            for col_idx, col_name in enumerate(df.columns[:num_cols]):
                x = margin + col_idx * cell_width
                y = y_start
                
                # Draw cell border
                draw.rectangle([x, y, x + cell_width, y + cell_height], outline='black', width=1)
                
                # Draw text
                text = str(col_name)[:15]  # Truncate long headers
                draw.text((x + 5, y + 5), text, fill='black', font=header_font)
            
            # Draw data rows
            for row_idx in range(min(len(df), num_rows)):
                for col_idx in range(num_cols):
                    x = margin + col_idx * cell_width
                    y = y_start + (row_idx + 1) * cell_height
                    
                    # Draw cell border
                    draw.rectangle([x, y, x + cell_width, y + cell_height], outline='gray', width=1)
                    
                    # Draw text
                    if col_idx < len(df.columns):
                        cell_value = df.iloc[row_idx, col_idx]
                        text = str(cell_value)[:12] if pd.notna(cell_value) else ""
                        draw.text((x + 5, y + 5), text, fill='black', font=font)
            
            # Resize if needed
            if max(img.size) > max_size:
                ratio = max_size / max(img.size)
                new_size = (int(img.size[0] * ratio), int(img.size[1] * ratio))
                img = img.resize(new_size, Image.LANCZOS)
            
            # Save worksheet
            output_file = os.path.join(output_dir, f"sheet_{i:03d}_{sheet_name.replace('/', '_')}.png")
            img.save(output_file, "PNG", optimize=True)
            output_files.append(output_file)
            print(f"  Saved sheet {i} ({sheet_name}): {output_file}")
    
    except ImportError:
        print("ERROR: pandas not available for Excel processing")
        print("Install with: pip install pandas openpyxl")
        return []
    except Exception as e:
        print(f"ERROR: Failed to extract Excel worksheets: {e}")
        return []
    
    return output_files


def extract_single_image(image_path: str, output_dir: str, max_size: int = 2000) -> List[str]:
    """Process single image file."""
    output_files = []
    
    try:
        from PIL import Image
        print(f"Processing image {image_path}")
        
        img = Image.open(image_path)
        
        # Convert to RGB if needed
        if img.mode in ('RGBA', 'LA', 'P'):
            background = Image.new('RGB', img.size, 'white')
            if img.mode == 'P':
                img = img.convert('RGBA')
            background.paste(img, mask=img.split()[-1] if img.mode in ('RGBA', 'LA') else None)
            img = background
        elif img.mode != 'RGB':
            img = img.convert('RGB')
        
        # Resize if needed
        if max(img.size) > max_size:
            ratio = max_size / max(img.size)
            new_size = (int(img.size[0] * ratio), int(img.size[1] * ratio))
            img = img.resize(new_size, Image.LANCZOS)
        
        # Save image
        output_file = os.path.join(output_dir, "image_001.png")
        img.save(output_file, "PNG", optimize=True)
        output_files.append(output_file)
        print(f"  Saved image: {output_file}")
    
    except Exception as e:
        print(f"ERROR: Failed to process image: {e}")
        return []
    
    return output_files


def extract_document_images(file_path: str, output_dir: str, max_size: int = 2000, dpi: int = 200) -> List[str]:
    """Main function to extract images from various document formats."""
    
    # Ensure PIL is available
    try:
        from PIL import Image
    except ImportError:
        print("ERROR: Pillow not available")
        print("Install with: pip install Pillow")
        return []
    
    file_path = Path(file_path)
    if not file_path.exists():
        print(f"ERROR: File not found: {file_path}")
        return []
    
    # Create output directory
    os.makedirs(output_dir, exist_ok=True)
    
    # Determine file type and extract accordingly
    ext = file_path.suffix.lower()
    
    if ext == '.pdf':
        return extract_pdf_images(str(file_path), output_dir, max_size, dpi)
    elif ext == '.pptx':
        return extract_pptx_images(str(file_path), output_dir, max_size)
    elif ext == '.docx':
        return extract_docx_images(str(file_path), output_dir, max_size)
    elif ext in ['.xlsx', '.xls']:
        return extract_xlsx_images(str(file_path), output_dir, max_size)
    elif ext in ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff', '.webp']:
        return extract_single_image(str(file_path), output_dir, max_size)
    else:
        print(f"ERROR: Unsupported file format: {ext}")
        print("Supported formats: PDF, PPTX, DOCX, XLSX, XLS, JPG, PNG, GIF, BMP, TIFF, WEBP")
        return []


def main():
    parser = argparse.ArgumentParser(
        description="Extract page images from documents for OpenAI attachment",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python image_extractor.py document.pdf --output-dir pages
  python image_extractor.py presentation.pptx --max-size 1500 --output-dir slides
  python image_extractor.py spreadsheet.xlsx --dpi 300 --output-dir sheets
  
Supported formats:
  - PDF: Full page extraction with pdf2image or PyMuPDF
  - PPTX: Slide content extraction (simplified rendering)
  - DOCX: Page content extraction (text-based rendering)
  - XLSX/XLS: Worksheet data as images
  - Images: Resize and optimize existing images
        """
    )
    
    parser.add_argument(
        "file_path",
        help="Path to the document file"
    )
    
    parser.add_argument(
        "--output-dir", "-o",
        default="extracted_images",
        help="Output directory for images (default: extracted_images)"
    )
    
    parser.add_argument(
        "--max-size", "-s",
        type=int,
        default=2000,
        help="Maximum size for the longest side in pixels (default: 2000)"
    )
    
    parser.add_argument(
        "--dpi", "-d",
        type=int,
        default=200,
        help="DPI for PDF rendering (default: 200)"
    )
    
    parser.add_argument(
        "--quiet", "-q",
        action="store_true",
        help="Suppress output messages"
    )
    
    args = parser.parse_args()
    
    if args.quiet:
        import logging
        logging.getLogger().setLevel(logging.ERROR)
    
    print(f"Extracting images from: {args.file_path}")
    print(f"Output directory: {args.output_dir}")
    print(f"Max size: {args.max_size}px")
    print(f"DPI (PDF): {args.dpi}")
    print()
    
    # Extract images
    output_files = extract_document_images(
        args.file_path, 
        args.output_dir, 
        args.max_size, 
        args.dpi
    )
    
    if output_files:
        print(f"\n✅ Successfully extracted {len(output_files)} images:")
        for i, file_path in enumerate(output_files, 1):
            file_size = os.path.getsize(file_path) / 1024  # KB
            print(f"  {i:2d}. {os.path.basename(file_path)} ({file_size:.1f} KB)")
        
        print(f"\nImages saved to: {os.path.abspath(args.output_dir)}")
        print(f"Total files: {len(output_files)}")
        
        # Calculate total size
        total_size = sum(os.path.getsize(f) for f in output_files) / (1024 * 1024)  # MB
        print(f"Total size: {total_size:.2f} MB")
        
    else:
        print("❌ No images were extracted")
        sys.exit(1)


if __name__ == "__main__":
    main()
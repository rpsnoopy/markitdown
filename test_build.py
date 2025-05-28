#!/usr/bin/env python3
"""
Test script for MarkItDown PyInstaller build.
Validates that all converters work correctly in the built executable.
"""

import argparse
import os
import subprocess
import sys
import tempfile
import json
from pathlib import Path


def create_test_files():
    """Create test files for different formats."""
    test_files = {}
    
    # Create temporary directory
    temp_dir = Path(tempfile.mkdtemp())
    
    # Text file
    text_file = temp_dir / "test.txt"
    text_file.write_text("This is a test text file.\nWith multiple lines.")
    test_files['txt'] = text_file
    
    # HTML file
    html_file = temp_dir / "test.html"
    html_file.write_text("""
    <html>
    <head><title>Test HTML</title></head>
    <body>
        <h1>Test Document</h1>
        <p>This is a <strong>test</strong> HTML file.</p>
        <ul>
            <li>Item 1</li>
            <li>Item 2</li>
        </ul>
    </body>
    </html>
    """)
    test_files['html'] = html_file
    
    # CSV file
    csv_file = temp_dir / "test.csv"
    csv_file.write_text("name,age,city\nJohn,30,New York\nJane,25,Los Angeles")
    test_files['csv'] = csv_file
    
    # JSON file
    json_file = temp_dir / "test.json"
    json_data = {
        "name": "Test Document",
        "type": "JSON",
        "data": [1, 2, 3],
        "nested": {"key": "value"}
    }
    json_file.write_text(json.dumps(json_data, indent=2))
    test_files['json'] = json_file
    
    # Jupyter notebook
    ipynb_file = temp_dir / "test.ipynb"
    notebook_data = {
        "cells": [
            {
                "cell_type": "markdown",
                "metadata": {},
                "source": ["# Test Notebook\n", "This is a test notebook."]
            },
            {
                "cell_type": "code",
                "execution_count": 1,
                "metadata": {},
                "outputs": [],
                "source": ["print('Hello, World!')"]
            }
        ],
        "metadata": {"kernelspec": {"name": "python3"}},
        "nbformat": 4,
        "nbformat_minor": 4
    }
    ipynb_file.write_text(json.dumps(notebook_data, indent=2))
    test_files['ipynb'] = ipynb_file
    
    return test_files, temp_dir


def test_executable(exe_path, test_files, verbose=False):
    """Test the executable with various file formats."""
    
    print(f"🧪 Testing executable: {exe_path}")
    
    if not os.path.exists(exe_path):
        print(f"❌ Executable not found: {exe_path}")
        return False
    
    # Test version command
    print("  Testing --version...")
    try:
        result = subprocess.run(
            [str(exe_path), "--version"],
            capture_output=True,
            text=True,
            timeout=30
        )
        if result.returncode == 0:
            print(f"  ✅ Version: {result.stdout.strip()}")
        else:
            print(f"  ❌ Version failed: {result.stderr}")
            return False
    except Exception as e:
        print(f"  ❌ Version command error: {e}")
        return False
    
    # Test help command
    print("  Testing --help...")
    try:
        result = subprocess.run(
            [str(exe_path), "--help"],
            capture_output=True,
            text=True,
            timeout=30
        )
        if result.returncode == 0:
            print("  ✅ Help command works")
        else:
            print(f"  ❌ Help failed: {result.stderr}")
            return False
    except Exception as e:
        print(f"  ❌ Help command error: {e}")
        return False
    
    # Test file conversions
    success_count = 0
    total_tests = len(test_files)
    
    for file_type, file_path in test_files.items():
        print(f"  Testing {file_type.upper()} conversion...")
        try:
            result = subprocess.run(
                [str(exe_path), str(file_path)],
                capture_output=True,
                text=True,
                timeout=60
            )
            
            if result.returncode == 0 and result.stdout.strip():
                print(f"  ✅ {file_type.upper()} conversion successful")
                if verbose:
                    print(f"     Output preview: {result.stdout[:100]}...")
                success_count += 1
            else:
                print(f"  ❌ {file_type.upper()} conversion failed")
                if verbose and result.stderr:
                    print(f"     Error: {result.stderr}")
                    
        except subprocess.TimeoutExpired:
            print(f"  ⚠️  {file_type.upper()} conversion timed out")
        except Exception as e:
            print(f"  ❌ {file_type.upper()} conversion error: {e}")
    
    print(f"📊 Test Results: {success_count}/{total_tests} conversions successful")
    
    # Test plugin listing
    print("  Testing --list-plugins...")
    try:
        result = subprocess.run(
            [str(exe_path), "--list-plugins"],
            capture_output=True,
            text=True,
            timeout=30
        )
        if result.returncode == 0:
            print("  ✅ Plugin listing works")
            if verbose:
                print(f"     Output: {result.stdout}")
        else:
            print(f"  ⚠️  Plugin listing failed: {result.stderr}")
    except Exception as e:
        print(f"  ❌ Plugin listing error: {e}")
    
    return success_count == total_tests


def main():
    parser = argparse.ArgumentParser(description="Test MarkItDown PyInstaller build")
    parser.add_argument(
        "executable", 
        nargs="?", 
        help="Path to the MarkItDown executable to test"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Verbose output"
    )
    parser.add_argument(
        "--find-exe",
        action="store_true", 
        help="Try to find the executable automatically"
    )
    
    args = parser.parse_args()
    
    # Find executable if not provided
    exe_path = args.executable
    if not exe_path or args.find_exe:
        # Try common locations
        project_root = Path(__file__).parent
        candidates = [
            project_root / "dist" / "markitdown" / "markitdown",
            project_root / "dist" / "markitdown" / "markitdown.exe",
            project_root / "dist" / "markitdown.exe",
            project_root / "dist" / "markitdown"
        ]
        
        for candidate in candidates:
            if candidate.exists():
                exe_path = candidate
                print(f"🔍 Found executable: {exe_path}")
                break
        else:
            print("❌ Could not find MarkItDown executable")
            print("   Build it first with: python build_markitdown.py")
            print("   Or specify path with: python test_build.py /path/to/markitdown")
            sys.exit(1)
    
    # Create test files
    print("📁 Creating test files...")
    test_files, temp_dir = create_test_files()
    
    try:
        # Run tests
        success = test_executable(exe_path, test_files, args.verbose)
        
        if success:
            print("🎉 All tests passed!")
            sys.exit(0)
        else:
            print("❌ Some tests failed!")
            sys.exit(1)
            
    finally:
        # Clean up
        print("🧹 Cleaning up test files...")
        import shutil
        shutil.rmtree(temp_dir)


if __name__ == "__main__":
    main()
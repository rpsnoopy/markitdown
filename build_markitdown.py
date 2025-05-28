#!/usr/bin/env python3
"""
Build script for creating MarkItDown PyInstaller distribution.

This script automates the process of creating a standalone executable
of MarkItDown with all optional dependencies included.

Usage:
    python build_markitdown.py [--clean] [--onefile] [--debug]

Options:
    --clean     Clean previous build artifacts
    --onefile   Create a single executable file instead of a directory
    --debug     Enable debug mode for PyInstaller
    --help      Show this help message
"""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(
        description="Build MarkItDown standalone executable with PyInstaller",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__
    )
    parser.add_argument(
        "--clean", 
        action="store_true", 
        help="Clean previous build artifacts"
    )
    parser.add_argument(
        "--onefile", 
        action="store_true",
        help="Create a single executable file instead of a directory"
    )
    parser.add_argument(
        "--debug", 
        action="store_true",
        help="Enable debug mode for PyInstaller"
    )
    parser.add_argument(
        "--upx", 
        action="store_true",
        help="Use UPX compression (if available)"
    )
    
    args = parser.parse_args()
    
    # Get project root
    project_root = Path(__file__).parent
    spec_file = project_root / "markitdown.spec"
    
    print("🚀 Building MarkItDown standalone executable...")
    print(f"📁 Project root: {project_root}")
    
    # Clean previous builds if requested
    if args.clean:
        print("🧹 Cleaning previous build artifacts...")
        dirs_to_clean = ["build", "dist", "__pycache__"]
        for dir_name in dirs_to_clean:
            dir_path = project_root / dir_name
            if dir_path.exists():
                print(f"   Removing {dir_path}")
                shutil.rmtree(dir_path)
    
    # Check if spec file exists
    if not spec_file.exists():
        print(f"❌ Spec file not found: {spec_file}")
        print("   Please ensure markitdown.spec is in the project root.")
        sys.exit(1)
    
    # Check if MarkItDown is installed
    try:
        import markitdown
        print(f"✅ MarkItDown found: {markitdown.__file__}")
    except ImportError:
        print("❌ MarkItDown not installed!")
        print("   Please install with: pip install -e 'packages/markitdown[all]'")
        sys.exit(1)
    
    # Build PyInstaller command
    cmd = ["pyinstaller"]
    
    if args.debug:
        cmd.append("--debug=all")
    else:
        cmd.append("--log-level=INFO")
    
    if args.onefile:
        # Modify spec for onefile build
        print("📦 Building as single executable file...")
        cmd.extend(["--onefile", "--name=markitdown"])
        # Add the main script directly for onefile
        markitdown_main = project_root / "packages" / "markitdown" / "src" / "markitdown" / "__main__.py"
        cmd.append(str(markitdown_main))
    else:
        print("📂 Building as directory distribution...")
        cmd.append(str(spec_file))
    
    if not args.upx:
        cmd.append("--noupx")
    
    # Add common options
    cmd.extend([
        "--clean",
        "--noconfirm",
    ])
    
    print(f"🔨 Running PyInstaller command:")
    print(f"   {' '.join(cmd)}")
    
    # Run PyInstaller
    try:
        result = subprocess.run(cmd, cwd=project_root, check=True)
        print("✅ Build completed successfully!")
        
        # Show output location
        if args.onefile:
            exe_path = project_root / "dist" / "markitdown"
            if sys.platform == "win32":
                exe_path = exe_path.with_suffix(".exe")
        else:
            exe_path = project_root / "dist" / "markitdown"
        
        if exe_path.exists():
            print(f"📍 Executable location: {exe_path}")
            
            # Test the executable
            print("🧪 Testing the executable...")
            test_cmd = [str(exe_path), "--version"]
            try:
                test_result = subprocess.run(
                    test_cmd, 
                    capture_output=True, 
                    text=True, 
                    timeout=30
                )
                if test_result.returncode == 0:
                    print(f"✅ Test successful: {test_result.stdout.strip()}")
                else:
                    print(f"⚠️  Test failed with return code {test_result.returncode}")
                    print(f"   stdout: {test_result.stdout}")
                    print(f"   stderr: {test_result.stderr}")
            except subprocess.TimeoutExpired:
                print("⚠️  Test timed out")
            except Exception as e:
                print(f"⚠️  Test error: {e}")
        
    except subprocess.CalledProcessError as e:
        print(f"❌ Build failed with return code {e.returncode}")
        sys.exit(1)
    except KeyboardInterrupt:
        print("\n🛑 Build interrupted by user")
        sys.exit(1)


if __name__ == "__main__":
    main()
#!/usr/bin/env python3
"""
Entry point for PyInstaller build of MarkItDown.
This wrapper resolves import issues with the main module and suppresses warnings.
"""

import sys
import os
import warnings
from pathlib import Path

# Set up FFmpeg path for PyInstaller bundle
if getattr(sys, 'frozen', False):
    # Running as PyInstaller bundle - FFmpeg should be in the same directory as the executable
    executable_dir = Path(sys.executable).parent
    ffmpeg_path = executable_dir / "ffmpeg.exe"
    ffprobe_path = executable_dir / "ffprobe.exe"
    
    if ffmpeg_path.exists() and ffprobe_path.exists():
        # Set environment variables so pydub can find FFmpeg
        os.environ['PATH'] = str(executable_dir) + os.pathsep + os.environ.get('PATH', '')
        print(f"✅ FFmpeg found and configured at: {executable_dir}")
    else:
        # FFmpeg not included, suppress warnings only
        warnings.filterwarnings("ignore", message=".*ffmpeg.*", category=RuntimeWarning)
        warnings.filterwarnings("ignore", message=".*avconv.*", category=RuntimeWarning)
        warnings.filterwarnings("ignore", message=".*Couldn't find ffmpeg.*", category=RuntimeWarning)
        os.environ.setdefault('PYDUB_FFMPEG_SILENCE_WARNINGS', '1')
        print("⚠️  FFmpeg not included - limited audio support")
else:
    # Running as script, check if FFmpeg is available locally
    script_dir = Path(__file__).parent
    ffmpeg_local = script_dir / "ffmpeg" / "ffmpeg.exe"
    if ffmpeg_local.exists():
        os.environ['PATH'] = str(ffmpeg_local.parent) + os.pathsep + os.environ.get('PATH', '')
        print(f"✅ Using local FFmpeg: {ffmpeg_local.parent}")
    else:
        print("⚠️  FFmpeg not found locally")

# Add the markitdown package to the Python path
if getattr(sys, 'frozen', False):
    # Running as PyInstaller bundle
    bundle_dir = Path(sys._MEIPASS)
    markitdown_path = bundle_dir / 'markitdown'
else:
    # Running as script
    script_dir = Path(__file__).parent
    markitdown_path = script_dir / 'packages' / 'markitdown' / 'src'

if markitdown_path.exists():
    sys.path.insert(0, str(markitdown_path))

# Monkey patch pydub to suppress ffmpeg warnings completely
def suppress_pydub_warnings():
    """Suppress pydub warnings about missing ffmpeg/avconv"""
    try:
        import pydub.utils
        
        # Store original function
        original_which = pydub.utils.which
        
        # Create a wrapper that suppresses warnings
        def silent_which(program):
            import warnings
            with warnings.catch_warnings():
                warnings.simplefilter("ignore")
                return original_which(program)
        
        # Replace the function
        pydub.utils.which = silent_which
        
        # Also try to set the converter path to avoid the check
        try:
            from pydub import AudioSegment
            AudioSegment.converter = "ffmpeg"  # Set default even if not available
            AudioSegment.ffmpeg = "ffmpeg"
            AudioSegment.ffprobe = "ffprobe"
        except:
            pass
            
    except ImportError:
        # pydub not available, no need to suppress
        pass

# Apply the patch before importing markitdown
suppress_pydub_warnings()

# Now import and run markitdown
try:
    from markitdown.__main__ import main
    if __name__ == '__main__':
        main()
except ImportError as e:
    print(f"Error importing markitdown: {e}")
    print(f"Python path: {sys.path}")
    print(f"Looking for markitdown at: {markitdown_path}")
    sys.exit(1)
"""
PyInstaller runtime hook to suppress pydub ffmpeg warnings.
This runs automatically when the executable starts.
"""

import warnings
import os

# Suppress all pydub-related warnings
warnings.filterwarnings("ignore", message=".*ffmpeg.*", category=RuntimeWarning)
warnings.filterwarnings("ignore", message=".*avconv.*", category=RuntimeWarning) 
warnings.filterwarnings("ignore", message=".*Couldn't find ffmpeg.*", category=RuntimeWarning)

# Set environment variables to suppress pydub warnings
os.environ['PYDUB_FFMPEG_SILENCE_WARNINGS'] = '1'

# Monkey patch pydub before it gets imported
def patch_pydub():
    """Patch pydub to prevent ffmpeg warnings"""
    import sys
    
    # Create a custom module that replaces pydub.utils
    class SilentPydubUtils:
        @staticmethod
        def which(program):
            # Always return None silently to avoid warnings
            return None
    
    # Install the hook before pydub gets imported
    import importlib.util
    
    def pydub_import_hook(name, *args, **kwargs):
        if name == 'pydub.utils':
            # Return our silent version
            spec = importlib.util.spec_from_loader(name, loader=None)
            module = importlib.util.module_from_spec(spec)
            module.which = SilentPydubUtils.which
            sys.modules[name] = module
            return module
        return original_import(name, *args, **kwargs)
    
    # Store original import and replace it
    original_import = __builtins__.__import__
    __builtins__.__import__ = pydub_import_hook

# Apply the patch
try:
    patch_pydub()
except:
    # If patching fails, just suppress warnings normally
    pass
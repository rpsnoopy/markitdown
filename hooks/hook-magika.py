"""
PyInstaller hook for magika package.
Includes ML model files and configuration data.
"""

from PyInstaller.utils.hooks import collect_data_files, collect_dynamic_libs
import os

# Collect all data files from magika package
datas = collect_data_files('magika')

# Also collect any shared libraries
binaries = collect_dynamic_libs('magika')

# Hidden imports for magika
hiddenimports = [
    'magika.content_types',
    'magika.magika',
    'magika.models',
]

# Include TensorFlow Lite models if available
try:
    import magika
    magika_path = os.path.dirname(magika.__file__)
    
    # Look for .tflite and .json files
    import glob
    model_files = glob.glob(os.path.join(magika_path, '**', '*.tflite'), recursive=True)
    model_files.extend(glob.glob(os.path.join(magika_path, '**', '*.json'), recursive=True))
    
    for model_file in model_files:
        rel_path = os.path.relpath(model_file, magika_path)
        dest_dir = os.path.dirname(rel_path)
        if dest_dir:
            datas.append((model_file, f'magika/{dest_dir}'))
        else:
            datas.append((model_file, 'magika'))
            
except ImportError:
    pass
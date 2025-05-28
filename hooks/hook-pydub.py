"""
PyInstaller hook for pydub audio processing library.
"""

from PyInstaller.utils.hooks import collect_data_files, collect_dynamic_libs

# Hidden imports for pydub and audio backends
hiddenimports = [
    'pydub',
    'pydub.audio_segment',
    'pydub.effects',
    'pydub.silence',
    'pydub.utils',
    'wave',
    'audioop',
    'array',
    'tempfile',
    'subprocess',
    'os',
    'sys',
]

# Collect data files
datas = collect_data_files('pydub')

# Collect dynamic libraries
binaries = collect_dynamic_libs('pydub')
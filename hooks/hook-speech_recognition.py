"""
PyInstaller hook for SpeechRecognition package.
Includes audio processing libraries and engines.
"""

from PyInstaller.utils.hooks import collect_data_files, collect_dynamic_libs

# Hidden imports for speech recognition
hiddenimports = [
    'speech_recognition',
    'pyaudio',
    'pocketsphinx',
    'google.cloud.speech',
    'azure.cognitiveservices.speech',
    'boto3',
    'requests',
    'json',
]

# Collect data files
datas = collect_data_files('speech_recognition')

# Collect dynamic libraries (especially for audio backends)
binaries = collect_dynamic_libs('speech_recognition')

# Try to collect PyAudio binaries if available
try:
    binaries.extend(collect_dynamic_libs('pyaudio'))
except ImportError:
    pass

# Try to collect PocketSphinx data if available  
try:
    datas.extend(collect_data_files('pocketsphinx'))
except ImportError:
    pass
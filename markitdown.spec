# -*- mode: python ; coding: utf-8 -*-
from PyInstaller.utils.hooks import collect_data_files
from PyInstaller.utils.hooks import collect_dynamic_libs

datas = [('packages/markitdown/src/markitdown', 'markitdown')]
binaries = []

# Collect data files from packages
try:
    datas += collect_data_files('magika')
except:
    print("Warning: Could not collect magika data files")

try:
    datas += collect_data_files('certifi')
except:
    print("Warning: Could not collect certifi data files")

try:
    binaries += collect_dynamic_libs('magika')
except:
    print("Warning: Could not collect magika binaries")

# Add FFmpeg binaries if available
import os
ffmpeg_dir = 'ffmpeg'
if os.path.exists(ffmpeg_dir):
    ffmpeg_exe = os.path.join(ffmpeg_dir, 'ffmpeg.exe')
    ffprobe_exe = os.path.join(ffmpeg_dir, 'ffprobe.exe')
    
    if os.path.exists(ffmpeg_exe):
        binaries.append((ffmpeg_exe, '.'))
        print(f"Including FFmpeg: {ffmpeg_exe}")
    
    if os.path.exists(ffprobe_exe):
        binaries.append((ffprobe_exe, '.'))
        print(f"Including FFprobe: {ffprobe_exe}")
        
    if os.path.exists(ffmpeg_exe) and os.path.exists(ffprobe_exe):
        print("✅ Complete FFmpeg support enabled!")
    else:
        print("⚠️  FFmpeg not found - limited audio support")
else:
    print("⚠️  FFmpeg directory not found - run INSTALL_FFMPEG.bat for complete audio support")

a = Analysis(
    ['markitdown_entry.py'],
    pathex=[],
    binaries=binaries,
    datas=datas,
    hiddenimports=[
        # Core markitdown modules
        'markitdown',
        'markitdown.__main__',
        'markitdown._markitdown',
        'markitdown._base_converter',
        'markitdown._exceptions',
        'markitdown._stream_info', 
        'markitdown._uri_utils',
        'markitdown.__about__',
        
        # All converter modules
        'markitdown.converters',
        'markitdown.converters._plain_text_converter',
        'markitdown.converters._html_converter',
        'markitdown.converters._rss_converter',
        'markitdown.converters._wikipedia_converter',
        'markitdown.converters._youtube_converter',
        'markitdown.converters._ipynb_converter',
        'markitdown.converters._bing_serp_converter',
        'markitdown.converters._pdf_converter',
        'markitdown.converters._docx_converter',
        'markitdown.converters._xlsx_converter',
        'markitdown.converters._pptx_converter',
        'markitdown.converters._image_converter',
        'markitdown.converters._audio_converter',
        'markitdown.converters._outlook_msg_converter',
        'markitdown.converters._zip_converter',
        'markitdown.converters._doc_intel_converter',
        'markitdown.converters._epub_converter',
        'markitdown.converters._csv_converter',
        'markitdown.converters._exiftool',
        'markitdown.converters._llm_caption',
        'markitdown.converters._transcribe_audio',
        'markitdown.converters._markdownify',
        
        # Utility modules
        'markitdown.converter_utils',
        'markitdown.converter_utils.docx',
        'markitdown.converter_utils.docx.math',
        'markitdown.converter_utils.docx.math.latex_dict',
        'markitdown.converter_utils.docx.math.omml',
        'markitdown.converter_utils.docx.pre_process',
        
        # Core dependencies
        'beautifulsoup4',
        'bs4',
        'requests',
        'markdownify',
        'charset_normalizer',
        'defusedxml',
        
        # Optional dependencies
        'magika',
        'pdfminer.six',
        'pdfminer.high_level',
        'mammoth',
        'pandas',
        'openpyxl',
        'xlrd',
        'lxml',
        'lxml.etree',
        'lxml.html',
        'pptx',
        'python_pptx',
        'PIL',
        'PIL.Image',
        'pydub',
        'speech_recognition',
        'SpeechRecognition',
        'olefile',
        'youtube_transcript_api',
        'azure.ai.documentintelligence',
        'azure.identity',
        'azure.core',
        
        # System modules
        'importlib.metadata',
        'mimetypes',
        'codecs',
        'urllib.parse',
        'pathlib',
        'tempfile',
        'json',
        'xml.etree.ElementTree',
        'zipfile',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=['runtime_hooks/rthook_suppress_warnings.py'],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='markitdown',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)

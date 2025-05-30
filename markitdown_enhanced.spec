# -*- mode: python ; coding: utf-8 -*-
from PyInstaller.utils.hooks import collect_data_files

datas = [('packages/markitdown/src/markitdown', 'markitdown'), ('image_extractor.py', '.')]
datas += collect_data_files('magika')
datas += collect_data_files('certifi')


a = Analysis(
    ['markitdown_enhanced.py'],
    pathex=[],
    binaries=[],
    datas=datas,
    hiddenimports=[
        # Core MarkItDown
        'markitdown', 
        'markitdown.__main__', 
        'markitdown._markitdown',
        # Essential dependencies for Office documents  
        'mammoth',     # DOCX support
        'docx',        # python-docx (correct import name)
        'lxml',        # DOCX support
        'pptx',        # PowerPoint support  
        'python_pptx', # PowerPoint (correct import name)
        'openpyxl',    # Excel support
        'pandas',      # Excel support
        # PDF image extraction
        'fitz',        # PyMuPDF
        'PIL', 
        'PIL.Image',
        # Core web/markup
        'beautifulsoup4',
        'bs4',
        'requests',
        'defusedxml'
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
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
    name='markitdown_enhanced',
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

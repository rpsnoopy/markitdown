"""
PyInstaller hook for MarkItDown package.
Ensures all converters and plugins are properly included.
"""

from PyInstaller.utils.hooks import collect_submodules, collect_data_files
import os

# Collect all MarkItDown submodules
hiddenimports = collect_submodules('markitdown')

# Add specific converter modules that might be missed
hiddenimports.extend([
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
])

# Collect data files from MarkItDown
datas = collect_data_files('markitdown')

# Include utility modules for DOCX processing
try:
    datas.extend(collect_data_files('markitdown.converter_utils'))
    hiddenimports.extend(collect_submodules('markitdown.converter_utils'))
except ImportError:
    pass
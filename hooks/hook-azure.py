"""
PyInstaller hook for Azure SDK packages.
Handles Azure Document Intelligence and Identity packages.
"""

from PyInstaller.utils.hooks import collect_data_files, collect_submodules

# Hidden imports for Azure packages
hiddenimports = [
    'azure.ai.documentintelligence',
    'azure.identity',
    'azure.core',
    'azure.core.credentials',
    'azure.core.pipeline',
    'azure.core.exceptions',
    'msal',
    'msal_extensions',
    'cryptography',
    'jwt',
]

# Collect data files
datas = []
try:
    datas.extend(collect_data_files('azure.ai.documentintelligence'))
    datas.extend(collect_data_files('azure.identity'))
    datas.extend(collect_data_files('azure.core'))
except ImportError:
    pass

# Collect all submodules
try:
    hiddenimports.extend(collect_submodules('azure.ai.documentintelligence'))
    hiddenimports.extend(collect_submodules('azure.identity'))
    hiddenimports.extend(collect_submodules('azure.core'))
except ImportError:
    pass
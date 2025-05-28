# MarkItDown Distribuzione Standalone

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PyInstaller](https://img.shields.io/badge/PyInstaller-6.0+-blue.svg)](https://pyinstaller.org/)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![Python](https://img.shields.io/badge/Python-3.10+-green.svg)](https://python.org)

> **Questa è una distribuzione avanzata del progetto MarkItDown originale che crea eseguibili standalone con supporto completo per tutti i formati di file.**

## 🎯 Panoramica

Questo progetto estende l'utility [MarkItDown](https://github.com/microsoft/markitdown) di Microsoft fornendo un sistema di distribuzione completo **basato su PyInstaller** che crea eseguibili standalone. L'eseguibile risultante include **tutte le dipendenze opzionali** e supporta **ogni formato di file** senza richiedere l'installazione di Python sulle macchine di destinazione.

### 🔄 Relazione con il MarkItDown Originale

- **Base**: Costruito su MarkItDown 0.1.2a1 di Microsoft
- **Miglioramento**: Aggiunge compilazione PyInstaller con gestione completa delle dipendenze
- **Compatibilità**: 100% compatibile con l'interfaccia CLI di MarkItDown originale
- **Estensione**: Include supporto audio avanzato con integrazione opzionale FFmpeg

## 🌟 Caratteristiche Principali

### 📄 Supporto Completo per Formati Documento

#### Documenti Office
- **PDF** (`.pdf`) - Estrazione testo avanzata con preservazione del layout
- **Microsoft Word** (`.docx`) - Formattazione completa e preservazione stili
- **Microsoft Excel** (`.xlsx`, `.xls`) - Dati tabellari con supporto formule
- **Microsoft PowerPoint** (`.pptx`) - Contenuto slide e note relatore
- **Outlook** messaggi email (`.msg`) - Contenuto email, allegati e metadati
- **EPUB** ebook (`.epub`) - Struttura capitoli ed estrazione contenuto

#### Formati Web e Dati
- **HTML** pagine e file - Conversione markup pulita con preservazione link
- **CSV** file dati - Formattazione automatica tabelle
- **JSON** dati strutturati - Rappresentazione dati gerarchica
- **XML** documenti - Parsing struttura-consapevole
- **RSS/Atom** feed - Estrazione contenuto articoli
- **Jupyter** notebook (`.ipynb`) - Celle codice, markdown e preservazione output

#### Media e Contenuto Ricco
- **Immagini** (`.jpg`, `.png`, `.gif`, `.bmp`, `.tiff`, `.webp`)
  - Estrazione metadati EXIF (con ExifTool)
  - Estrazione testo OCR (con integrazione LLM)
  - Generazione descrizioni immagini (AI-powered)
- **Audio** (`.wav`, `.mp3`, `.m4a`, `.flac`, `.ogg`, `.aac`)
  - Trascrizione speech-to-text
  - Estrazione metadati
  - Supporto multi-formato con FFmpeg

#### Contenuto Web e API
- **Wikipedia** pagine - Contenuto articoli con formattazione corretta
- **YouTube** video - Estrazione trascrizioni e metadati video
- **Pagine web** - Qualsiasi contenuto URL HTTP/HTTPS
- **Bing SERP** risultati - Parsing risultati ricerca

#### Formati Archivio e Container
- **ZIP** archivi - Elaborazione ricorsiva di tutti i file contenuti
- **Email** container - Elaborazione messaggi multipli

#### Servizi Cloud ed Enterprise
- **Azure Document Intelligence** - OCR basato su cloud e analisi documenti
- **Plugin personalizzati** - Architettura estensibile per convertitori terze parti

## 🚀 Avvio Rapido

### Prerequisiti

- **Windows 10/11** (64-bit)
- **Python 3.10 o superiore** ([Download](https://python.org))
  - ⚠️ **Importante**: Spuntare "Add Python to PATH" durante l'installazione
- **2-5 GB** spazio libero su disco per il processo di build
- **Connessione internet** per scaricare le dipendenze

### Processo di Build

#### Passo 1: Installare Dipendenze Core
```cmd
INSTALL_DEPENDENCIES.bat
```

Questo installa:
- PyInstaller 6.0+
- MarkItDown con tutte le dipendenze opzionali
- Strumenti di build e requisiti

#### Passo 2: Installare FFmpeg (Raccomandato)
```cmd
INSTALL_FFMPEG.bat
```

Questo abilita:
- Supporto completo formati audio (MP3, M4A, FLAC, etc.)
- Trascrizione audio di alta qualità
- Capacità elaborazione audio avanzate
- Nessun messaggio di warning

**Salta questo passo per**: Dimensione eseguibile più piccola o se il supporto audio non è necessario.

#### Passo 3: Compilare Eseguibile
```cmd
COMPILE.bat
```

Crea: `dist/markitdown.exe` - Un eseguibile standalone con tutte le funzionalità

#### Passo 4: Test (Opzionale)
```cmd
TEST_EXECUTABLE.bat
```

Valida: Tutti i convertitori di formato file funzionano correttamente

## 📦 Opzioni di Distribuzione

### Opzione A: Distribuzione Completa (Raccomandato)
```cmd
INSTALL_DEPENDENCIES.bat
INSTALL_FFMPEG.bat
COMPILE.bat
```

**Risultato**: `markitdown.exe` (250-350 MB)
- ✅ **Supporto audio completo** (tutti i formati)
- ✅ **Nessun warning o limitazione**
- ✅ **Funzionalità di livello professionale**

### Opzione B: Distribuzione Lite
```cmd
INSTALL_DEPENDENCIES.bat
COMPILE.bat
```

**Risultato**: `markitdown.exe` (200-300 MB)
- ⚠️ **Supporto audio basilare** (solo WAV)
- ✅ **Dimensione file più piccola**
- ✅ **Tutti gli altri formati completamente supportati**

## 💻 Utilizzo

L'eseguibile standalone funziona identicamente al MarkItDown originale:

### Conversione Base
```cmd
# Convertire qualsiasi documento in Markdown
markitdown.exe documento.pdf > output.md
markitdown.exe presentazione.pptx -o slide.md
markitdown.exe foglio_calcolo.xlsx

# Elaborare da stdin
type documento.txt | markitdown.exe
```

### Opzioni Avanzate
```cmd
# Specificare file di output
markitdown.exe input.docx -o output.md

# Fornire suggerimenti tipo file
markitdown.exe dati.bin -x .pdf -m application/pdf

# Usare Azure Document Intelligence
markitdown.exe documento.pdf -d -e "https://your-endpoint.cognitiveservices.azure.com/"

# Abilitare plugin
markitdown.exe --use-plugins documento.pdf

# Elencare plugin disponibili
markitdown.exe --list-plugins

# Mantenere data URI nell'output
markitdown.exe immagine.html --keep-data-uris
```

### Riferimento Linea di Comando
```
markitdown.exe [OPZIONI] [NOME_FILE]

OPZIONI:
  -o, --output FILE          Salva output su file invece di stdout
  -x, --extension EXT        Suggerimento estensione file (es. .pdf)
  -m, --mime-type TYPE       Suggerimento tipo MIME (es. application/pdf)
  -c, --charset CHARSET      Suggerimento codifica caratteri (es. utf-8)
  -d, --use-docintel         Usa Azure Document Intelligence
  -e, --endpoint URL         Endpoint Document Intelligence
  -p, --use-plugins          Abilita plugin terze parti
  --list-plugins             Mostra plugin installati
  --keep-data-uris          Preserva data URI nell'output
  -v, --version             Mostra informazioni versione
  -h, --help                Mostra messaggio aiuto
```

## 🔧 Configurazione Avanzata

### Integrazione Strumenti Esterni

#### ExifTool (Opzionale)
Per estrazione avanzata metadati immagini:

**Rilevamento Automatico**: Il processo di build rileva automaticamente ExifTool in:
- PATH di sistema
- `/usr/bin/exiftool`
- `/usr/local/bin/exiftool`
- `C:\Program Files\exiftool.exe`

**Installazione Manuale**:
1. Scarica da [exiftool.org](https://exiftool.org/)
2. Estrai nella directory di sistema o cartella progetto
3. Ricompila eseguibile per includere

#### Configurazione FFmpeg
FFmpeg fornisce capacità elaborazione audio avanzate:

**Formati Supportati con FFmpeg**:
- MP3, M4A, FLAC, OGG, AAC, WMA
- Supporto codec avanzato
- Trascrizione alta qualità
- Preservazione metadati

**Senza FFmpeg**:
- Solo file WAV
- Trascrizione basilare
- Metadati audio limitati

### Azure Document Intelligence

Per elaborazione documenti basata su cloud:

```cmd
# Impostare credenziali Azure
set AZURE_CLIENT_ID=your-client-id
set AZURE_CLIENT_SECRET=your-client-secret
set AZURE_TENANT_ID=your-tenant-id

# Usare con endpoint
markitdown.exe documento.pdf -d -e "https://your-endpoint.cognitiveservices.azure.com/"
```

### Sistema Plugin

MarkItDown supporta plugin terze parti per tipi file personalizzati:

```cmd
# Installare un plugin
pip install markitdown-plugin-example

# Abilitare plugin durante conversione
markitdown.exe --use-plugins file-personalizzato.xyz

# Elencare plugin installati
markitdown.exe --list-plugins
```

## 🧪 Test e Validazione

### Test Automatici
```cmd
TEST_EXECUTABLE.bat
```

I test includono:
- Verifica comando versione
- Funzionalità sistema aiuto
- Conversioni formati file core (TXT, HTML, CSV, JSON)
- Gestione errori e casi limite

### Test Manuali
```cmd
# Testare formati specifici
markitdown.exe test.pdf
markitdown.exe test.docx  
markitdown.exe test.xlsx
markitdown.exe test.pptx
markitdown.exe test.jpg
markitdown.exe test.mp3
```

### Benchmark Prestazioni

| Tipo File | Dimensione | Tempo Conversione* | Uso Memoria* |
|-----------|------------|-------------------|---------------|
| PDF (10 pagine) | 2 MB | 3-8 secondi | 150-300 MB |
| DOCX (complesso) | 5 MB | 2-5 secondi | 100-200 MB |
| XLSX (1000 righe) | 1 MB | 1-3 secondi | 80-150 MB |
| PPTX (50 slide) | 10 MB | 5-12 secondi | 200-400 MB |
| Audio (5 minuti) | 5 MB | 30-120 secondi | 200-500 MB |

*Le prestazioni variano in base alle specifiche del sistema e complessità del contenuto

## 📁 Struttura Progetto

```
markitdown/
├── 📁 packages/markitdown/          # Sorgente MarkItDown originale
├── 📄 INSTALL_DEPENDENCIES.bat     # Installa dipendenze Python
├── 📄 INSTALL_FFMPEG.bat          # Installa binari FFmpeg
├── 📄 COMPILE.bat                  # Costruisci eseguibile standalone
├── 📄 TEST_EXECUTABLE.bat         # Valida build
├── 📄 markitdown.spec              # Configurazione PyInstaller
├── 📄 markitdown_entry.py          # Punto di ingresso personalizzato
├── 📄 build_requirements.txt       # Lista dipendenze build
├── 📁 hooks/                       # Hook PyInstaller
│   ├── hook-magika.py              # Inclusione modelli ML
│   ├── hook-azure.py               # Supporto Azure SDK
│   ├── hook-speech_recognition.py  # Elaborazione audio
│   ├── hook-pydub.py               # Librerie audio
│   └── hook-markitdown.py          # Supporto moduli core
├── 📁 runtime_hooks/               # Configurazione runtime
│   └── rthook_suppress_warnings.py # Soppressione warning
├── 📁 ffmpeg/ (dopo install)       # Binari FFmpeg
│   ├── ffmpeg.exe                  # Convertitore audio
│   └── ffprobe.exe                 # Analizzatore media
├── 📁 build/ (creata)              # Artefatti build
├── 📁 dist/ (creata)               # Eseguibile finale
│   └── markitdown.exe              # Eseguibile standalone
└── 📄 README_IT.md                 # Questo file
```

## 🔍 Risoluzione Problemi

### Problemi Comuni

#### "Python is not installed or not in PATH"
**Soluzione**: 
1. Installa Python da [python.org](https://python.org)
2. Durante l'installazione, spunta "Add Python to PATH"
3. Riavvia prompt dei comandi

#### "MarkItDown is not installed"
**Soluzione**:
1. Esegui prima `INSTALL_DEPENDENCIES.bat`
2. Aspetta il completamento con successo
3. Poi esegui `COMPILE.bat`

#### Build fallisce con "ModuleNotFoundError"
**Soluzione**:
1. Elimina cartelle `build/` e `dist/`
2. Esegui di nuovo `INSTALL_DEPENDENCIES.bat`
3. Assicurati che tutte le dipendenze siano installate con successo
4. Ricompila con `COMPILE.bat`

#### Dimensione eseguibile molto grande (>400 MB)
**Cause e Soluzioni**:
- **Normale**: Dimensione base 200-350 MB include runtime Python + tutte le librerie
- **Con FFmpeg**: Aggiunge ~50-100 MB per supporto audio completo
- **Ottimizzazione**: Usa compressione UPX (riduce del ~30-50%)

#### Falsi positivi antivirus
**Soluzione**:
1. Aggiungi `dist/markitdown.exe` alle eccezioni antivirus
2. È comune con eseguibili PyInstaller
3. Considera firma codice per distribuzione

#### Warning/errori conversione audio
**Senza FFmpeg**:
- Limitato solo al formato WAV
- Esegui `INSTALL_FFMPEG.bat` per supporto completo

**Con FFmpeg**:
- Dovrebbe gestire tutti i formati audio
- Controlla installazione FFmpeg se persistono problemi

### Modalità Debug

Per risoluzione problemi dettagliata:

```cmd
# Build con informazioni debug
python -m PyInstaller markitdown.spec --debug=all

# Controlla cosa è incluso
python test_build.py --verbose

# Testa funzionalità specifiche
markitdown.exe --version
markitdown.exe --help
markitdown.exe --list-plugins
```

### Ottimizzazione Prestazioni

#### Tempo Avvio
- **Distribuzione directory**: Avvio più veloce (~2-5 secondi)
- **File singolo**: Avvio più lento (~5-15 secondi)
- **Build debug**: Significativamente più lente

#### Uso Memoria
- **Uso tipico**: 100-300 MB RAM
- **File grandi**: Può usare 500MB-1GB temporaneamente
- **Elaborazione audio**: Uso memoria maggiore durante trascrizione

#### Riduzione Dimensione File
```cmd
# Abilita compressione UPX
python build_markitdown.py --upx

# Rimuovi informazioni debug
python build_markitdown.py --strip

# Escludi dipendenze non usate
# Modifica sezione excludes di markitdown.spec
```

## 📋 Requisiti Sistema

### Ambiente Build
- **SO**: Windows 10/11 (64-bit)
- **Python**: 3.10, 3.11, 3.12, o 3.13
- **RAM**: 4 GB minimo, 8 GB raccomandato
- **Storage**: 5 GB spazio libero durante build
- **Rete**: Connessione internet per download dipendenze

### Ambiente Runtime (Utenti Finali)
- **SO**: Windows 10/11 (64-bit)
- **RAM**: 500 MB minimo, 1 GB raccomandato  
- **Storage**: 300-500 MB per eseguibile
- **Dipendenze**: Nessuna (completamente standalone)

### Piattaforme Supportate
- **Primaria**: Windows 10/11 (x64)
- **Potenziale**: Linux/macOS con modifiche file spec
- **Architettura**: Solo 64-bit

## 📄 Licenza e Aspetti Legali

### Informazioni Licenza
Questa distribuzione è rilasciata sotto **Licenza MIT**, coerente con il progetto MarkItDown originale.

### Componenti Terze Parti
Questo eseguibile include i seguenti componenti, ciascuno sotto le rispettive licenze:

- **MarkItDown**: Licenza MIT (Microsoft Corporation)
- **Python Runtime**: Python Software Foundation License
- **PyInstaller**: GPL v2+ con eccezione
- **BeautifulSoup4**: Licenza MIT
- **Requests**: Licenza Apache 2.0
- **Pandas**: Licenza BSD 3-Clause
- **OpenPyXL**: Licenza MIT
- **python-pptx**: Licenza MIT
- **pdfminer.six**: Licenza MIT
- **Pillow**: PIL Software License
- **pydub**: Licenza MIT
- **SpeechRecognition**: Licenza BSD 3-Clause
- **Azure SDK**: Licenza MIT
- **FFmpeg** (se incluso): LGPL v2.1+

### Diritti di Utilizzo
- ✅ **Uso commerciale** permesso
- ✅ **Distribuzione** permessa
- ✅ **Modifica** permessa
- ✅ **Uso privato** permesso
- ⚠️ **Nessuna garanzia** fornita

### Requisiti Attribuzione
Quando distribuisci questo eseguibile:
1. Includi informazioni licenza per tutti i componenti
2. Attribuisci progetto MarkItDown originale a Microsoft
3. Mantieni note copyright nella documentazione

### Nota Legale FFmpeg
Se FFmpeg è incluso:
- FFmpeg è sotto licenza LGPL v2.1+
- Distribuzione commerciale può richiedere conformità con termini LGPL
- Considera revisione legale per deployment commerciale
- Disponibilità codice sorgente può essere richiesta per conformità LGPL

## 🤝 Contribuire

### Segnalare Problemi
1. **Testa prima**: Verifica che il problema esista sia nel MarkItDown originale che in questa distribuzione
2. **Controlla documentazione**: Rivedi sezione risoluzione problemi
3. **Fornisci dettagli**: Includi tipi file, messaggi errore, info sistema
4. **File campione**: Fornisci file problematici quando possibile (se non sensibili)

### Richieste Miglioramenti
- **Nuovi formati file**: Considera contribuire al MarkItDown upstream
- **Miglioramenti build**: Miglioramenti configurazione PyInstaller benvenuti
- **Ottimizzazioni prestazioni**: Sempre apprezzate
- **Supporto cross-platform**: File spec Linux/macOS necessari

### Setup Sviluppo
```cmd
# Clona repository
git clone https://github.com/microsoft/markitdown.git
cd markitdown

# Installa dipendenze sviluppo
pip install -e "packages/markitdown[all]"
pip install pyinstaller

# Fai modifiche
# Testa cambiamenti
python test_build.py

# Build e test
COMPILE.bat
TEST_EXECUTABLE.bat
```

## 🌟 Riconoscimenti

- **Microsoft Corporation** - Progetto MarkItDown originale e team sviluppo
- **Team PyInstaller** - Eccellente soluzione packaging Python
- **Comunità Open Source** - Tutti i maintainer librerie dipendenze
- **Contributori** - Tutti coloro che hanno aiutato a migliorare questa distribuzione

## 📞 Supporto

### Documentazione
- **Questo README**: Guida completa utilizzo e risoluzione problemi
- **MarkItDown Originale**: [Repository GitHub](https://github.com/microsoft/markitdown)
- **PyInstaller**: [Documentazione Ufficiale](https://pyinstaller.org/)

### Supporto Comunità
- **Issues**: Segnala problemi via GitHub Issues
- **Discussioni**: Unisciti alle discussioni comunità
- **Aggiornamenti**: Segui repository per nuove release

### Supporto Professionale
Per deployment enterprise o necessità supporto commerciale, considera:
- Canali supporto ufficiali MarkItDown di Microsoft
- Servizi consulenza Python/PyInstaller professionali
- Servizi integrazione e deployment personalizzati

---

## 🎉 Pronto a Convertire Tutto!

Ora hai un eseguibile MarkItDown completo e standalone che può convertire virtualmente qualsiasi formato documento in Markdown senza richiedere Python o dipendenze sulle macchine di destinazione.

**Buona conversione!** 📝✨
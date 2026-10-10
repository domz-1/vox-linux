# 🎙️ Vox Linux - Smart Text-to-Speech & Podcast Maker for Linux

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Linux%20(X11%20%26%20GNOME)-orange.svg)]()
[![Python](https://img.shields.io/badge/Python-3.8%2B-green.svg)]()
[![Languages](https://img.shields.io/badge/Supports-Arabic%20%7C%20English%20%7C%20Multi-purple.svg)]()

A fast, lightweight, and modern Text-to-Speech (TTS) reader and podcast generator for Linux. Highlight any text anywhere (browser, PDF, editor, terminal, chat), press **`Alt + S`**, and listen to it read aloud instantly in a natural voice. Also includes a classic CLI `say` tool and an MP3 podcast exporter!

---

## ✨ Features

- ⚡ **Global Instant Shortcut (`Alt + S`):** Highlight any text with your mouse, hit `Alt + S`, and start listening immediately. Pressing `Alt + S` again stops playback instantly.
- 🌐 **Automatic Language Detection:** Automatically detects Arabic, English, French, German, Spanish, Japanese, and more, switching voices seamlessly without manual configuration.
- 🎧 **Podcast & MP3 Exporter:** Export any article, book, or documentation to high-quality MP3 audio with `--save output.mp3`.
- 💻 **Familiar CLI `say` Command:** Provides macOS-like `say "Hello World"` and `vox -f article.txt` in your terminal.
- ⏩ **Speed Control:** Easily speed up or slow down playback with `--speed 1.25` or `--speed 1.5`.
- 🔔 **Desktop Notifications:** Shows clean desktop alerts displaying the detected language, flag, and a preview of the text being spoken.
- 🖥️ **GUI Input Prompt:** Pressing `Alt + S` without selecting text pops up a simple input box (Zenity) so you can type or paste manually.

---

## 📦 Dependencies

| Dependency | Purpose |
| :--- | :--- |
| **`python3`** | Core text processing and streaming engine |
| **`mpv`** | High-performance, low-latency audio player |
| **`xclip`** / **`copyq`** | Instant reading of highlighted mouse text and clipboard |
| **`zenity`** | Lightweight GUI input fallback dialog |
| **`libnotify`** / `notify-send` | Desktop notifications |

---

## 🛠️ Installation

### 1-Line Quick Install

```bash
git clone https://github.com/domz-1/vox-linux.git
cd vox-linux
make install
```

*(The installer will auto-detect your distribution, install dependencies, copy binaries to `~/.local/bin`, and configure your global `Alt + S` shortcut).*

---

### Manual Installation per Distribution

#### 🐧 Ubuntu / Debian / Linux Mint:
```bash
sudo apt update
sudo apt install -y python3 mpv xclip copyq zenity libnotify-bin
git clone https://github.com/domz-1/vox-linux.git
cd vox-linux
./install.sh
```

#### 🐧 Arch Linux / Manjaro:
```bash
sudo pacman -S --noconfirm python mpv xclip copyq zenity libnotify
git clone https://github.com/domz-1/vox-linux.git
cd vox-linux
./install.sh
```

#### 🐧 Fedora / RHEL:
```bash
sudo dnf install -y python3 mpv xclip copyq zenity libnotify
git clone https://github.com/domz-1/vox-linux.git
cd vox-linux
./install.sh
```

---

## 🕹️ Usage & Examples

### 1. Global Keyboard Shortcut
* **Highlight any text** in any window with your mouse.
* Press **`Alt + S`** to play.
* Press **`Alt + S`** again to stop.

### 2. Command Line Interface (CLI)

```bash
# Speak any phrase
say "Hello world, welcome to Linux"
vox "مرحبا بك في نظام لينكس"

# Read a text file aloud
vox -f /path/to/article.txt

# Speed up playback (1.5x)
say --speed 1.5 "This is playing at one and a half times speed"

# Pipe text from terminal
cat README.md | vox
echo "Deployment completed successfully" | say

# Export text to an MP3 file (Podcast)
vox --save podcast.mp3 -f long_article.txt

# Stop any currently playing speech
vox --stop
```

---

## 🗑️ Uninstallation

```bash
cd vox-linux
make uninstall
```

---

## 👨‍💻 Author & Credits

Created with ❤️ by **Adham** ([@domz-1](https://github.com/domz-1)).

If you like this project, please star ⭐️ the repository on GitHub!

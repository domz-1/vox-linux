#!/usr/bin/env bash
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=========================================${NC}"
echo -e "${GREEN}   🎙️ Installing Vox Linux (TTS)          ${NC}"
echo -e "${BLUE}=========================================${NC}"

# 1. Install Dependencies
echo -e "${YELLOW}Checking dependencies...${NC}"

install_deps() {
    if command -v apt-get &>/dev/null; then
        echo -e "${BLUE}Detected Debian/Ubuntu system.${NC}"
        sudo apt-get update -y || true
        sudo apt-get install -y python3 mpv xclip copyq zenity libnotify-bin
    elif command -v pacman &>/dev/null; then
        echo -e "${BLUE}Detected Arch Linux system.${NC}"
        sudo pacman -S --noconfirm python mpv xclip copyq zenity libnotify
    elif command -v dnf &>/dev/null; then
        echo -e "${BLUE}Detected Fedora/RHEL system.${NC}"
        sudo dnf install -y python3 mpv xclip copyq zenity libnotify
    elif command -v zypper &>/dev/null; then
        echo -e "${BLUE}Detected openSUSE system.${NC}"
        sudo zypper install -y python3 mpv xclip copyq zenity libnotify-tools
    else
        echo -e "${YELLOW}Warning: Unknown package manager. Please ensure python3, mpv, xclip, copyq, zenity, and libnotify are installed.${NC}"
    fi
}

if ! command -v mpv &>/dev/null || ! command -v xclip &>/dev/null || ! command -v zenity &>/dev/null; then
    echo -e "${YELLOW}Some dependencies are missing. Installing...${NC}"
    install_deps
else
    echo -e "${GREEN}✓ All core dependencies found!${NC}"
fi

# 2. Install Executables to ~/.local/bin
echo -e "${YELLOW}Installing vox and say commands to ~/.local/bin...${NC}"
mkdir -p "$HOME/.local/bin"
cp -f "$(dirname "$0")/bin/vox" "$HOME/.local/bin/vox"
chmod +x "$HOME/.local/bin/vox"
ln -sf "$HOME/.local/bin/vox" "$HOME/.local/bin/say"

# 3. Install Desktop Launcher
echo -e "${YELLOW}Installing desktop application launcher...${NC}"
mkdir -p "$HOME/.local/share/applications"
cp -f "$(dirname "$0")/assets/vox.desktop" "$HOME/.local/share/applications/vox.desktop"
command -v update-desktop-database &>/dev/null && update-desktop-database "$HOME/.local/share/applications" || true

# 4. Setup GNOME Shortcut (Alt+S for speak/toggle, Alt+Shift+S for stop)
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || [ "$XDG_CURRENT_DESKTOP" = "ubuntu:GNOME" ] || [ "$DESKTOP_SESSION" = "ubuntu" ] || [ "$DESKTOP_SESSION" = "gnome" ]; then
    echo -e "${YELLOW}Configuring GNOME global shortcuts (Alt+S)...${NC}"
    # Read existing custom keybindings
    EXISTING=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | tr -d '@as ' | sed 's/\[//;s/\]//')
    
    KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/vox0/"
    
    if [[ ! "$EXISTING" =~ "vox0" ]]; then
        if [ -z "$EXISTING" ]; then
            NEW_LIST="['$KEY_PATH']"
        else
            NEW_LIST="[$(echo "$EXISTING" | sed "s/]$//"), '$KEY_PATH']"
        fi
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_LIST" || true
    fi

    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH name "Vox - Text to Speech (Alt+S)" || true
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH command "$HOME/.local/bin/vox" || true
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH binding "<Alt>s" || true
fi

echo -e "\n${GREEN}=========================================${NC}"
echo -e "${GREEN}   ✅ Vox Linux Installed Successfully!   ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo -e "${BLUE}How to use:${NC}"
echo -e "1. Highlight any text with your mouse in any application."
echo -e "2. Press ${YELLOW}Alt + S${NC} to start/stop listening."
echo -e "3. Or in Terminal, run: ${YELLOW}say \"Hello World\"${NC} or ${YELLOW}vox -f article.txt${NC}"
echo -e "4. Save to MP3: ${YELLOW}vox --save podcast.mp3 \"Some text\"${NC}"
echo -e "\nEnjoy! 🎙️"

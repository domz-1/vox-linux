#!/usr/bin/env bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${RED}Uninstalling Vox Linux...${NC}"

rm -f "$HOME/.local/bin/vox"
rm -f "$HOME/.local/bin/say"
rm -f "$HOME/.local/share/applications/vox.desktop"

echo -e "${GREEN}✓ Vox Linux has been removed.${NC}"

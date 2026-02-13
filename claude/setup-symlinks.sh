#!/bin/bash

# Setup symlinks for Claude CLI config files
# Symlinks all files in this directory to ~/.claude/, excluding this script itself
# Usage: ./setup-symlinks.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
CLAUDE_DIR="$HOME/.claude"

echo -e "${YELLOW}Setting up Claude CLI config symlinks...${NC}"
echo "  Source: $SCRIPT_DIR"
echo "  Target: $CLAUDE_DIR"
echo

# Create Claude directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# Function to create symlink with confirmation
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"

    if [[ -L "$target" ]]; then
        local current_target
        current_target="$(readlink "$target")"
        if [[ "$current_target" == "$source" ]]; then
            echo -e "${GREEN}  ✓ Already linked: $name${NC}"
            return
        fi
        echo -e "${YELLOW}  Symlink already exists: $name${NC}"
        echo "    Current target: $current_target"
        echo "    New target: $source"
        read -p "    Replace? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm "$target"
            ln -sf "$source" "$target"
            echo -e "${GREEN}  ✓ Updated: $name${NC}"
        else
            echo -e "${YELLOW}  - Skipped: $name${NC}"
        fi
    elif [[ -e "$target" ]]; then
        echo -e "${RED}  File exists (not a symlink): $name${NC}"
        echo "    Target: $target"
        read -p "    Replace with symlink? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm "$target"
            ln -sf "$source" "$target"
            echo -e "${GREEN}  ✓ Replaced: $name${NC}"
        else
            echo -e "${YELLOW}  - Skipped: $name${NC}"
        fi
    else
        ln -sf "$source" "$target"
        echo -e "${GREEN}  ✓ Created: $name${NC}"
    fi
}

# Symlink all files in this directory to ~/.claude/, excluding this script
for file in "$SCRIPT_DIR"/*; do
    if [[ -f "$file" ]]; then
        filename="$(basename "$file")"
        # Skip this script and README
        if [[ "$filename" == "$SCRIPT_NAME" || "$filename" == "README.md" ]]; then
            continue
        fi
        create_symlink "$file" "$CLAUDE_DIR/$filename" "$filename"
    fi
done

echo
echo -e "${GREEN}✓ Symlink setup complete!${NC}"
echo
echo "Verify with:"
echo "  ls -la $CLAUDE_DIR | grep -- '->'"

#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Claude Code Config Installer${NC}"
echo "================================"
echo ""

# Detect Claude config directory
if [ -d "$HOME/.claude" ]; then
    CLAUDE_DIR="$HOME/.claude"
elif [ -d "$APPDATA/Claude" ]; then
    CLAUDE_DIR="$APPDATA/Claude"
else
    echo -e "${RED}Error: Could not find Claude Code config directory${NC}"
    echo "Expected: ~/.claude or %APPDATA%/Claude"
    exit 1
fi

echo -e "Claude config directory: ${YELLOW}$CLAUDE_DIR${NC}"
echo ""

# Backup existing config
BACKUP_DIR="$CLAUDE_DIR.backup.$(date +%Y%m%d_%H%M%S)"
echo -e "${YELLOW}Creating backup...${NC}"
if [ -d "$CLAUDE_DIR" ]; then
    cp -r "$CLAUDE_DIR" "$BACKUP_DIR"
    echo -e "${GREEN}Backup created at: $BACKUP_DIR${NC}"
fi
echo ""

# Create directories if they don't exist
mkdir -p "$CLAUDE_DIR"/{agents,commands,skills,templates,knowledge}

# Copy public configs
echo -e "${YELLOW}Installing configurations...${NC}"

echo "  - Copying agents..."
cp -r public/agents/* "$CLAUDE_DIR/agents/" 2>/dev/null || echo "    (no agents to copy)"

echo "  - Copying commands..."
cp -r public/commands/* "$CLAUDE_DIR/commands/" 2>/dev/null || echo "    (no commands to copy)"

echo "  - Copying skills..."
cp -r public/skills/* "$CLAUDE_DIR/skills/" 2>/dev/null || echo "    (no skills to copy)"

echo "  - Copying templates..."
cp -r public/templates/* "$CLAUDE_DIR/templates/" 2>/dev/null || echo "    (no templates to copy)"

echo "  - Copying knowledge..."
cp -r public/knowledge/* "$CLAUDE_DIR/knowledge/" 2>/dev/null || echo "    (no knowledge to copy)"

echo "  - Copying base settings.json..."
if [ ! -f "$CLAUDE_DIR/settings.json" ]; then
    cp public/settings.json "$CLAUDE_DIR/settings.json"
else
    echo -e "    ${YELLOW}settings.json already exists, skipping (see public/settings.json for reference)${NC}"
fi

echo ""

# Copy private templates if they don't exist
echo -e "${YELLOW}Setting up private config templates...${NC}"

if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    cp private-templates/CLAUDE.md.template "$CLAUDE_DIR/CLAUDE.md"
    echo -e "  ${GREEN}✓${NC} Created CLAUDE.md (please customize it!)"
else
    echo -e "  ${YELLOW}!${NC} CLAUDE.md already exists, skipping"
fi

if [ ! -f "$CLAUDE_DIR/settings.local.json" ]; then
    cp private-templates/settings.local.json.template "$CLAUDE_DIR/settings.local.json"
    echo -e "  ${GREEN}✓${NC} Created settings.local.json (please customize it!)"
else
    echo -e "  ${YELLOW}!${NC} settings.local.json already exists, skipping"
fi

echo ""
echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Edit $CLAUDE_DIR/CLAUDE.md with your personal instructions"
echo "  2. Edit $CLAUDE_DIR/settings.local.json with your local settings"
echo "  3. Restart Claude Code to load the new configuration"
echo ""
echo -e "${GREEN}Backup location:${NC} $BACKUP_DIR"

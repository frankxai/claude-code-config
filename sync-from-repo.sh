#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Syncing from repository to ~/.claude...${NC}"
echo ""

# Detect Claude config directory
if [ -d "$HOME/.claude" ]; then
    CLAUDE_DIR="$HOME/.claude"
elif [ -d "$APPDATA/Claude" ]; then
    CLAUDE_DIR="$APPDATA/Claude"
else
    echo "Error: Could not find Claude Code config directory"
    exit 1
fi

# Get script directory (repo root)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${YELLOW}Pulling latest changes...${NC}"
git pull

echo ""
echo -e "${YELLOW}Syncing configurations to $CLAUDE_DIR...${NC}"

# Create directories
mkdir -p "$CLAUDE_DIR"/{agents,commands,skills,templates,knowledge}

# Sync public directories
rsync -av "$REPO_DIR/public/agents/" "$CLAUDE_DIR/agents/" 2>/dev/null || true
echo "  ✓ agents"

rsync -av "$REPO_DIR/public/commands/" "$CLAUDE_DIR/commands/" 2>/dev/null || true
echo "  ✓ commands"

rsync -av "$REPO_DIR/public/skills/" "$CLAUDE_DIR/skills/" 2>/dev/null || true
echo "  ✓ skills"

rsync -av "$REPO_DIR/public/templates/" "$CLAUDE_DIR/templates/" 2>/dev/null || true
echo "  ✓ templates"

rsync -av "$REPO_DIR/public/knowledge/" "$CLAUDE_DIR/knowledge/" 2>/dev/null || true
echo "  ✓ knowledge"

if [ ! -f "$CLAUDE_DIR/settings.json" ]; then
    cp "$REPO_DIR/public/settings.json" "$CLAUDE_DIR/settings.json"
    echo "  ✓ settings.json (new)"
else
    echo "  ! settings.json (exists, not overwriting)"
fi

echo ""
echo -e "${GREEN}✓ Sync complete!${NC}"
echo ""
echo -e "${YELLOW}Remember to customize your private configs:${NC}"
echo "  - $CLAUDE_DIR/CLAUDE.md"
echo "  - $CLAUDE_DIR/settings.local.json"

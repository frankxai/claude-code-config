#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Syncing from ~/.claude to repository...${NC}"
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

echo -e "${YELLOW}Syncing shareable configurations...${NC}"

# Sync public directories
rsync -av --delete "$CLAUDE_DIR/agents/" "$REPO_DIR/public/agents/" 2>/dev/null || true
echo "  ✓ agents"

rsync -av --delete "$CLAUDE_DIR/commands/" "$REPO_DIR/public/commands/" 2>/dev/null || true
echo "  ✓ commands"

rsync -av --delete "$CLAUDE_DIR/skills/" "$REPO_DIR/public/skills/" 2>/dev/null || true
echo "  ✓ skills"

rsync -av --delete "$CLAUDE_DIR/templates/" "$REPO_DIR/public/templates/" 2>/dev/null || true
echo "  ✓ templates"

rsync -av --delete "$CLAUDE_DIR/knowledge/" "$REPO_DIR/public/knowledge/" 2>/dev/null || true
echo "  ✓ knowledge"

cp "$CLAUDE_DIR/settings.json" "$REPO_DIR/public/settings.json" 2>/dev/null || true
echo "  ✓ settings.json"

echo ""
echo -e "${GREEN}✓ Sync complete!${NC}"
echo ""
echo -e "${YELLOW}To commit and push changes:${NC}"
echo "  git add ."
echo "  git commit -m \"Update configs\""
echo "  git push"

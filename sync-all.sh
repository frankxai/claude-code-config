#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Claude Code Repository Sync Tool         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# Detect Claude config directory
if [ -d "$HOME/.claude" ]; then
    CLAUDE_DIR="$HOME/.claude"
elif [ -d "$APPDATA/Claude" ]; then
    CLAUDE_DIR="$APPDATA/Claude"
else
    echo -e "${RED}Error: Could not find Claude Code config directory${NC}"
    exit 1
fi

# Paths
CONFIG_REPO="$HOME/claude-code-config"
SKILLS_REPO="$HOME/claude-skills-library"

echo -e "${YELLOW}📦 Step 1: Syncing claude-code-config...${NC}"
echo ""

if [ ! -d "$CONFIG_REPO" ]; then
    echo -e "${RED}Error: $CONFIG_REPO not found${NC}"
    exit 1
fi

cd "$CONFIG_REPO"

# Pull latest changes first
echo "  Pulling latest changes..."
git pull

# Sync from .claude to repo
echo "  Syncing configurations..."
./sync-to-repo.sh

# Check if there are changes
if [ -n "$(git status --porcelain)" ]; then
    echo "  Staging changes..."
    git add .

    echo "  Committing..."
    COMMIT_MSG="chore: weekly sync - $(date +%Y-%m-%d)"
    git commit -m "$COMMIT_MSG"

    echo "  Pushing to GitHub..."
    git push

    COMMIT_SHA=$(git rev-parse --short HEAD)
    echo -e "${GREEN}  ✓ Pushed to claude-code-config (${COMMIT_SHA})${NC}"
    echo -e "${GREEN}  📎 https://github.com/frankxai/claude-code-config/commit/${COMMIT_SHA}${NC}"
else
    echo -e "${GREEN}  ✓ No changes in claude-code-config${NC}"
fi

echo ""
echo -e "${YELLOW}🧠 Step 2: Syncing claude-skills-library...${NC}"
echo ""

if [ ! -d "$SKILLS_REPO" ]; then
    echo -e "${RED}Error: $SKILLS_REPO not found${NC}"
    exit 1
fi

cd "$SKILLS_REPO"

# Pull latest changes first
echo "  Pulling latest changes..."
git pull

# Copy all skills with SKILL.md
echo "  Copying skills..."
SKILLS_COPIED=0
for skill_dir in "$CLAUDE_DIR/skills"/*/ ; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")

        # Skip if it's just markdown files in skills root
        if [ -f "$skill_dir/SKILL.md" ]; then
            echo "    - $skill_name"
            cp -r "$skill_dir" "$SKILLS_REPO/free-skills/"
            SKILLS_COPIED=$((SKILLS_COPIED + 1))
        fi
    fi
done

echo -e "${GREEN}  ✓ Copied $SKILLS_COPIED skills${NC}"

# Check if there are changes
if [ -n "$(git status --porcelain)" ]; then
    echo "  Staging changes..."
    git add .

    echo "  Committing..."
    COMMIT_MSG="chore: weekly sync - $(date +%Y-%m-%d)"
    git commit -m "$COMMIT_MSG"

    echo "  Pushing to GitHub..."
    git push

    COMMIT_SHA=$(git rev-parse --short HEAD)
    echo -e "${GREEN}  ✓ Pushed to claude-skills-library (${COMMIT_SHA})${NC}"
    echo -e "${GREEN}  📎 https://github.com/frankxai/claude-skills-library/commit/${COMMIT_SHA}${NC}"
else
    echo -e "${GREEN}  ✓ No changes in claude-skills-library${NC}"
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  ✓ Sync Complete!                         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Both repositories are up to date:${NC}"
echo -e "  📦 https://github.com/frankxai/claude-code-config"
echo -e "  🧠 https://github.com/frankxai/claude-skills-library"
echo ""

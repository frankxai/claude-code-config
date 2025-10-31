#!/bin/bash

# Starlight Intelligence System - Installer
# Installs the AI Orchestration Platform for Claude Code
# Version: 1.0.0

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CLAUDE_DIR="$HOME/.claude"
INSTALL_DIR="$CLAUDE_DIR/starlight-intelligence-system"
BACKUP_DIR="$HOME/.claude-backup-$(date +%Y%m%d_%H%M%S)"

# Banner
print_banner() {
    echo -e "${BLUE}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════╗
║                                                       ║
║       🌟 STARLIGHT INTELLIGENCE SYSTEM 🌟            ║
║                                                       ║
║   The AI Orchestration Platform for Claude Code      ║
║                                                       ║
╚═══════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

# Helper functions
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check if Claude Code is installed
check_claude_installed() {
    print_info "Checking for Claude Code installation..."

    if [ ! -d "$CLAUDE_DIR" ]; then
        print_error "Claude Code directory not found at $CLAUDE_DIR"
        print_info "Please install Claude Code first: https://claude.ai/download"
        exit 1
    fi

    print_success "Claude Code detected"
}

# Check system requirements
check_requirements() {
    print_info "Checking system requirements..."

    # Check for required commands
    local missing_commands=()

    for cmd in git cp mv; do
        if ! command -v $cmd &> /dev/null; then
            missing_commands+=($cmd)
        fi
    done

    if [ ${#missing_commands[@]} -ne 0 ]; then
        print_error "Missing required commands: ${missing_commands[*]}"
        exit 1
    fi

    print_success "System requirements met"
}

# Backup existing configuration
backup_existing() {
    print_info "Backing up existing configuration..."

    if [ -d "$CLAUDE_DIR/agents" ] || [ -d "$CLAUDE_DIR/commands" ]; then
        mkdir -p "$BACKUP_DIR"

        [ -d "$CLAUDE_DIR/agents" ] && cp -r "$CLAUDE_DIR/agents" "$BACKUP_DIR/"
        [ -d "$CLAUDE_DIR/commands" ] && cp -r "$CLAUDE_DIR/commands" "$BACKUP_DIR/"
        [ -f "$CLAUDE_DIR/settings.json" ] && cp "$CLAUDE_DIR/settings.json" "$BACKUP_DIR/"

        print_success "Backup created at: $BACKUP_DIR"
    else
        print_info "No existing configuration to backup"
    fi
}

# Create directory structure
create_directories() {
    print_info "Creating directory structure..."

    mkdir -p "$CLAUDE_DIR/agents"
    mkdir -p "$CLAUDE_DIR/commands"
    mkdir -p "$CLAUDE_DIR/templates"

    print_success "Directories created"
}

# Install agents
install_agents() {
    print_info "Installing agents..."

    local agent_count=0

    # Install Tier 1 agents
    for agent in agents/tier-1/*.md; do
        if [ -f "$agent" ]; then
            cp "$agent" "$CLAUDE_DIR/agents/"
            ((agent_count++))
        fi
    done

    # Install Tier 2 agents
    for agent in agents/tier-2/*.md; do
        if [ -f "$agent" ]; then
            cp "$agent" "$CLAUDE_DIR/agents/"
            ((agent_count++))
        fi
    done

    print_success "Installed $agent_count agents"
}

# Install commands
install_commands() {
    print_info "Installing quick-launch commands..."

    local command_count=0

    for command in commands/*.md; do
        if [ -f "$command" ]; then
            cp "$command" "$CLAUDE_DIR/commands/"
            ((command_count++))
        fi
    done

    print_success "Installed $command_count commands"
}

# Install templates
install_templates() {
    print_info "Installing customizable templates..."

    cp -r templates "$CLAUDE_DIR/"

    print_success "Templates installed"
}

# Install documentation
install_documentation() {
    print_info "Installing documentation..."

    if [ -d "docs" ]; then
        mkdir -p "$CLAUDE_DIR/starlight-docs"
        cp -r docs/* "$CLAUDE_DIR/starlight-docs/"
        print_success "Documentation installed"
    else
        print_warning "Documentation not found (optional)"
    fi
}

# Install examples
install_examples() {
    print_info "Installing example workflows..."

    if [ -d "examples" ]; then
        mkdir -p "$CLAUDE_DIR/starlight-examples"
        cp -r examples/* "$CLAUDE_DIR/starlight-examples/"
        print_success "Examples installed"
    else
        print_warning "Examples not found (optional)"
    fi
}

# Update settings.json
update_settings() {
    print_info "Updating Claude Code settings..."

    local settings_file="$CLAUDE_DIR/settings.json"

    # Create backup of settings
    if [ -f "$settings_file" ]; then
        cp "$settings_file" "$settings_file.backup"
    fi

    # Note: Actual settings update would require jq or manual editing
    print_warning "Please manually review and update your settings.json"
    print_info "Recommended: Add MCP server configurations as needed"
}

# Create uninstaller
create_uninstaller() {
    cat > "$CLAUDE_DIR/uninstall-starlight.sh" << 'UNINSTALL_EOF'
#!/bin/bash
# Starlight Intelligence System - Uninstaller

echo "Uninstalling Starlight Intelligence System..."

# Remove agents
rm -rf ~/.claude/agents/strategic-architect.md
rm -rf ~/.claude/agents/creative-alchemist.md
rm -rf ~/.claude/agents/business-oracle.md
rm -rf ~/.claude/agents/integration-specialist.md
rm -rf ~/.claude/agents/full-stack-developer.md
rm -rf ~/.claude/agents/content-creator.md
rm -rf ~/.claude/agents/data-analyst.md
rm -rf ~/.claude/agents/devops-engineer.md
rm -rf ~/.claude/agents/product-manager.md
rm -rf ~/.claude/agents/ux-designer.md
rm -rf ~/.claude/agents/marketing-specialist.md
rm -rf ~/.claude/agents/technical-writer.md

# Remove commands
rm -rf ~/.claude/commands/dev-mode.md
rm -rf ~/.claude/commands/content-mode.md
rm -rf ~/.claude/commands/strategy-mode.md
rm -rf ~/.claude/commands/research-mode.md
rm -rf ~/.claude/commands/council.md

# Remove templates and docs
rm -rf ~/.claude/templates
rm -rf ~/.claude/starlight-docs
rm -rf ~/.claude/starlight-examples

echo "Starlight Intelligence System uninstalled"
echo "Your backup is still available in your backup directory"
UNINSTALL_EOF

    chmod +x "$CLAUDE_DIR/uninstall-starlight.sh"
    print_success "Uninstaller created"
}

# Post-installation info
show_post_install_info() {
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                       ║${NC}"
    echo -e "${GREEN}║          INSTALLATION COMPLETE! 🎉                   ║${NC}"
    echo -e "${GREEN}║                                                       ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}What's Installed:${NC}"
    echo -e "  • 12 Pre-built Agents (4 Tier 1 + 8 Tier 2)"
    echo -e "  • 8 Customizable Templates"
    echo -e "  • 5 Quick-Launch Commands"
    echo -e "  • Documentation & Examples"
    echo ""
    echo -e "${BLUE}Quick Start:${NC}"
    echo -e "  1. Launch Claude Code"
    echo -e "  2. Try: ${YELLOW}/dev-mode${NC} for development"
    echo -e "  3. Try: ${YELLOW}/content-mode${NC} for content creation"
    echo -e "  4. Try: ${YELLOW}/council${NC} for complex decisions"
    echo ""
    echo -e "${BLUE}Available Agents:${NC}"
    echo -e "  Tier 1 Orchestrators:"
    echo -e "    • strategic-architect"
    echo -e "    • creative-alchemist"
    echo -e "    • business-oracle"
    echo -e "    • integration-specialist"
    echo ""
    echo -e "  Tier 2 Specialists:"
    echo -e "    • full-stack-developer"
    echo -e "    • content-creator"
    echo -e "    • data-analyst"
    echo -e "    • devops-engineer"
    echo -e "    • product-manager"
    echo -e "    • ux-designer"
    echo -e "    • marketing-specialist"
    echo -e "    • technical-writer"
    echo ""
    echo -e "${BLUE}Next Steps:${NC}"
    echo -e "  1. ${YELLOW}Activate your license:${NC}"
    echo -e "     ./license/activate-license.sh YOUR_LICENSE_KEY"
    echo ""
    echo -e "  2. ${YELLOW}Read the documentation:${NC}"
    echo -e "     ~/.claude/starlight-docs/getting-started.md"
    echo ""
    echo -e "  3. ${YELLOW}Join the community:${NC}"
    echo -e "     Discord: https://discord.starlight-intelligence.com"
    echo ""
    echo -e "${BLUE}Need Help?${NC}"
    echo -e "  • Docs: https://docs.starlight-intelligence.com"
    echo -e "  • Email: support@starlight-intelligence.com"
    echo -e "  • Discord: Community server"
    echo ""
    echo -e "${YELLOW}Backup Location:${NC} $BACKUP_DIR"
    echo -e "${YELLOW}Uninstall:${NC} ~/.claude/uninstall-starlight.sh"
    echo ""
}

# Main installation flow
main() {
    print_banner

    echo "Starting installation..."
    echo ""

    check_claude_installed
    check_requirements
    backup_existing
    create_directories
    install_agents
    install_commands
    install_templates
    install_documentation
    install_examples
    update_settings
    create_uninstaller

    show_post_install_info
}

# Run installation
main

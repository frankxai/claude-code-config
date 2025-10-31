# Starlight Intelligence System - Windows Installer (PowerShell)
# Installs the AI Orchestration Platform for Claude Code
# Version: 1.0.0

param(
    [switch]$Help,
    [switch]$Uninstall
)

# Configuration
$ClaudeDir = "$env:USERPROFILE\.claude"
$InstallDir = "$ClaudeDir\starlight-intelligence-system"
$BackupDir = "$env:USERPROFILE\.claude-backup-$(Get-Date -Format 'yyyyMMdd_HHmmss')"

# Colors (PowerShell compatible)
function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-ErrorMsg {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Cyan
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ $Message" -ForegroundColor Yellow
}

# Banner
function Show-Banner {
    Write-Host @"

╔═══════════════════════════════════════════════════════╗
║                                                       ║
║       🌟 STARLIGHT INTELLIGENCE SYSTEM 🌟            ║
║                                                       ║
║   The AI Orchestration Platform for Claude Code      ║
║                                                       ║
╚═══════════════════════════════════════════════════════╝

"@ -ForegroundColor Blue
}

# Help
function Show-Help {
    Write-Host @"
Starlight Intelligence System Installer

USAGE:
    .\installer.ps1                 Install Starlight Intelligence System
    .\installer.ps1 -Uninstall      Uninstall Starlight Intelligence System
    .\installer.ps1 -Help           Show this help message

DESCRIPTION:
    Installs the complete Starlight Intelligence System including:
    • 12 Pre-built AI Agents
    • 8 Customizable Templates
    • 5 Quick-Launch Commands
    • Documentation and Examples

REQUIREMENTS:
    • Claude Code installed
    • PowerShell 5.1 or later
    • Windows 10/11

EXAMPLES:
    # Install
    .\installer.ps1

    # Uninstall
    .\installer.ps1 -Uninstall

SUPPORT:
    Email: support@starlight-intelligence.com
    Discord: https://discord.starlight-intelligence.com
    Docs: https://docs.starlight-intelligence.com
"@
}

# Check if Claude Code is installed
function Test-ClaudeInstalled {
    Write-Info "Checking for Claude Code installation..."

    if (-not (Test-Path $ClaudeDir)) {
        Write-ErrorMsg "Claude Code directory not found at $ClaudeDir"
        Write-Info "Please install Claude Code first: https://claude.ai/download"
        exit 1
    }

    Write-Success "Claude Code detected"
}

# Backup existing configuration
function Backup-Existing {
    Write-Info "Backing up existing configuration..."

    $hasExisting = (Test-Path "$ClaudeDir\agents") -or (Test-Path "$ClaudeDir\commands")

    if ($hasExisting) {
        New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null

        if (Test-Path "$ClaudeDir\agents") {
            Copy-Item -Path "$ClaudeDir\agents" -Destination "$BackupDir\" -Recurse
        }
        if (Test-Path "$ClaudeDir\commands") {
            Copy-Item -Path "$ClaudeDir\commands" -Destination "$BackupDir\" -Recurse
        }
        if (Test-Path "$ClaudeDir\settings.json") {
            Copy-Item -Path "$ClaudeDir\settings.json" -Destination "$BackupDir\"
        }

        Write-Success "Backup created at: $BackupDir"
    } else {
        Write-Info "No existing configuration to backup"
    }
}

# Create directory structure
function New-DirectoryStructure {
    Write-Info "Creating directory structure..."

    $dirs = @(
        "$ClaudeDir\agents",
        "$ClaudeDir\commands",
        "$ClaudeDir\templates"
    )

    foreach ($dir in $dirs) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }
    }

    Write-Success "Directories created"
}

# Install agents
function Install-Agents {
    Write-Info "Installing agents..."

    $agentCount = 0

    # Install Tier 1 agents
    $tier1Agents = Get-ChildItem -Path "agents\tier-1\*.md" -ErrorAction SilentlyContinue
    foreach ($agent in $tier1Agents) {
        Copy-Item -Path $agent.FullName -Destination "$ClaudeDir\agents\" -Force
        $agentCount++
    }

    # Install Tier 2 agents
    $tier2Agents = Get-ChildItem -Path "agents\tier-2\*.md" -ErrorAction SilentlyContinue
    foreach ($agent in $tier2Agents) {
        Copy-Item -Path $agent.FullName -Destination "$ClaudeDir\agents\" -Force
        $agentCount++
    }

    Write-Success "Installed $agentCount agents"
}

# Install commands
function Install-Commands {
    Write-Info "Installing quick-launch commands..."

    $commandCount = 0

    $commands = Get-ChildItem -Path "commands\*.md" -ErrorAction SilentlyContinue
    foreach ($command in $commands) {
        Copy-Item -Path $command.FullName -Destination "$ClaudeDir\commands\" -Force
        $commandCount++
    }

    Write-Success "Installed $commandCount commands"
}

# Install templates
function Install-Templates {
    Write-Info "Installing customizable templates..."

    if (Test-Path "templates") {
        Copy-Item -Path "templates\*" -Destination "$ClaudeDir\templates\" -Recurse -Force
        Write-Success "Templates installed"
    } else {
        Write-Warning "Templates directory not found"
    }
}

# Install documentation
function Install-Documentation {
    Write-Info "Installing documentation..."

    if (Test-Path "docs") {
        $docsDir = "$ClaudeDir\starlight-docs"
        if (-not (Test-Path $docsDir)) {
            New-Item -ItemType Directory -Path $docsDir -Force | Out-Null
        }
        Copy-Item -Path "docs\*" -Destination $docsDir -Recurse -Force
        Write-Success "Documentation installed"
    } else {
        Write-Warning "Documentation not found (optional)"
    }
}

# Install examples
function Install-Examples {
    Write-Info "Installing example workflows..."

    if (Test-Path "examples") {
        $examplesDir = "$ClaudeDir\starlight-examples"
        if (-not (Test-Path $examplesDir)) {
            New-Item -ItemType Directory -Path $examplesDir -Force
        }
        Copy-Item -Path "examples\*" -Destination $examplesDir -Recurse -Force
        Write-Success "Examples installed"
    } else {
        Write-Warning "Examples not found (optional)"
    }
}

# Create uninstaller
function New-Uninstaller {
    $uninstallScript = @"
# Starlight Intelligence System - Uninstaller

Write-Host "Uninstalling Starlight Intelligence System..." -ForegroundColor Yellow

# Remove agents
Remove-Item -Path "$ClaudeDir\agents\strategic-architect.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\creative-alchemist.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\business-oracle.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\integration-specialist.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\full-stack-developer.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\content-creator.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\data-analyst.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\devops-engineer.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\product-manager.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\ux-designer.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\marketing-specialist.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\agents\technical-writer.md" -Force -ErrorAction SilentlyContinue

# Remove commands
Remove-Item -Path "$ClaudeDir\commands\dev-mode.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\commands\content-mode.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\commands\strategy-mode.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\commands\research-mode.md" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\commands\council.md" -Force -ErrorAction SilentlyContinue

# Remove templates and docs
Remove-Item -Path "$ClaudeDir\templates" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\starlight-docs" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$ClaudeDir\starlight-examples" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Starlight Intelligence System uninstalled" -ForegroundColor Green
Write-Host "Your backup is still available in your backup directory" -ForegroundColor Cyan
"@

    Set-Content -Path "$ClaudeDir\uninstall-starlight.ps1" -Value $uninstallScript
    Write-Success "Uninstaller created"
}

# Post-installation info
function Show-PostInstallInfo {
    Write-Host ""
    Write-Host "╔═══════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║                                                       ║" -ForegroundColor Green
    Write-Host "║          INSTALLATION COMPLETE! 🎉                   ║" -ForegroundColor Green
    Write-Host "║                                                       ║" -ForegroundColor Green
    Write-Host "╚═══════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "What's Installed:" -ForegroundColor Cyan
    Write-Host "  • 12 Pre-built Agents (4 Tier 1 + 8 Tier 2)"
    Write-Host "  • 8 Customizable Templates"
    Write-Host "  • 5 Quick-Launch Commands"
    Write-Host "  • Documentation & Examples"
    Write-Host ""
    Write-Host "Quick Start:" -ForegroundColor Cyan
    Write-Host "  1. Launch Claude Code"
    Write-Host "  2. Try: " -NoNewline
    Write-Host "/dev-mode" -ForegroundColor Yellow -NoNewline
    Write-Host " for development"
    Write-Host "  3. Try: " -NoNewline
    Write-Host "/content-mode" -ForegroundColor Yellow -NoNewline
    Write-Host " for content creation"
    Write-Host "  4. Try: " -NoNewline
    Write-Host "/council" -ForegroundColor Yellow -NoNewline
    Write-Host " for complex decisions"
    Write-Host ""
    Write-Host "Available Agents:" -ForegroundColor Cyan
    Write-Host "  Tier 1 Orchestrators:"
    Write-Host "    • strategic-architect"
    Write-Host "    • creative-alchemist"
    Write-Host "    • business-oracle"
    Write-Host "    • integration-specialist"
    Write-Host ""
    Write-Host "  Tier 2 Specialists:"
    Write-Host "    • full-stack-developer"
    Write-Host "    • content-creator"
    Write-Host "    • data-analyst"
    Write-Host "    • devops-engineer"
    Write-Host "    • product-manager"
    Write-Host "    • ux-designer"
    Write-Host "    • marketing-specialist"
    Write-Host "    • technical-writer"
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Cyan
    Write-Host "  1. " -NoNewline
    Write-Host "Activate your license:" -ForegroundColor Yellow
    Write-Host "     .\license\activate-license.ps1 YOUR_LICENSE_KEY"
    Write-Host ""
    Write-Host "  2. " -NoNewline
    Write-Host "Read the documentation:" -ForegroundColor Yellow
    Write-Host "     $ClaudeDir\starlight-docs\getting-started.md"
    Write-Host ""
    Write-Host "  3. " -NoNewline
    Write-Host "Join the community:" -ForegroundColor Yellow
    Write-Host "     Discord: https://discord.starlight-intelligence.com"
    Write-Host ""
    Write-Host "Need Help?" -ForegroundColor Cyan
    Write-Host "  • Docs: https://docs.starlight-intelligence.com"
    Write-Host "  • Email: support@starlight-intelligence.com"
    Write-Host "  • Discord: Community server"
    Write-Host ""
    Write-Host "Backup Location: " -ForegroundColor Yellow -NoNewline
    Write-Host $BackupDir
    Write-Host "Uninstall: " -ForegroundColor Yellow -NoNewline
    Write-Host "$ClaudeDir\uninstall-starlight.ps1"
    Write-Host ""
}

# Main installation function
function Install-StarlightSystem {
    Show-Banner

    Write-Host "Starting installation..."
    Write-Host ""

    Test-ClaudeInstalled
    Backup-Existing
    New-DirectoryStructure
    Install-Agents
    Install-Commands
    Install-Templates
    Install-Documentation
    Install-Examples
    New-Uninstaller

    Show-PostInstallInfo
}

# Main entry point
if ($Help) {
    Show-Help
    exit 0
}

if ($Uninstall) {
    & "$ClaudeDir\uninstall-starlight.ps1"
    exit 0
}

Install-StarlightSystem

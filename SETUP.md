# 📖 Setup Guide

Complete guide to installing and customizing your Claude Code configuration.

## Prerequisites

- Claude Code installed ([Get it here](https://claude.ai/code))
- Git (for syncing)
- Bash shell (WSL on Windows, native on Mac/Linux)

## Installation Methods

### Method 1: Quick Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/frankxai/claude-code-config/main/install.sh | bash
```

This will:
1. Detect your Claude config directory
2. Create a timestamped backup
3. Install all agents, commands, skills, templates
4. Create template files for your private configs

### Method 2: Manual Install

```bash
# 1. Clone the repository
git clone https://github.com/frankxai/claude-code-config.git
cd claude-code-config

# 2. Run the installer
chmod +x install.sh
./install.sh

# 3. Customize private configs (see below)
```

### Method 3: Git Submodule (For Your Own Projects)

```bash
# Add as submodule in your dotfiles
git submodule add https://github.com/frankxai/claude-code-config.git ~/.claude-config
cd ~/.claude-config
./install.sh
```

## Post-Installation Setup

### 1. Customize CLAUDE.md

Edit `~/.claude/CLAUDE.md` with your personal instructions:

```bash
nano ~/.claude/CLAUDE.md
```

Update:
- **Project Paths**: Your actual project directories
- **Preferences**: Your preferred frameworks, tools, APIs
- **Custom Instructions**: Any special instructions for Claude

Example:
```markdown
## Project Paths
- **My App**: `/Users/yourname/projects/my-app`
- **Work Project**: `/Users/yourname/work/api-backend`

## Preferences
- **Framework Choices**: Next.js, FastAPI
- **Styling**: Tailwind CSS
- **Backend**: Supabase, PostgreSQL
```

### 2. Configure settings.local.json

Edit `~/.claude/settings.local.json` for machine-specific settings:

```bash
nano ~/.claude/settings.local.json
```

Add your MCP servers, API keys, or local overrides:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token_here"
      }
    }
  }
}
```

### 3. Restart Claude Code

Close and reopen Claude Code to load the new configuration.

## Verification

Test your setup:

```bash
# In Claude Code, try these commands:
/council
```

You should see the Council agents activate. Try other slash commands:
- `/arcanea-dev`
- `/music-production`
- `/ux-design`

## Directory Structure

After installation, your `~/.claude` directory will look like:

```
~/.claude/
├── agents/              # 17 custom agents
├── commands/            # 8 slash commands
├── skills/              # 15+ skills
├── templates/           # Project templates
├── knowledge/           # Knowledge base
├── settings.json        # Base settings
├── CLAUDE.md           # Your private instructions (customize!)
└── settings.local.json # Your local overrides (customize!)
```

## Customization

### Adding Your Own Agents

Create a new file in `~/.claude/agents/`:

```bash
nano ~/.claude/agents/my-custom-agent.md
```

Format:
```markdown
# My Custom Agent

You are an expert in [domain]. Your role is to...

## Capabilities
- Capability 1
- Capability 2

## Tools Available
List of tools this agent should use...
```

Then use it in your code:
```markdown
Use the Task tool with subagent_type="general-purpose" and include:
"Activate my-custom-agent to handle this task"
```

### Adding Slash Commands

Create a new command file:

```bash
nano ~/.claude/commands/my-command.md
```

Add your command instructions:
```markdown
Activate [your workflow description]...
```

Use it:
```bash
/my-command
```

### Adding Skills

Create a skill directory:

```bash
mkdir ~/.claude/skills/my-skill
nano ~/.claude/skills/my-skill/SKILL.md
```

Format:
```markdown
# My Skill

Description of what this skill provides...

## Knowledge Areas
- Area 1
- Area 2

## Usage
How to invoke this skill...
```

### Adding Knowledge

Add markdown files to `~/.claude/knowledge/`:

```bash
nano ~/.claude/knowledge/my-knowledge-base.md
```

Claude will reference these files when needed.

## Syncing Across Machines

### First Machine Setup

1. Install the config
2. Customize your CLAUDE.md and settings.local.json
3. Make changes to agents, commands, skills
4. Sync to your fork:

```bash
cd ~/claude-code-config
./sync-to-repo.sh
git add .
git commit -m "My customizations"
git push origin main
```

### Second Machine Setup

1. Clone YOUR fork:
```bash
git clone https://github.com/YOUR_USERNAME/claude-code-config.git
cd claude-code-config
```

2. Install:
```bash
./install.sh
```

3. Customize CLAUDE.md and settings.local.json for this machine

4. Pull updates anytime:
```bash
./sync-from-repo.sh
```

## Troubleshooting

### Config Not Loading

1. Check file permissions:
```bash
ls -la ~/.claude/
```

2. Verify files exist:
```bash
ls ~/.claude/agents/
ls ~/.claude/commands/
```

3. Check Claude Code logs:
```bash
tail -f ~/.claude/debug/
```

### Slash Commands Not Working

Ensure command files are in `~/.claude/commands/` and formatted correctly (no special characters in filenames, use kebab-case).

### Skills Not Loading

Check that SKILL.md exists in each skill directory:
```bash
find ~/.claude/skills -name "SKILL.md"
```

### MCP Servers Not Connecting

1. Check settings.local.json syntax
2. Verify API tokens are correct
3. Test MCP servers manually:
```bash
npx @modelcontextprotocol/server-github
```

## Backup & Restore

### Create Backup

```bash
cp -r ~/.claude ~/.claude.backup.$(date +%Y%m%d)
```

### Restore Backup

```bash
rm -rf ~/.claude
cp -r ~/.claude.backup.YYYYMMDD ~/.claude
```

### Automated Backups

The installer creates automatic backups. Find them:
```bash
ls -d ~/.claude.backup.*
```

## Updating

### Update from Main Repo

```bash
cd ~/claude-code-config
git pull origin main
./sync-from-repo.sh
```

### Keep Your Fork Synced

```bash
# Add upstream remote
git remote add upstream https://github.com/frankxai/claude-code-config.git

# Fetch and merge updates
git fetch upstream
git merge upstream/main

# Push to your fork
git push origin main
```

## Advanced Configuration

### Custom Permission Rules

Edit `~/.claude/settings.json`:

```json
{
  "permissionRules": [
    {
      "tool": "mcp__your_tool",
      "permission": "ask",
      "comment": "Require confirmation for this tool"
    }
  ]
}
```

### MCP Server Management

Configure auto-enable/disable:

```json
{
  "mcpManagement": {
    "defaultBehavior": "disabled",
    "enableOnMention": true,
    "disableWhenIdle": true,
    "idleTimeoutMinutes": 30
  }
}
```

### Environment Variables

Add to `~/.claude/settings.local.json`:

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["server.js"],
      "env": {
        "API_KEY": "${YOUR_API_KEY}",
        "DEBUG": "true"
      }
    }
  }
}
```

## Next Steps

1. **Explore the Agents**: Try different agents for various tasks
2. **Create Custom Commands**: Build slash commands for your workflows
3. **Add Your Skills**: Document your expertise as skills
4. **Join the Community**: Share your agents and improvements
5. **Star the Repo**: Help others discover this config

## Support

- **Issues**: [GitHub Issues](https://github.com/frankxai/claude-code-config/issues)
- **Questions**: [GitHub Discussions](https://github.com/frankxai/claude-code-config/discussions)
- **Updates**: Watch the repo for new features

---

[← Back to README](./README.md) | [Skills Guide →](./docs/SKILLS_GUIDE.md)

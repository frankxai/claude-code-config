# 🤖 Automation Guide

Automate your Claude Code repository syncing with weekly or on-demand updates.

## Quick Sync

### Manual Sync (Anytime)

#### Option 1: Use the Slash Command
In Claude Code:
```bash
/sync-repos
```

Claude will execute the full sync workflow and report results.

#### Option 2: Run the Script
```bash
cd /home/user/claude-code-config
./sync-all.sh
```

This syncs both repos in one command.

#### Option 3: Individual Repos
```bash
# Sync just claude-code-config
cd /home/user/claude-code-config
./sync-to-repo.sh
git add . && git commit -m "Update configs" && git push

# Sync just claude-skills-library
cd /home/user/claude-skills-library
cp -r ~/.claude/skills/*/ free-skills/
git add . && git commit -m "Update skills" && git push
```

## Automated Weekly Sync

### Linux/WSL (cron)

#### 1. Edit crontab
```bash
crontab -e
```

#### 2. Add weekly sync (every Sunday at 10 PM)
```bash
0 22 * * 0 /home/user/claude-code-config/sync-all.sh >> /home/user/claude-sync.log 2>&1
```

Or every Friday at 5 PM:
```bash
0 17 * * 5 /home/user/claude-code-config/sync-all.sh >> /home/user/claude-sync.log 2>&1
```

#### 3. View sync logs
```bash
tail -f ~/claude-sync.log
```

#### Cron Schedule Examples
```bash
# Every Sunday at 10 PM
0 22 * * 0 /path/to/sync-all.sh

# Every Friday at 5 PM
0 17 * * 5 /path/to/sync-all.sh

# Every Monday at 9 AM
0 9 * * 1 /path/to/sync-all.sh

# Every day at midnight
0 0 * * * /path/to/sync-all.sh

# Every 3 days at noon
0 12 */3 * * /path/to/sync-all.sh
```

### macOS (launchd)

#### 1. Create launch agent
```bash
nano ~/Library/LaunchAgents/com.frankx.claude-sync.plist
```

#### 2. Add configuration
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.frankx.claude-sync</string>

    <key>ProgramArguments</key>
    <array>
        <string>/Users/yourname/claude-code-config/sync-all.sh</string>
    </array>

    <key>StartCalendarInterval</key>
    <dict>
        <key>Weekday</key>
        <integer>0</integer> <!-- Sunday -->
        <key>Hour</key>
        <integer>22</integer> <!-- 10 PM -->
        <key>Minute</key>
        <integer>0</integer>
    </dict>

    <key>StandardOutPath</key>
    <string>/Users/yourname/claude-sync.log</string>

    <key>StandardErrorPath</key>
    <string>/Users/yourname/claude-sync-error.log</string>
</dict>
</plist>
```

#### 3. Load the agent
```bash
launchctl load ~/Library/LaunchAgents/com.frankx.claude-sync.plist
```

#### 4. Check status
```bash
launchctl list | grep claude-sync
```

### Windows (Task Scheduler)

#### 1. Create PowerShell wrapper
Save as `C:\Users\YourName\claude-sync.ps1`:

```powershell
# Set execution policy for this script
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Change to WSL and run sync
wsl -e /home/user/claude-code-config/sync-all.sh

# Log output
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path "$env:USERPROFILE\claude-sync.log" -Value "$timestamp - Sync completed"
```

#### 2. Open Task Scheduler
- Press `Win + R`
- Type `taskschd.msc`
- Press Enter

#### 3. Create New Task
- **General Tab:**
  - Name: `Claude Code Weekly Sync`
  - Description: `Sync Claude Code configs and skills to GitHub`
  - Run whether user is logged on or not: ✓

- **Triggers Tab:**
  - New → Weekly
  - Start date: [Today]
  - Time: 10:00 PM
  - Days: Sunday (or your preferred day)

- **Actions Tab:**
  - New → Start a program
  - Program: `powershell.exe`
  - Arguments: `-ExecutionPolicy Bypass -File "C:\Users\YourName\claude-sync.ps1"`

- **Conditions Tab:**
  - Start only if computer is on AC power: ✓
  - Wake computer to run: ✓ (optional)

- **Settings Tab:**
  - Allow task to be run on demand: ✓
  - If task fails, restart every: 10 minutes

#### 4. Test the task
Right-click → Run

#### 5. View logs
```powershell
Get-Content $env:USERPROFILE\claude-sync.log -Tail 50
```

## Git Automation (Advanced)

### Auto-commit on Changes

Add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "afterToolCall": {
      "Write(~/.claude/agents/*)": {
        "command": "cd /home/user/claude-code-config && ./sync-all.sh",
        "async": true
      },
      "Write(~/.claude/skills/*)": {
        "command": "cd /home/user/claude-code-config && ./sync-all.sh",
        "async": true
      },
      "Write(~/.claude/commands/*)": {
        "command": "cd /home/user/claude-code-config && ./sync-all.sh",
        "async": true
      }
    }
  }
}
```

This auto-syncs whenever you create/modify agents, skills, or commands.

### Pre-commit Hooks

For quality checks before syncing:

```bash
cd /home/user/claude-code-config
nano .git/hooks/pre-commit
```

Add:
```bash
#!/bin/bash
# Validate all markdown files
find public -name "*.md" -exec mdl {} \;

# Validate JSON files
find public -name "*.json" -exec jq . {} \; > /dev/null

# Check for private info leaks
if grep -r "ghp_\|sk-\|GITHUB_TOKEN" public/; then
    echo "ERROR: Found potential secrets in public files!"
    exit 1
fi

exit 0
```

Make executable:
```bash
chmod +x .git/hooks/pre-commit
```

## Monitoring & Notifications

### Slack Notifications

Add to `sync-all.sh` before the final echo:

```bash
# Send Slack notification
SLACK_WEBHOOK="your_webhook_url"
curl -X POST -H 'Content-type: application/json' \
  --data "{\"text\":\"✅ Claude Code repos synced successfully\"}" \
  "$SLACK_WEBHOOK"
```

### Email Notifications

Using `mailx`:

```bash
# At end of sync-all.sh
echo "Claude Code sync completed successfully" | \
  mailx -s "Claude Code Sync - $(date +%Y-%m-%d)" your@email.com
```

### Discord Notifications

```bash
DISCORD_WEBHOOK="your_webhook_url"
curl -X POST -H "Content-Type: application/json" \
  -d '{"content":"✅ Claude Code repos synced!"}' \
  "$DISCORD_WEBHOOK"
```

## Backup Before Sync

Add safety backup to `sync-all.sh`:

```bash
# Before any git operations
BACKUP_DIR="$HOME/claude-backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp -r ~/.claude "$BACKUP_DIR/"
echo "Backup created at: $BACKUP_DIR"
```

Keep last 10 backups:
```bash
# Cleanup old backups (keep last 10)
ls -dt $HOME/claude-backups/* | tail -n +11 | xargs rm -rf
```

## Troubleshooting

### Cron Job Not Running

Check cron service:
```bash
sudo service cron status
sudo service cron start
```

View cron logs:
```bash
grep CRON /var/log/syslog
```

Test cron command manually:
```bash
/home/user/claude-code-config/sync-all.sh
```

### Permission Errors

Fix script permissions:
```bash
chmod +x /home/user/claude-code-config/sync-all.sh
chmod +x /home/user/claude-code-config/sync-to-repo.sh
```

### Git Authentication

For automated pushes, use SSH keys:

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your@email.com"

# Add to GitHub
cat ~/.ssh/id_ed25519.pub
# Copy and add at https://github.com/settings/keys

# Update remote to use SSH
cd /home/user/claude-code-config
git remote set-url origin git@github.com:frankxai/claude-code-config.git

cd /home/user/claude-skills-library
git remote set-url origin git@github.com:frankxai/claude-skills-library.git
```

Or use credential helper:
```bash
git config --global credential.helper store
# Run sync once manually to save credentials
```

## Best Practices

1. **Test First**: Run `./sync-all.sh` manually before automating
2. **Monitor Logs**: Check sync logs regularly
3. **Backup**: Keep backups before major syncs
4. **Notifications**: Set up alerts for failures
5. **Review Commits**: Periodically review what's being synced
6. **Clean History**: Occasionally review and clean commit history

## Quick Reference

```bash
# Manual sync (both repos)
/sync-repos                          # In Claude Code
./sync-all.sh                        # Direct script

# View last sync
git log -1                           # In either repo

# Check what would be synced
git status                           # See pending changes

# View sync logs
tail -f ~/claude-sync.log            # On Linux/macOS
Get-Content $env:USERPROFILE\claude-sync.log -Tail 50  # Windows

# Force sync now
./sync-all.sh                        # Run immediately

# Disable automation
crontab -e                           # Comment out the line
launchctl unload ~/Library/LaunchAgents/com.frankx.claude-sync.plist  # macOS
# Or disable in Task Scheduler (Windows)
```

---

[← Back to README](./README.md) | [Setup Guide](./SETUP.md)

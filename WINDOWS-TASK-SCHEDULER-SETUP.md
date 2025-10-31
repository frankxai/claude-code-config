# 🪟 Windows Task Scheduler Setup

Since you're on WSL, here's how to set up Friday 5 PM auto-sync using Windows Task Scheduler.

## Quick Setup (5 minutes)

### Step 1: Verify PowerShell Script

The script is already created at:
```
C:\Users\Frank\claude-sync.ps1
```

### Step 2: Create Scheduled Task

#### Option A: Import XML (Fastest)

1. Save this XML as `C:\Users\Frank\claude-sync-task.xml`:

```xml
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Description>Weekly sync of Claude Code configurations and skills to GitHub - Every Friday at 5 PM</Description>
    <URI>\Claude Code Weekly Sync</URI>
  </RegistrationInfo>
  <Triggers>
    <CalendarTrigger>
      <StartBoundary>2025-11-07T17:00:00</StartBoundary>
      <Enabled>true</Enabled>
      <ScheduleByWeek>
        <DaysOfWeek>
          <Friday />
        </DaysOfWeek>
        <WeeksInterval>1</WeeksInterval>
      </ScheduleByWeek>
    </CalendarTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>LeastPrivilege</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>true</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>false</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT1H</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>powershell.exe</Command>
      <Arguments>-ExecutionPolicy Bypass -File "C:\Users\Frank\claude-sync.ps1"</Arguments>
    </Exec>
  </Actions>
</Task>
```

2. Open PowerShell as Administrator:
```powershell
# Import the task
Register-ScheduledTask -Xml (Get-Content "C:\Users\Frank\claude-sync-task.xml" | Out-String) -TaskName "Claude Code Weekly Sync"
```

#### Option B: Manual Setup (7 minutes)

1. **Open Task Scheduler**
   - Press `Win + R`
   - Type: `taskschd.msc`
   - Press Enter

2. **Create Task**
   - Click "Create Task" (not "Create Basic Task")

3. **General Tab**
   - Name: `Claude Code Weekly Sync`
   - Description: `Weekly sync of Claude Code configurations and skills to GitHub - Every Friday at 5 PM`
   - ✅ Run whether user is logged on or not
   - ✅ Run with highest privileges (if you want)
   - Configure for: Windows 10

4. **Triggers Tab**
   - Click "New..."
   - Begin the task: `On a schedule`
   - Settings: ⚪ Weekly
   - Recur every: `1 weeks`
   - Days: ✅ Friday
   - Start: `5:00:00 PM`
   - ✅ Enabled
   - Click OK

5. **Actions Tab**
   - Click "New..."
   - Action: `Start a program`
   - Program/script: `powershell.exe`
   - Add arguments: `-ExecutionPolicy Bypass -File "C:\Users\Frank\claude-sync.ps1"`
   - Click OK

6. **Conditions Tab**
   - ❌ Start the task only if the computer is on AC power (uncheck this!)
   - ✅ Start the task only if the network is available
   - ❌ Wake the computer to run this task (optional)

7. **Settings Tab**
   - ✅ Allow task to be run on demand
   - ✅ Run task as soon as possible after a scheduled start is missed
   - ✅ If the task fails, restart every: 10 minutes
   - Attempt to restart up to: 3 times
   - Stop the task if it runs longer than: 1 hour
   - If the running task does not end when requested: Stop the task

8. **Click OK**
   - Enter your Windows password if prompted

### Step 3: Test the Task

1. **Run Once Manually**
   - Find "Claude Code Weekly Sync" in Task Scheduler
   - Right-click → Run
   - Watch for PowerShell window (brief flash)

2. **Check Results**
   - Open: `C:\Users\Frank\claude-sync.log`
   - Should see: `✅ Sync completed successfully`

3. **Verify on GitHub**
   - https://github.com/frankxai/claude-code-config/commits/main
   - https://github.com/frankxai/claude-skills-library/commits/main

### Step 4: View Sync History

**Check last run:**
```powershell
Get-ScheduledTaskInfo -TaskName "Claude Code Weekly Sync"
```

**View sync log:**
```powershell
Get-Content $env:USERPROFILE\claude-sync.log -Tail 20
```

**Test immediately:**
```powershell
Start-ScheduledTask -TaskName "Claude Code Weekly Sync"
```

## Troubleshooting

### Task Doesn't Run

**Check task status:**
```powershell
Get-ScheduledTask -TaskName "Claude Code Weekly Sync" | Select-Object State, LastRunTime, LastTaskResult
```

**View task history:**
- Task Scheduler → Select your task
- Click "History" tab (bottom)
- Look for errors

**Common issues:**

1. **WSL not starting**
   - Ensure WSL is installed: `wsl --list`
   - Test: `wsl echo "test"`

2. **Git authentication**
   - Run sync manually once: `wsl -e /home/user/claude-code-config/sync-all.sh`
   - This saves Git credentials

3. **PowerShell execution policy**
   - Run as admin: `Set-ExecutionPolicy RemoteSigned`

### Sync Fails

**Run manually to debug:**
```powershell
cd C:\Users\Frank
.\claude-sync.ps1
```

**Check WSL:**
```powershell
wsl -e /home/user/claude-code-config/sync-all.sh
```

**View detailed errors:**
```bash
# In WSL
tail -f /home/user/claude-sync.log
```

## Alternative: Manual Reminder

If Task Scheduler seems complex, just set a calendar reminder:

**Every Friday at 4:50 PM:**
- Reminder: "Sync Claude Code"
- Action: Run `/sync-repos` in Claude Code

## Notifications (Optional)

### Desktop Notification

Add to `claude-sync.ps1` after successful sync:

```powershell
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    "Claude Code repos synced to GitHub!",
    "Sync Complete",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
)
```

### Toast Notification (Windows 10+)

```powershell
$null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
$Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)

$RawXml = [xml] $Template.GetXml()
($RawXml.toast.visual.binding.text|where {$_.id -eq "1"}).AppendChild($RawXml.CreateTextNode("Claude Code Sync")) > $null
($RawXml.toast.visual.binding.text|where {$_.id -eq "2"}).AppendChild($RawXml.CreateTextNode("Repos synced to GitHub successfully!")) > $null

$SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
$SerializedXml.LoadXml($RawXml.OuterXml)

$Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml)
$Toast.Tag = "ClaudeSync"
$Toast.Group = "ClaudeCode"
$Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(5)

$Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Claude Code Sync")
$Notifier.Show($Toast)
```

## Schedule Variations

Want different timing? Modify the trigger:

**Every Monday morning (9 AM):**
- Days: Monday
- Start: 9:00:00 AM

**Twice a week (Wed & Fri):**
- Days: ✅ Wednesday, ✅ Friday
- Start: 5:00:00 PM

**Daily at midnight:**
- Settings: ⚪ Daily
- Recur every: 1 days
- Start: 12:00:00 AM

## Summary

✅ **Script created:** `C:\Users\Frank\claude-sync.ps1`
✅ **Schedule:** Every Friday at 5:00 PM
✅ **Syncs:** Both claude-code-config and claude-skills-library
✅ **Logs:** `C:\Users\Frank\claude-sync.log`

**Next Friday at 5 PM**, your Claude Code will automatically sync to GitHub! 🎉

**To test now:**
```powershell
Start-ScheduledTask -TaskName "Claude Code Weekly Sync"
```

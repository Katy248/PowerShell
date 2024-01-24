$InformationPreference = 'Continue'
<# Current path from which user runs script #>
$callPath = Get-Location
<# Go to profile directory #>
Set-Location -Path $PROFILE.Replace("Microsoft.PowerShell_profile.ps1", "")

./Set-Theme.ps1 -ThemeFilePath "~/.themes/current/pwsh/theme.omp.json"

<# Windows only #>
if ($IsWindows) {
    Set-Alias lvim 'C:\Users\Katy\.local\bin\lvim.ps1'
}
else {
    Set-Alias thm '~/ThemeManager/ThemeManager.Cli/bin/Release/net8.0/thm'
}

<# Return to start path #>
Set-Location -Path $callPath

Start-Sleep -Seconds 0.8
Clear-Host

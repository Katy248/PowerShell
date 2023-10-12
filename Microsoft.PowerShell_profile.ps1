<# Current path from which user runs script #>
$callPath = Get-Location
<# Go to profile directory #>
Set-Location -Path $PROFILE.Replace("Microsoft.PowerShell_profile.ps1", "")


$themeParams = @{
    ThemeRepository = "https://github.com/Katy248/kvtheme" 
    Clear           = $True 
    WaitSeconds     = 0
    EnableLogs      = $False 
}

./CustomShell.ps1 @themeParams

<# Windows only #>
if ($IsWindows) {
    Set-Alias lvim 'C:\Users\Katy\.local\bin\lvim.ps1'
}

<# Return to start path #>
Set-Location -Path $callPath

param(
    [string]$ThemeRepositoryPath,
    [bool]$Clear = $True,
    [double]$WaitSeconds = 0.8,
    [string]$PrimaryColor = "Magenta",
    [string]$InfoColor = "Cyan",
    [string]$SecondaryColor = "DarkGray",
    [bool]$EnableLogs = $False
)

function Log {
    param (
        [string]$Message
    )
    if ([bool]$EnableLogs) {
        Write-Host $Message -ForegroundColor $InfoColor
    }
}

$currentWorkingDirectory = Get-Location

$themeDirectory = "$PROFILE.themes/current"

if (Test-Path -Path "$themeDirectory/.git") {
    
    Set-Location $themeDirectory
    
    $remote = (git remote get-url origin | Out-String).Trim()

    Write-Host "Current remote '$remote'" -ForegroundColor $PrimaryColor

    if ($remote -eq $ThemeRepositoryPath) {
        Log -Message "Pulling remote repository to '$themeDirectory'"
        git pull
    }
    else {
        if ($EnableLogs) { Write-Host "Delete current remote '$remote'" -ForegroundColor $InfoColor }
        Remove-Item -Force -Recurse -Path $themeDirectory
        
        Log -Message "Cloning new remote '$ThemeRepositoryPath'"
        git clone $ThemeRepositoryPath $themeDirectory
    }
}
else {
    Log -Message "Cloning remote '$ThemeRepositoryPath'"
    git clone $ThemeRepositoryPath $themeDirectory
}

Log -Message "Initializing theme '$themeDirectory/theme.omp.json'"
oh-my-posh init pwsh --config "$themeDirectory/theme.omp.json" | Invoke-Expression

Write-Host "Done" -ForegroundColor $PrimaryColor

if ([bool]$Clear) {
    Write-Host "Wait $WaitSeconds s" -ForegroundColor $SecondaryColor
    Start-Sleep -Seconds $WaitSeconds

    Clear-Host
}
Set-Location $currentWorkingDirectory





<#if ($ThemeFilePath) {
    New-Item -Path $themeDirectory -ItemType Directory -Force | Select-Object FullName
    Write-Host "Copy $ThemeFilePath to $themeDirectory/"
    Copy-Item -Path $ThemeFilePath -Destination "$themeDirectory"
}#>

<# Write-Host "Removing theme directory $themeDirectory" -ForegroundColor green
 #>

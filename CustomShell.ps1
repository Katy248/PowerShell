param(
    [string]$ThemeName,
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

$themeDirectory = "$HOME/.themes/powershell"


if ($ThemeName) {
    Log "Initialize default theme '$ThemeName'"
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/$ThemeName.omp.json" | Invoke-Expression
}
elseif ($ThemeRepositoryPath) {
    if (Test-Path -Path "$themeDirectory/.git") {
        
        Set-Location $themeDirectory
        
        $remote = (git remote get-url origin | Out-String).Trim()

        Write-Host "Current remote '$remote'" -ForegroundColor $PrimaryColor

        if ($remote -eq $ThemeRepositoryPath) {
            Log -Message "Pulling remote repository to '$themeDirectory'"
            git pull
        }
        else {
            Log "Delete current remote '$remote'"   
            Remove-Item -Force -Recurse -Path $themeDirectory

            Log "Cloning new remote '$ThemeRepositoryPath'"
            git clone $ThemeRepositoryPath $themeDirectory
        }
    }
    else {
        Log -Message "Cloning remote '$ThemeRepositoryPath'"
        git clone $ThemeRepositoryPath $themeDirectory
    }
}

Log "Initializing theme '$themeDirectory/theme.omp.json'"
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

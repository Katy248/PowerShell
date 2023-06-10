param(
    [string]$ThemeFilePath,
    [string]$ThemeRepositoryPath,
    [bool]$Clear = $True
)
$themeDirectory = "$PROFILE.themes/current"

Write-Host "Removing theme directory $themeDirectory" -ForegroundColor green
Remove-Item -Force -Recurse -Path $themeDirectory

if ($ThemeFilePath) {
    New-Item -Path $themeDirectory -ItemType Directory -Force | Select-Object FullName
    Write-Host "Copy $ThemeFilePath to $themeDirectory/"
    Copy-Item -Path $ThemeFilePath -Destination "$themeDirectory"
}
else {
    git clone $ThemeRepositoryPath $themeDirectory
}

Write-Host "Initializing theme '$themeDirectory/theme.omp.json'" -ForegroundColor green
oh-my-posh init pwsh --config "$themeDirectory/theme.omp.json" | Invoke-Expression

Write-Host "Done" -ForegroundColor green

Start-Sleep -Seconds 0.8

if ([bool]$Clear) {
    Clear-Host
}

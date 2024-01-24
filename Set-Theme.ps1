param(
    [string]$ThemeFilePath
)

function InitializeTheme {
    oh-my-posh init pwsh --config "$ThemeFilePath" | Invoke-Expression
}

Write-Information "Start initializing theme with config: '$ThemeFilePath'"

if (Test-Path -Path $ThemeFilePath) {
    InitializeTheme
    Write-Information "Done"
}
else {
    Write-Warning -Message "File '$ThemeFilePath' doesn't exists"
}

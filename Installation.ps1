if ($IsWindows) {
    choco install oh-my-posh    
}
if ($IsLinux) {
    sudo apt install oh-my-posh
    sudo dnf install oh-my-posh
}

. $PROFILE

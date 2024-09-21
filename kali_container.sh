#!/bin/bash
# Check if we are in Kali Linux
if [ -f /etc/os-release ] && grep -q "Kali" /etc/os-release; then
    # Check if the packages are not already installed
    if ! dpkg -s neovim tealdeer zoxide zsh-autosuggestions zsh-syntax-highlighting bat >/dev/null 2>&1; then
        # Install zsh-related packages if shell is 'zsh'
        if [ "$SHELL" = "/usr/bin/zsh" ]; then
            sudo apt install zsh-autosuggestions zsh-syntax-highlighting
        fi
        sudo apt install neovim tealdeer zoxide bat
    else
        echo "Packages are already installed. Skipping installation."
    fi
else
    echo "Not running on Kali Linux. Skipping installation."
fi

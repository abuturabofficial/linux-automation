#!/bin/bash

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. Re-running with sudo..."
    exec sudo "$0" "$@"
fi

set -e

# Check if we are in Kali Linux
if [ -f /etc/os-release ] && grep -q "Kali" /etc/os-release; then

    # Update package list
    echo "Updating package list..."
    sudo apt update

    # Check if the packages are already installed
    if ! dpkg-query -W -f='${Status}' neovim tealdeer zoxide zsh-autosuggestions zsh-syntax-highlighting bat 2>/dev/null | grep -q "install ok installed"; then
        
        # Check if the shell is Zsh and install Zsh-related packages
        if [ "$SHELL" = "/usr/bin/zsh" ]; then
            echo "Zsh detected. Installing Zsh-related packages..."
            sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting
        fi

        # Install other packages
        echo "Installing neovim, tealdeer, zoxide, and bat..."
        sudo apt install -y neovim tealdeer zoxide bat
    else
        echo "Packages are already installed. Skipping installation."
    fi

else
    echo "Not running on Kali Linux. Skipping installation."
fi
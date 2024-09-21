#!/bin/bash

# Moving to a /tmp DIR
#
echo "Moving inside /tmp DIR"
cd /tmp

# Check if yay is already installed
if ! command -v yay &> /dev/null; then
    # Cloning the yay-bin repo
    echo "Cloning the yay-bin"
    git clone https://aur.archlinux.org/yay-bin.git

    # Installing yay-bin
    #
    echo "Moving inside yay-bin DIR"
    cd /tmp/yay-bin/

    echo "Building and Installing yay-bin"
    makepkg -sri
else
    echo "yay is already installed"
fi

# Check if the previous commands were successful
if [ $? -eq 0 ]; then
    echo "AUR Helper Successfully Installed"
else
    echo "Failed to install AUR Helper"
    exit 1
fi

# Now installing packages from AUR
#
if ! command -v hstr &> /dev/null; then
    yay -S hstr
else
    echo "hstr is already installed"
fi

if ! command -v jekyll &> /dev/null; then
    yay -S jekyll
else
    echo "jekyll is already installed"
fi

# Check if ~/.local/bin directory exists, if not create it
if [ ! -d "$HOME/.local/bin" ]; then
    mkdir -p "$HOME/.local/bin"
fi

# Function to check if a package is already exported
is_package_exported() {
    local package_name=$1
    local export_dir="$HOME/.local/bin"
    if [ -f "$export_dir/$package_name" ]; then
        return 0
    else
        return 1
    fi
}

# Install required packages if not already installed and not exported
install_package() {
    local package_name=$1
    local executable_name=$2
    local install_command=$3
    if ! command -v "$executable_name" &> /dev/null; then
        if ! is_package_exported "$package_name"; then
            sudo pacman -S "$package_name"
        else
            echo "$package_name is already exported"
        fi
    else
        echo "$package_name is already installed"
    fi
}

# Install required packages if not already installed and not exported
install_package lsd lsd "sudo pacman -S lsd"
install_package bat bat "sudo pacman -S bat"
install_package zoxide zoxide "sudo pacman -S zoxide"
install_package fzf fzf "sudo pacman -S fzf"
install_package ripgrep rg "sudo pacman -S ripgrep"
install_package starship starship "sudo pacman -S starship"
install_package neovim nvim "sudo pacman -S neovim"
install_package tealdeer tldr "sudo pacman -S tealdeer"

# To export BIN to host
export_package() {
    local package_name=$1
    local export_dir="$HOME/.local/bin"
    if ! is_package_exported "$package_name"; then
        distrobox-export --bin "/usr/bin/$package_name" "$export_dir"
    else
        echo "$package_name is already exported"
    fi
}

export_package nvim
export_package lsd
export_package zoxide
export_package tldr
export_package hstr
export_package bat

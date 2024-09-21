#!/bin/bash

set -e

# Moving to /tmp DIR
echo "Moving inside /tmp DIR"
cd /tmp

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "Cloning yay-bin"
    git clone https://aur.archlinux.org/yay-bin.git

    echo "Building and installing yay-bin"
    cd /tmp/yay-bin/
    makepkg -sri
else
    echo "yay is already installed"
fi

# Install packages with yay
yay -S --needed hstr jekyll

# Ensure ~/.local/bin exists
mkdir -p "$HOME/.local/bin"

# Function to check if package is already exported
is_package_exported() {
    [[ -f "$HOME/.local/bin/$1" ]]
}

# Install required packages if not already installed/exported
install_package() {
    local package_name=$1
    local executable_name=$2
    if ! command -v "$executable_name" &> /dev/null && ! is_package_exported "$package_name"; then
        sudo pacman -S "$package_name"
    else
        echo "$package_name is already installed or exported"
    fi
}

install_package lsd lsd
install_package bat bat
install_package zoxide zoxide
install_package fzf fzf
install_package ripgrep rg
install_package starship starship
install_package neovim nvim
install_package tealdeer tldr

# Export packages using distrobox-export
export_package() {
    local package_name=$1
    if ! is_package_exported "$package_name"; then
        distrobox-export --bin "/usr/bin/$package_name" "$HOME/.local/bin"
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


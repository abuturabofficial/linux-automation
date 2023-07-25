#!/bin/bash

sudo dnf upgrade

# zsh, zsh-autosuggestions, zsh-syntax-highlighting, zoxide
#
echo "Installing zsh, zsh-autosuggestions, zsh-syntax-highlighting Zoxide"
sudo dnf install zoxide zsh zsh-autosuggestions zsh-syntax-highlighting

# VS Code
#
echo "Enabling Visual Studio Code Repo Fedora Container"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

echo "Intalling the Visual Studio Code binary on Fedora Container"
sudo dnf check-update
sudo dnf instal code

# Neovim
#
sudo dnf install neovim

# Starship
#
echo "Adding Starship repo and Installing the package"
sudo dnf copr enable atim/starship
sudo dnf install starship

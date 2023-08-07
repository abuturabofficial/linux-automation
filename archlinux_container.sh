#!/bin/bash

# Moving to a /tmp DIR
#
echo "Moving inside /tmp DIR"
cd /tmp

# Cloning the yay-bin repo
echo "Cloning the yay-bin"
git clone https://aur.archlinux.org/yay-bin.git

# Installing yay-bin
#
echo "Moving inside yay-bin DIR"
cd /tmp/yay-bin/

echo "Building and Installing yay-bin"
makepkg -sri

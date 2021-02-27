#! /bin/bash

# Fail script if any command fails
set -e

# Setup Packages for Arch

## Upgrade everything
sudo pacman --noconfirm -Syu

## Install Main packages I want
sudo pacman --noconfirm -S yay
sudo pacman --noconfirm -S base-devel
sudo pacman --noconfirm -S stow
sudo pacman --noconfirm -S python
sudo pacman --noconfirm -S python-pip
sudo pacman --noconfirm -S figlet
sudo pacman --noconfirm -S fd
sudo pacman --noconfirm -S tmux
sudo pacman --noconfirm -S zip
sudo pacman --noconfirm -S unzip

## Update everything in the AUR
yay --noconfirm -Syu

## Install AUR packages I want
yay --noconfirm -S neovim-nightly-bin
yay --noconfirm -S google-chrome
# yay --noconfirm -S discord
# yay --noconfirm -S slack-desktop
# yay --noconfirm -S poppler
# yay --noconfirm -S pdfjam
# yay --noconfirm -S glogg

## Required for initial_setup.py
sudo pip install PyYAML

## Required for Neovim
sudo pip install neovim
sudo pacman --noconfirm -S nodejs
sudo pacman --noconfirm -S npm
sudo npm install -g neovim
sudo pacman --noconfirm -S ruby
gem install neovim
sudo pacman --noconfirm -S perl
yay --noconfirm -S cpanminus
sudo cpanm Neovim::Ext
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
# Can't use noconfirm with this because it defaults to N to delete vi and Vim
# yay --noconfirm -S neovim-symlinks

## Setup ZSH for humans
# ZSH for Humans already setup, so reuse config
# if command -v curl >/dev/null 2>&1; then
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v4/install)"
# else
#   sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v4/install)"
# fi

chsh -s $(which zsh)

# ## Needed for Brother MFC-L2700DW
# PRINTER_IP="192.168.0.194"
# ### Setup Brother scanner
# yay --noconfirm -S brother-mfc-l2710dw
# yay --noconfirm -S brscan4
# sudo pacman --noconfirm -S simple-scan
# sudo brsaneconfig4 -a name=BROTHER model=MFC-L2700DW ip="$PRINTER_IP"
# # Seems you can also do this:
# # brsaneconfig4 -a name=BROTHER model=MFC-L2700DW nodename=BRWD85DE244E1EB

# ### Setup Brother Printer
# sudo pacman --noconfirm -S cups manjaro-printer
# sudo systemctl enable cups.service
# sudo systemctl start cups.service
# sudo pacman --noconfirm -S cups system-config-printer
# lpadmin -p MFC-L2700DW -E -v "ipp://$PRINTER_IP/ipp/print" -m everywhere

## X11 stuff
sudo pacman --noconfirm -S xcape

## Docker
yay --noconfirm -S docker
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl start docker.service

# VirtualBox
# Not configured yet, but this is a link that seems good:
# https://www.linuxtechi.com/install-virtualbox-on-arch-linux/

## Rust
sudo pacman --noconfirm -S rustup
rustup toolchain install stable
rustup default stable
rustup component add rustfmt
rustup component add rls

## Alacritty
yay --noconfirm -S alacritty
yay --noconfirm -S ttf-iosevka

## Keypass
# yay --noconfirm -S keepassxc

## Wallpaper
nitrogen --set-scaled ./wallpaper/wallpaper.jpg


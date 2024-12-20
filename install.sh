#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

cd /temp
username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Install Pre-requisite
apt install build-essential git libx11-dev libxft-dev libxinerama-dev xorg dmenu unzip lxpolkit x11-xserver-utils unzip wget pulseaudio alacritty pavucontrol xdg-user-dirs


# Install Dwm
git clone https://github.com/sebabellucci/debian-dwm.git
cd debian-dwm

# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/Pictures
mkdir -p /usr/share/sddm/themes
cp .xinitrc /home/$username
cp -R dotfiles/dotconfig/* /home/$username/.config/
cp dotfiles/Wallpapers/* /home/$username/Pictures/
chown -R $username:$username /home/$username
cd..

# Install Dwm
git clone https://github.com/Ferchupessoadev/dwm.git
cd dwm
make clean install
mkdir -p ~/.local/share/dwm
cd..
cp -r autostart.sh ~/.local/share/dwm/autostart.sh
cp -r dwmbar ~/.config/dwmbar
cd..

#Install ST
git clone https://github.com/Ferchupessoadev/st.git
cd st
make install clean
cd..

# Installing fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d /usr/share/fonts

# Reloading Font
fc-cache -vf

# Removing zip Files
rm ./JetBrainsMono.zipip

# Installing software adtional
apt install arandr nitrogen chromium neofetch 

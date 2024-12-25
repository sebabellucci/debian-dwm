#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

cd /tmp
username=$(id -u -n 1000)
#builddir=$(pwd)

# Update packages list and update system
apt update && apt upgrade -y

# Install Pre-requisite
apt install -y thunar build-essential git libx11-dev libxft-dev libxinerama-dev xorg dmenu unzip lxpolkit x11-xserver-utils unzip wget pulseaudio alacritty pavucontrol 

# Installing software adtional
apt install -y arandr neofetch dunst picom xdg-user-dirs extrepo feh nm-tray slim curl apt-transport-https wget gpg

#Install Librewolf
extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y

#Install code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update && sudo apt install code # or code-insiders



#Config Extras
git clone https://github.com/sebabellucci/debian-dwm.git
cd debian-dwm

# Making .config and Moving config files and background to Pictures
mkdir -p ~/.config
mkdir -p ~/Pictures/Wallpapers
#touch ~/.xinitrc
#cp .xinitrc ~/
cp -R dotfiles/dotconfig/* ~/.config/
cp dotfiles/dotextras/wallpapers/* ~/Pictures/Wallpapers/
cp dotfiles/dotextras/fonts/* /usr/share/fonts
cp dotfiles/dotextras/slim/slim.conf /etc
cp -r dotfiles/dotextras/slim/blue-sky /usr/share/slim/themes
cd ..

# Install Dwm
git clone https://github.com/Ferchupessoadev/dwm.git
cd dwm
make clean install
mkdir -p ~/.local/share/dwm
cp -r autostart.sh ~/.local/share/dwm/autostart.sh
cp -r dwmbar ~/.config/dwmbar
cd ..

#Install ST
git clone https://github.com/Ferchupessoadev/st.git
cd st
make install clean
cd ..

# Installing fonts
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
#unzip JetBrainsMono.zip -d /usr/share/fonts

#update permisions
chown -R $username:$username ~/
# create Directory home
xdg-user-dirs-update
# Reloading Font
fc-cache -vf

# Removing zip Files
#rm ./JetBrainsMono.zipip



#!/usr/bin/env bash

sudo snap install spotify
sudo snap install signal-desktop
sudo snap install vlc
sudo snap install code --classic
sudo snap install yubioath-desktop
sudo snap install slack
sudo snap install docker

#sudo addgroup --system docker
#sudo adduser $USER docker
#newgrp docker
#sudo snap disable docker
#sudo snap enable docker

wget --content-disposition https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

wget --content-disposition https://github.com/Eugeny/tabby/releases/download/v1.0.183/tabby-1.0.183-linux-x64.deb
sudo dpkg -i tabby-1.0.183-linux-x64.deb
rm tabby-1.0.183-linux-x64.deb

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

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

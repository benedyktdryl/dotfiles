#!/usr/bin/env bash

# Install desktop apps with cask
brew install --cask warp
brew install --cask google-chrome
brew install --cask licecap
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask spotify
brew install --cask vlc
brew install --cask dbeaver-community
brew install --cask keka
brew install --cask raycast
brew install --cask signal
brew install --cask stats
brew install --cask slack
brew install --cask dotnet-sdk
brew install --cask qbittorrent

# Remove outdated versions from the cellar.
brew cleanup

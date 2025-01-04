#!/usr/bin/env bash

# Install desktop apps with cask
brew install --cask ghostty
brew install --cask google-chrome
brew install --cask licecap
brew install --cask visual-studio-code
brew install --cask cursor
brew install --cask docker
brew install --cask spotify
brew install --cask vlc
brew install --cask dbeaver-community
brew install --cask keka
brew install --cask raycast
brew install --cask signal
brew install --cask slack
brew install --cask dotnet-sdk
brew install --cask qbittorrent
brew install --cask stremio
brew install --cask ccmenu

brew install gh
brew install repomix
brew instlal aider
brew install duti
brew install stats

# Remove outdated versions from the cellar.
brew cleanup

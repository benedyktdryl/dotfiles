#!/usr/bin/env bash

# Remove Homebrew cache
brew cleanup --prune=all

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh
brew install screen
brew install gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install nmap

# Install other useful binaries.
brew install git
brew install gs
brew install imagemagick
brew install p7zip
brew install rename
brew install tree

brew install zsh
brew install nvm
brew install gist
brew install youtube-dl
brew install ffmpeg
brew install dash
brew install dockutil

# Install desktop apps with cask
brew install --cask google-chrome
brew install --cask calibre
brew install --cask licecap
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask spotify
brew install --cask vlc
brew install --cask dbeaver-community
brew install --cask xmind
brew install --cask keka
brew install --cask flux

# Remove outdated versions from the cellar.
brew cleanup

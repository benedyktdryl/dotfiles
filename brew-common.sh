#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -d ~/.zprofile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.zprofile
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile

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

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
	echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells
	chsh -s "${BREW_PREFIX}/bin/zsh"
fi

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
brew install youtube-dl
brew install ffmpeg
brew install exa

brew tap oven-sh/bun
brew install bun

brew install rust

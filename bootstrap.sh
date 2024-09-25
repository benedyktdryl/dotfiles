#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git pull origin master

function doIt() {
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		sudo apt --fix-broken install
		sudo apt update
		sudo apt upgrade
		sudo apt install curl
		sudo apt-get install build-essential
	fi

	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude "brew.sh" \
		--exclude "brew-common.sh" \
		--exclude "linux-packages.sh" \
		-avh --no-perms . ~

	source ./brew-common.sh

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		if ! [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]; then
			# Linux but not WSL Linux
			source ./linux-packages.sh
		fi
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		# Mac OSX
		source ./brew.sh
	fi

	cd ~

	mkdir -p ~/Projects

	source $(brew --prefix nvm)/nvm.sh

	nvm install 22.9.0
	nvm alias default node

	npm install npm -g
	npm update -g

	if [[ "$OSTYPE" == "darwin"* ]]; then
		# Mac OSX
		source .macos

		duti -s com.microsoft.VSCode js all
		duti -s com.microsoft.VSCode ts all
		duti -s com.microsoft.VSCode jsx all
		duti -s com.microsoft.VSCode tsx all
		duti -s com.microsoft.VSCode json all
	fi

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	command -v zsh | sudo tee -a /etc/shells
	chsh -s $(which zsh)
}

doIt

unset doIt

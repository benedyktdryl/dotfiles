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
		# Linux
		source ./linux-packages.sh
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		# Mac OSX
		source ./brew.sh
	fi

	cd ~

	mkdir -p ~/Projects

	source $(brew --prefix nvm)/nvm.sh

	nvm install 18.6.0
	nvm alias default node

	npm install npm -g
	npm update -g

	if [[ "$OSTYPE" == "darwin"* ]]; then
		# Mac OSX
		source .macos
	fi

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

doIt

unset doIt

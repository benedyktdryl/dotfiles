#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {	
	source ./brew.sh

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	rsync --exclude ".git/" 					\
				--exclude ".DS_Store" 			\
				--exclude ".osx" 						\
				--exclude "bootstrap.sh" 		\
				--exclude "README.md" 			\
				--exclude "LICENSE-MIT.txt" \
				-avh --no-perms . ~;

	cd ~

	mkdir -p ~/Projects

	source $(brew --prefix nvm)/nvm.sh

	nvm install 16
	nvm alias default node

	npm install npm -g
	npm update -g

	source .macos
}

doIt;

unset doIt;

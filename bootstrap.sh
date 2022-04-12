#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	rsync --exclude ".git/" 					\
				--exclude ".DS_Store" 			\
				--exclude ".osx" 						\
				--exclude "bootstrap.sh" 		\
				--exclude "README.md" 			\
				--exclude "LICENSE-MIT.txt" \
				-avh --no-perms . ~;

	cd ~

	./brew.sh

	mkdir ~/Projects

	source $(brew --prefix nvm)/nvm.sh

	nvm install 16
	nvm alias default node

	npm install npm -g
	npm update -g

	./.macos
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

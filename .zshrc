ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(brew cp git git-extras gitfast npm docker docker-compose bgnotify)

source $ZSH/oh-my-zsh.sh

PATH=/bin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/git/bin:/sbin:/opt/X11/bin:/usr/X11/bin:$PATH

### Exports
export NVM_DIR="$HOME/.nvm"

# Make code the default editor.
export EDITOR='code';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Docker Dock Finder Chrome SystemUIServer Terminal" killall;

### Functions

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
	function diff() {
		git diff --no-index --color-words "$@";
	}
fi;

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

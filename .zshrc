# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(brew cp git git-extras gitfast npm docker docker-compose bgnotify)

source $ZSH/oh-my-zsh.sh

### OSX ONLY ###
if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]; then
	# WSL Linux
	eval $()keychain --eval --agents ssh id_rsa
fi
### OSX ONLY ###

### OSX ONLY ###
if [[ "$OSTYPE" == "darwin"* ]]; then
	# Add tab completion for `defaults read|write NSGlobalDomain`
	# You could just use `-g` instead, but I like being explicit
	complete -W "NSGlobalDomain" defaults

	# Add `killall` tab completion for common apps
	complete -o "nospace" -W "Docker Dock Finder Chrome SystemUIServer Terminal" killall

	# Recursively delete `.DS_Store` files
	alias dscleanup="find . -type f -name '*.DS_Store' -ls -delete"

	# Empty the Trash on all mounted volumes and the main HDD.
	# Also, clear Apple’s System Logs to improve shell startup speed.
	# Finally, clear download history from quarantine. https://mths.be/bum
	alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

	# Disable Spotlight
	alias spotoff="sudo mdutil -a -i off"
	# Enable Spotlight
	alias spoton="sudo mdutil -a -i on"
	# Flush Directory Service cache
	alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

	# Show/hide hidden files in Finder
	alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
	alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

	# Hide/show all desktop icons (useful when presenting)
	alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
	alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
	# Lock the screen (when going AFK)
	alias afk="osascript -e 'tell application \"Finder\" to sleep'"
	alias battery='system_profiler SPPowerDataType | grep -A3 -B7 "Condition"'

	# bun completions
	[ -s "/Users/benedyktdryl/.bun/_bun" ] && source "/Users/benedyktdryl/.bun/_bun"

	# CodeWhisperer post block. Keep at the bottom of this file.
	[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

	# Shortcuts
	alias ls="ls -Glasp"
	alias dl="cd ~/Downloads"
	alias dt="cd ~/Desktop"
	alias dc="cd ~/Projects"
	alias g="git"

	alias dockerstart="open --background -a Docker"

	function bundleid() {
		osascript -e "id of app \"$1\""
	}

	convert_wav_to_mp3() {
		if [[ $# -ne 2 ]]; then
			echo "Usage: convert_wav_to_mp3 <input.wav> <output.mp3>"
			return 1
		fi

		local input_file=$1
		local output_file=$2

		if [[ ${input_file##*.} != "wav" ]]; then
			echo "Error: The input file must be a .wav file."
			return 1
		fi

		if [[ ${output_file##*.} != "mp3" ]]; then
			echo "Error: The output file must have a .mp3 extension."
			return 1
		fi

		ffmpeg -i "$input_file" -codec:a libmp3lame -qscale:a 2 "$output_file"
	}

	alias wav2mp3="convert_wav_to_mp3"
fi
### OSX ONLY ###

### Functions

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_"
}

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
	function diff() {
		git diff --no-index --color-words "$@"
	}
fi

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}

### Aliases

#!/usr/bin/env bash

# Easier navigation: .., ..., ...., ....., ~ and -
alias h="cd ~"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Detect which `ls` flavor is in use
if ls --color >/dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# List all files colorized in long format
alias l="ls -GlapF ${colorflag}"

# List all files colorized in long format, excluding . and ..
alias la="ls -GlapAF ${colorflag}"

# List only directories
alias lsd="ls -glapF ${colorflag} | grep --color=never '^d'"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files, preserving hyperlinks
# Usage: `mergepdf input{1,2,3}.pdf`
alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "${method}"="lwp-request -m '${method}'"
done

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

alias heic2jpg="magick mogrify -monitor -format jpg"

# Git credentials
GIT_AUTHOR_NAME="Benedykt Dryl"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="cypherq@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

### Exports

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"                                       # This loads nvm
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm" # This loads nvm bash_completion

PATH="/bin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/git/bin:/sbin:/opt/X11/bin:/usr/X11/bin:$HOME/.local/bin:$PATH"

export PATH

# Make code the default editor.
export EDITOR='code'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# pnpm
export PNPM_HOME="/Users/benedyktdryl/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

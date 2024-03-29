## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
# Initial run
git clone https://github.com/benedyktdryl/dotfiles.git
cd dotfiles
source ./bootstrap.sh
chsh -s /usr/local/bin/zsh
sudo reboot
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
source ~/.zshrc
```

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-L26)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

## Known issues

### VSCode update issues on Windows/WSL

```bash
icacls "%LOCALAPPDATA%\Programs\Microsoft VS Code" /grant "%USERDOMAIN%\%USERNAME%":F /T
```

## Credits

https://github.com/mathiasbynens/dotfiles

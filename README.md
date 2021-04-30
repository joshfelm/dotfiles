# My Dotfiles

## Setup dotfiles on new system
Add this to .bashrc or .zshrc
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Next, clone the dotfiles into a **bare** repository:
```
git clone --bare git@github.com:fxlmo/dotfiles.git $HOME/.cfg
```

Checkout config to home:
```
config checkout
```

Stop shell from showing untracked files:
```
config config --local status.showUntrackedFiles no
```

## Themes
Here's a backup of all my shit in case of terrible failure.

For the themes:
- Applications: *Matcha-dark-azul*
- Cursor: *OSX-ElCap*
- Icons: *Flat-Remix-Dark*
- Shell: *MacOS\_Dark*

This bash script will auto copy the files into the right place for you:

```bash
sudo cp -r Matcha-dark-azul/ MacOS_Dark/ /usr/share/themes/
sudo cp -r OSX-ElCap/ Flat-Remix-Dark/ /usr/share/icons/
```

## Packages
To restore the installed packages:

```bash
sudo apt-key add repo.keys
sudo cp -R sources.list*
sudo apt update
sudo apt install dselect
sudo dselect update
sudo dpkg --set-selections package.list
sudo apt-get dselect-upgrade -y
```

## RCS
The RCS are all good to go, it should just set up everything where you need it

## Gnome tweaks
To restore gnome tweaks:

```
dconf load / < ~/.gnome-settings/gnome_settings.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
```

## UltiSnips
Copy the files from '.ultisnips' into `~/.vim/UltiSnips/`

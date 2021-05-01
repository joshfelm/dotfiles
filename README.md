# My Dotfiles
Here's a backup of all my shit in case of terrible failure.

## Setup keys
```
ssh-keygen -t ed25519 -C josh.felmeden@outlook.com
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

## Setup dotfiles on new system
Add this to .bashrc or .zshrc
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Next, clone the dotfiles into a **bare** repository:
```
SSH
git clone --bare git@github.com:fxlmo/dotfiles.git $HOME/.cfg

HTTPS
git clone --bare https://github.com:fxlmo/dotfiles.git $HOME/.cfg
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
For the themes:
- Applications: *Matcha-dark-azul*
- Cursor: *OSX-ElCap*
- Icons: *Flat-Remix-Dark*
- Shell: *Yaru-dark*

This bash script will auto copy the files into the right place for you:

```bash
sudo cp -r $HOME/.themes/Matcha-dark-azul/ $HOME/.themes/MacOS_Dark/ /usr/share/themes/
sudo cp -r $HOME/.themes/OSX-ElCap/ $HOME/.themes/Flat-Remix-Dark/ /usr/share/icons/
```

This script will install the fonts:
```
sudo fc-cache -fv
```

## RCS
The RCS are all good to go, it should just set up everything where you need it.

## Gnome tweaks
To restore gnome tweaks:

```
dconf load / < ~/.gnome-settings/gnome_settings.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/.gnome-settings/gnome-terminal-profiles.dconf
dconf load /org/gnome/terminal/ < ~/.gnome-settings/gnome-terminal-settings.dconf
```

To backup these, use:
```
dconf dump / > $HOME/.gnome-settings/gnome_settings.dconf
dconf dump /org/gnome/terminal/ > $HOME/.gnome-settings/gnome-terminal-settings.dconf
dconf dump /org/gnome/terminal/legacy/profiles/ > ~/.gnome-settings/gnome-terminal-profiles.dconf
```

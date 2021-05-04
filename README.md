# My Dotfiles
Here's a backup of all my shit in case of terrible failure.

## Setup dotfiles on new system
Add this to .bashrc or .zshrc
```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Next, clone the dotfiles into a **bare** repository:
```
git clone --bare git@github.com:fxlmo/dotfiles.git $HOME/.dotfiles
```

Checkout config to home:
```
config checkout
```

Stop shell from showing untracked files:
```
config config status.showUntrackedFiles no
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

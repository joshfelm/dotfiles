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
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Next, clone the dotfiles into a **bare** repository:
```
SSH
git clone --bare git@github.com:joshfelm/dotfiles.git $HOME/.cfg

HTTPS
git clone --bare https://github.com:joshfelm/dotfiles.git $HOME/.cfg
```

Checkout config to home:
```
cfg checkout
```

Stop shell from showing untracked files:
```
cfg config status.showUntrackedFiles no
```

## Themes
This is not intended to be used with a desktop environment. For a desktop
version of these dotfiles, check out the branch for the appropriate
desktop environment.

## RCS
The RCS are all good to go, it should just set up everything where you need it.

## Requirements
- omz
- fzf
- exa
- fdfind
- nvim
- vim
- git
- ...


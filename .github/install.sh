#!/bin/bash -
#===============================================================================
#
#          FILE: install.sh
#
#         USAGE: ./install.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/05/21 20:17:01
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

# setup ssh
#ssh-keygen -t ed25519 -C josh.felmeden@outlook.com
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_ed25519
#xclip -selection clipboard < ~/.ssh/id_ed25519.pub

# install fonts
#sudo fc-cache -fv

# load settings
# dconf load / < ~/.gnome-settings/gnome_settings.dconf
# dconf load /org/gnome/terminal/legacy/profiles:/ < ~/.gnome-settings/gnome-terminal-profiles.dconf
# dconf load /org/gnome/terminal/ < ~/.gnome-settings/gnome-terminal-settings.dconf

# sort themes
#sudo cp -r $HOME/.themes/Matcha-dark-azul/ $HOME/.themes/MacOS_Dark/ /usr/share/themes/
sudo cp -r $HOME/.themes/OSX-ElCap/ $HOME/.themes/Flat-Remix-Dark/ /usr/share/icons/

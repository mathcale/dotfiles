#!/bin/bash

source $(dirname "$0")/scripts/library.sh

echo ""
echo "The script will ask for permission to remove existing directories and files from ~/.config/"
echo "Symbolic links will then be created from ~/dotfiles into your ~/.config/ directory."
echo "But you can decide to keep your personal versions by answering with No (Nn)."
echo ""

read -p "Press enter to continue..." -n1 -s

# ------------------------------------------------------
# Create .config folder
# ------------------------------------------------------
echo ""
echo "-> Check if .config folder exists"

if [ -d ~/.config ]; then
    echo ".config folder already exists."
else
    mkdir ~/.config
    echo ".config folder created."
fi

# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------
# name symlink source target

echo ""
echo "-------------------------------------"
echo "-> Install general dotfiles"
echo "-------------------------------------"
echo ""

#_installSymLink kitty ~/.config/kitty ~/dotfiles/kitty ~/.config
_installSymLink ranger ~/.config/ranger ~/dotfiles/ranger/ ~/.config
_installSymLink nvim ~/.config/nvim ~/dotfiles/nvim/ ~/.config
_installSymLink starship ~/.config/starship.toml ~/dotfiles/starship/starship.toml ~/.config/starship.toml
_installSymLink rofi ~/.config/rofi ~/dotfiles/rofi/ ~/.config
_installSymLink dunst ~/.config/dunst ~/dotfiles/dunst/ ~/.config
_installSymLink wal ~/.config/wal ~/dotfiles/wal/ ~/.config

wal -i ~/wallpapers/
echo "Pywal templates initiated!"
echo ""

echo "-------------------------------------"
echo "-> Install GTK dotfiles"
echo "-------------------------------------"
echo ""

_installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 ~/dotfiles/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
_installSymLink gtk-3.0 ~/.config/gtk-3.0 ~/dotfiles/gtk/gtk-3.0/ ~/.config/
_installSymLink gtk-4.0 ~/.config/gtk-4.0 ~/dotfiles/gtk/gtk-4.0/ ~/.config/

echo "-------------------------------------"
echo "-> Install Hyprland dotfiles"
echo "-------------------------------------"
echo ""

_installSymLink hypr ~/.config/hypr ~/dotfiles/hypr/ ~/.config
_installSymLink waybar ~/.config/waybar ~/dotfiles/waybar/ ~/.config
_installSymLink swaylock ~/.config/swaylock ~/dotfiles/swaylock/ ~/.config
_installSymLink wlogout ~/.config/wlogout ~/dotfiles/wlogout/ ~/.config
_installSymLink swappy ~/.config/swappy ~/dotfiles/swappy/ ~/.config

# ------------------------------------------------------
# DONE
# ------------------------------------------------------
echo "DONE!" 
echo "NEXT: Please logout and reboot your system!"


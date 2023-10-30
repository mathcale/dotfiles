#!/bin/bash

echo "@mathcale's Arch Linux base setup shenanigans"
echo "Heavily inspired by Stephan Raabe's dotfiles"
echo "Original source: https://gitlab.com/stephan-raabe/dotfiles"

DOTFILES_DIR=$(pwd)
source "$DOTFILES_DIR/scripts/library.sh"

# ------------------------------------------------------
# Create .config folder
# ------------------------------------------------------
echo ""
echo "==> Check if .config folder exists"

if [ -d ~/.config ]; then
  echo ".config folder already exists."
else
  mkdir ~/.config
  echo ".config folder created."
fi

# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------
# Syntax: name link source target-dir
echo ""
echo "==> Install general dotfiles"

#_installSymLink kitty ~/.config/kitty $DOTFILES_DIR/kitty ~/.config
_installSymLink ranger ~/.config/ranger $DOTFILES_DIR/ranger/ ~/.config
_installSymLink nvim ~/.config/nvim $DOTFILES_DIR/nvim/ ~/.config
_installSymLink starship ~/.config/starship.toml $DOTFILES_DIR/starship/starship.toml ~/.config/starship.toml
_installSymLink rofi ~/.config/rofi $DOTFILES_DIR/rofi/ ~/.config
_installSymLink dunst ~/.config/dunst $DOTFILES_DIR/dunst/ ~/.config
_installSymLink wal ~/.config/wal $DOTFILES_DIR/wal/ ~/.config

wal -i ~/wallpapers/
echo "Pywal templates initiated!"

echo ""
echo "==> Install GTK dotfiles"

_installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 $DOTFILES_DIR/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
_installSymLink gtk-3.0 ~/.config/gtk-3.0 $DOTFILES_DIR/gtk/gtk-3.0/ ~/.config/
_installSymLink gtk-4.0 ~/.config/gtk-4.0 $DOTFILES_DIR/gtk/gtk-4.0/ ~/.config/

echo ""
echo "==> Install Hyprland dotfiles"

_installSymLink hypr ~/.config/hypr $DOTFILES_DIR/hypr/ ~/.config
_installSymLink waybar ~/.config/waybar $DOTFILES_DIR/waybar/ ~/.config
_installSymLink swaylock ~/.config/swaylock $DOTFILES_DIR/swaylock/ ~/.config
_installSymLink wlogout ~/.config/wlogout $DOTFILES_DIR/wlogout/ ~/.config
_installSymLink swappy ~/.config/swappy $DOTFILES_DIR/swappy/ ~/.config

# ------------------------------------------------------
# DONE
# ------------------------------------------------------
echo "DONE!"
echo "NEXT: Please reboot your system!"

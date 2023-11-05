#!/bin/bash

echo ""
echo "@mathcale's Arch Linux base setup shenanigans"
echo "Heavily inspired by Stephan Raabe's dotfiles"
echo "Original source: https://gitlab.com/stephan-raabe/dotfiles"
echo ""

source ~/dotfiles/arch/scripts/library.sh

echo ""
echo "==> Check if .config folder exists"

if [ -d ~/.config ]; then
  echo ".config folder already exists."
else
  mkdir ~/.config
  echo ".config folder created."
fi

# Syntax: name link source target-dir

echo ""
echo "==> Install general dotfiles"

_installSymLink kitty ~/.config/kitty ~/dotfiles/arch/kitty ~/.config
_installSymLink starship ~/.config/starship.toml ~/dotfiles/arch/starship/starship.toml ~/.config/starship.toml
_installSymLink rofi ~/.config/rofi ~/dotfiles/arch/rofi/ ~/.config
_installSymLink dunst ~/.config/dunst ~/dotfiles/arch/dunst/ ~/.config
_installSymLink wal ~/.config/wal ~/dotfiles/arch/wal/ ~/.config
_installSymLink neofetch ~/.config/neofetch ~/dotfiles/arch/neofetch/ ~/.config

echo ""
echo "==> Install GTK dotfiles"

_installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 ~/dotfiles/arch/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
_installSymLink gtk-3.0 ~/.config/gtk-3.0 ~/dotfiles/arch/gtk/gtk-3.0/ ~/.config/
_installSymLink gtk-4.0 ~/.config/gtk-4.0 ~/dotfiles/arch/gtk/gtk-4.0/ ~/.config/

echo ""
echo "==> Install Hyprland dotfiles"

_installSymLink hypr ~/.config/hypr ~/dotfiles/arch/hypr/ ~/.config
_installSymLink waybar ~/.config/waybar ~/dotfiles/arch/waybar/ ~/.config
_installSymLink swaylock ~/.config/swaylock ~/dotfiles/arch/swaylock/ ~/.config
_installSymLink wlogout ~/.config/wlogout ~/dotfiles/arch/wlogout/ ~/.config
_installSymLink swappy ~/.config/swappy ~/dotfiles/arch/swappy/ ~/.config

echo ""
echo "==> Init pywal"
wal -i ~/wallpapers/default.jpg
echo "pywal initiated!"

echo "Done! Please reboot your system!"

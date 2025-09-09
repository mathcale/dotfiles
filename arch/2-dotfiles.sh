#!/bin/bash

echo ""
echo "✨ @mathcale's Arch Linux base setup shenanigans ✨"
echo "Heavily inspired by Stephan Raabe's dotfiles"
echo "Original source: https://gitlab.com/stephan-raabe/dotfiles"
echo ""

source ~/dotfiles/arch/scripts/library.sh

if [ ! -d ~/.config ]; then
  mkdir ~/.config
  echo "👌 ~/.config folder created."
fi

if [ ! -d ~/Dev ]; then
  mkdir ~/Dev
  echo "👌 ~/Dev folder created."
fi

if [ ! -d ~/Random ]; then
  mkdir ~/Random
  echo "👌 ~/Random folder created."
fi

if [ ! -d ~/.goworkspace ]; then
  mkdir ~/.goworkspace
  echo "👌 ~/.goworkspace folder created."
fi

if [ ! -d ~/.local/bin ]; then
  mkdir -p ~/.local/bin
  echo "👌 ~/.local/bin folder created."
fi

if [ ! -f ~/.privaterc ]; then
  touch ~/.privaterc
fi

echo ""
echo "==> Installing general dotfiles"
# Syntax: name link source target-dir

_installSymLink .zshrc ~/.zshrc ~/dotfiles/arch/zsh/.zshrc ~/.zshrc
_installSymLink .warprc ~/.warprc ~/dotfiles/arch/zsh/.warprc ~/.warprc
_installSymLink .gitconfig ~/.gitconfig ~/dotfiles/arch/git/.gitconfig ~/.gitconfig
_installSymLink kitty ~/.config/kitty ~/dotfiles/arch/kitty ~/.config
_installSymLink starship ~/.config/starship.toml ~/dotfiles/arch/starship/starship.toml ~/.config/starship.toml
_installSymLink rofi ~/.config/rofi ~/dotfiles/arch/rofi/ ~/.config
_installSymLink dunst ~/.config/dunst ~/dotfiles/arch/dunst/ ~/.config
_installSymLink fastfetch ~/.config/fastfetch ~/dotfiles/arch/fastfetch/ ~/.config
_installSymLink nvim ~/.config/nvim ~/dotfiles/arch/nvim/ ~/.config
_installSymLink xfce4 ~/.config/xfce4 ~/dotfiles/arch/xfce4/ ~/.config
_installSymLink Kvantum ~/.config/Kvantum ~/dotfiles/arch/Kvantum/ ~/.config
_installSymLink waypaper ~/.config/waypaper ~/dotfiles/arch/waypaper ~/.config

echo ""
echo "==> Installing GTK dotfiles"

_installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 ~/dotfiles/arch/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
_installSymLink gtk-3.0 ~/.config/gtk-3.0 ~/dotfiles/arch/gtk/gtk-3.0/ ~/.config/
_installSymLink gtk-4.0 ~/.config/gtk-4.0 ~/dotfiles/arch/gtk/gtk-4.0/ ~/.config/

echo ""
echo "==> Installing Hyprland dotfiles"

_installSymLink hypr ~/.config/hypr ~/dotfiles/arch/hypr/ ~/.config
_installSymLink waybar ~/.config/waybar ~/dotfiles/arch/waybar/ ~/.config
_installSymLink wlogout ~/.config/wlogout ~/dotfiles/arch/wlogout/ ~/.config
_installSymLink swappy ~/.config/swappy ~/dotfiles/arch/swappy/ ~/.config

echo ""
echo "==> Copying scripts"

cp ~/dotfiles/arch/scripts/s0 ~/.local/bin/s0
cp ~/dotfiles/arch/scripts/up.sh ~/.local/bin/up
chmod +x ~/.local/bin/*

echo "🎉 Done! Please reboot your system!"

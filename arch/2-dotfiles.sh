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

_installSymLink .zshrc ~/.zshrc ~/dotfiles/arch/shell/.zshrc ~/.zshrc
_installSymLink .warprc ~/.warprc ~/dotfiles/arch/shell/.warprc ~/.warprc
_installSymLink .gitconfig ~/.gitconfig ~/dotfiles/arch/git/.gitconfig ~/.gitconfig
_installSymLink kitty ~/.config/kitty ~/dotfiles/arch/kitty ~/.config
_installSymLink starship ~/.config/starship.toml ~/dotfiles/arch/shell/starship.toml ~/.config/starship.toml
_installSymLink fastfetch ~/.config/fastfetch ~/dotfiles/arch/fastfetch/ ~/.config
_installSymLink nvim ~/.config/nvim ~/dotfiles/arch/nvim/ ~/.config
_installSymLink ulauncher ~/.config/ulauncher ~/dotfiles/arch/ulauncher ~/.config
_installSymLink xdg-terminals.list ~/.config/xdg-terminals.list ~/dotfiles/arch/xdg-terminals.list ~/.config/xdg-terminals.list
_installSymLink Kvantum ~/.config/Kvantum ~/dotfiles/arch/Kvantum/ ~/.config
_installSymLink mimeapps.list ~/.config/mimeapps.list ~/dotfiles/arch/hypr/mimeapps.list ~/.config/mimeapps.list

echo ""
echo "==> Installing GTK dotfiles"

_installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 ~/dotfiles/arch/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
_installSymLink gtk-3.0 ~/.config/gtk-3.0 ~/dotfiles/arch/gtk/gtk-3.0/ ~/.config/
_installSymLink gtk-4.0 ~/.config/gtk-4.0 ~/dotfiles/arch/gtk/gtk-4.0/ ~/.config/

echo ""
echo "==> Installing Hyprland dotfiles"

_installSymLink hypr ~/.config/hypr ~/dotfiles/arch/hypr/ ~/.config

echo ""
echo "==> Installing DankMaterialShell dotfiles"

if [ ! -d ~/.config/environment.d ]; then
  mkdir -p ~/.config/environment.d
  echo "👌 ~/.config/environment.d folder created."
fi

_installSymLink DankMaterialShell ~/.config/DankMaterialShell ~/dotfiles/arch/dms ~/.config/DankMaterialShell
_installSymLink 90-dms.conf ~/.config/environment.d/90-dms.conf ~/dotfiles/arch/environment.d/90-dms.conf ~/.config/environment.d/90-dms.conf

echo ""
echo "==> Applying GNOME keybindings"

dconf load / < ~/dotfiles/arch/dconf/gnome.conf
echo "👌 GNOME keybindings applied."

echo ""
echo "==> Enabling ulauncher service (GNOME only)"

if [ ! -d ~/.config/systemd/user/ulauncher.service.d ]; then
  mkdir -p ~/.config/systemd/user/ulauncher.service.d
  echo "👌 ~/.config/systemd/user/ulauncher.service.d folder created."
fi

_installSymLink gnome-only.conf \
  ~/.config/systemd/user/ulauncher.service.d/gnome-only.conf \
  ~/dotfiles/arch/systemd/ulauncher.service.d/gnome-only.conf \
  ~/.config/systemd/user/ulauncher.service.d/gnome-only.conf

systemctl --user daemon-reload
systemctl --user enable --now ulauncher.service
echo "👌 ulauncher service enabled (restricted to GNOME sessions)."

echo ""
echo "==> Copying scripts"

cp ~/dotfiles/arch/scripts/s0 ~/.local/bin/s0
cp ~/dotfiles/arch/scripts/up.sh ~/.local/bin/up
chmod +x ~/.local/bin/*

echo "🎉 Done! Please reboot your system!"

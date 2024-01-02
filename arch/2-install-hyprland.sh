#!/bin/bash

echo ""
echo "✨ @mathcale's Arch Linux base setup shenanigans ✨"
echo "Heavily inspired by Stephan Raabe's dotfiles"
echo "Original source: https://gitlab.com/stephan-raabe/dotfiles"
echo ""

source ~/dotfiles/arch/scripts/library.sh

echo ""
echo "==> Install main packages"

packagesPacman=("hyprland" "xdg-desktop-portal-wlr" "waybar" "rofi" "grim" "slurp" "swayidle" "swappy" "cliphist" "hyprpaper");
packagesYay=("swaylock-effects" "wlogout");

_installPackagesPacman "${packagesPacman[@]}";
_installPackagesYay "${packagesYay[@]}";

echo ""
echo "🎉 Done! Now run '3-dotfiles.sh'"

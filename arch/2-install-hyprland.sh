#!/bin/bash

echo "@mathcale's Arch Linux base setup shenanigans"
echo "Heavily inspired by Stephan Raabe's dotfiles"
echo "Original source: https://gitlab.com/stephan-raabe/dotfiles"

source $(dirname "$0")/scripts/library.sh

# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
echo ""
echo "==> Install main packages"

packagesPacman=(
  "hyprland"
  "xdg-desktop-portal-wlr"
  "waybar"
  "rofi"
  "grim"
  "slurp"
  "swayidle"
  "swappy"
  "cliphist"
);

packagesYay=(
  "swww"
  "swaylock-effects"
  "wlogout"
);

# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
_installPackagesPacman "${packagesPacman[@]}";
_installPackagesYay "${packagesYay[@]}";

echo ""
echo "DONE!"
echo "Proceed with 3-dotfiles.sh"

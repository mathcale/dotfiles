#!/bin/bash

source $(dirname "$0")/scripts/library.sh

# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
echo ""
echo "-> Install main packages"

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
echo "NEXT: Update the keyboard layout and screen resolution in ~/dotfiles/hypr/hyprland.conf"
echo "Then proceed with with 3-dotfiles.sh"


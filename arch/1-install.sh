#/bin/bash

echo "@mathcale's Arch Linux base setup shenanigans"
echo "Heavily inspired by Stephan Raabe's dotfiles"
echo "Original source: https://gitlab.com/stephan-raabe/dotfiles"

# ------------------------------------------------------
# Load Library
# ------------------------------------------------------
DOTFILES_DIR=$(dirname "$0")
source "$DOTFILES_DIR/scripts/library.sh"

# ------------------------------------------------------
# Check if yay is installed
# ------------------------------------------------------
if sudo pacman -Qs yay > /dev/null ; then
  echo "yay is installed. Setup will continue."
else
  echo "==> Installing yay"

  _installPackagesPacman "base-devel"
  git clone https://aur.archlinux.org/yay-git.git ~/yay-git
  cd ~/yay-git
  makepkg -si
  cd $DOTFILES_DIR

  echo ""
  echo "yay has been installed successfully."
fi

# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
echo ""
echo "==> Install main packages"

packagesPacman=(
  "pacman-contrib"
  "kitty"
  "rofi"
  "firefox"
  "nitrogen"
  "dunst"
  "starship"
  "neovim"
  "mpv"
  "freerdp"
  "xfce4-power-manager"
  "thunar"
  "mousepad"
  "ttf-font-awesome"
  "ttf-fira-sans"
  "ttf-fira-code"
  "ttf-firacode-nerd"
  "figlet"
  "vlc"
  "eza"
  "python-pip"
  "python-psutil"
  "python-rich"
  "python-click"
  "xdg-desktop-portal-gtk"
  "pavucontrol"
  "tumbler"
  "xautolock"
  "blueman"
  "sddm"
  "kora-icon-theme"
  "bat"
  "neofetch"
  "thunderbird"
  "gimp"
  "zsh"
);

packagesYay=(
  "pfetch"
  "dracula-cursors-git"
  "trizen"
  "sddm-sugar-dark"
);
  
# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
_installPackagesPacman "${packagesPacman[@]}";
_installPackagesYay "${packagesYay[@]}";

# ------------------------------------------------------
# Install pywal
# ------------------------------------------------------
if [ -f /usr/bin/wal ]; then
  echo "pywal already installed."
else
  yay --noconfirm -S pywal
fi

# ------------------------------------------------------
# Install sddm display manager
# ------------------------------------------------------
echo ""
echo "==> Enable sddm display manager"
sudo systemctl enable sddm.service

# ------------------------------------------------------
# Install wallpapers
# ------------------------------------------------------
echo ""
echo "==> Install wallapers"
git clone https://github.com/mathcale/wallpapers.git ~/wallpapers
echo "wallpapers installed!"

# ------------------------------------------------------
# Init pywal
# ------------------------------------------------------
echo ""
echo "==> Init pywal"
wal -i ~/wallpapers/default.jpg
echo "pywal initiated!"
	
# ------------------------------------------------------
# Copy default wallpaper to .cache
# ------------------------------------------------------
echo ""
echo "==> Copy default wallpaper to .cache"
cp ~/wallpapers/default.jpg ~/.cache/current_wallpaper.jpg
echo "default wallpaper copied."

# ------------------------------------------------------
# DONE
# ------------------------------------------------------
echo "DONE!" 
echo "NEXT: Please continue with 2-install-hyprland.sh"

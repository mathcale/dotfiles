#!/bin/bash

echo ""
echo "✨ @mathcale's Arch Linux base setup shenanigans ✨"
echo "Heavily inspired by Stephan Raabe's dotfiles"
echo "Original source: https://gitlab.com/stephan-raabe/dotfiles"
echo ""

source ~/dotfiles/arch/scripts/library.sh

if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "==> Creating new SSH key..."
  ssh-keygen -t ed25519 -C "hello@matheus.me" -q -P ""
fi

if sudo pacman -Qs yay > /dev/null ; then
  echo "yay is installed. Setup will continue."
else
  echo "==> Installing yay"

  _installPackagesPacman "base-devel"

  git clone https://aur.archlinux.org/yay-git.git ~/yay-git
  cd ~/yay-git
  makepkg -si --noconfirm
  cd ~/dotfiles/arch

  echo ""
  echo "yay has been installed successfully."
fi

echo ""
echo "==> Installing main packages"

mapfile -t packagesPacman < ~/dotfiles/arch/pkglist-repo.txt
mapfile -t packagesYay < ~/dotfiles/arch/pkglist-aur.txt
mapfile -t packagesFlatpak < ~/dotfiles/arch/pkglist-flatpak.txt

_installPackagesPacman "${packagesPacman[@]}"
_installPackagesYay "${packagesYay[@]}"
_installPackagesFlatpak "${packagesFlatpak[@]}"

echo ""
echo "==> Adding symlink for emoji font"
sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf

echo ""
echo "==> Cleaning font cache"
fc-cache -f

echo ""
echo "==> Enabling GDM"
sudo systemctl enable gdm

echo ""
echo "==> Enabling Bluetooth dongle rebind workaround"
sudo cp ~/dotfiles/arch/scripts/rebind-bt-dongle.sh /usr/local/bin/rebind-bt-dongle.sh
sudo chmod +x /usr/local/bin/rebind-bt-dongle.sh
sudo cp ~/dotfiles/arch/systemd/rfkill-unblock-bluetooth.service /etc/systemd/system/rfkill-unblock-bluetooth.service
sudo systemctl enable rfkill-unblock-bluetooth.service

echo ""
echo "==> Installing wallapers"
git clone https://github.com/mathcale/wallpapers.git ~/wallpapers
echo "👌 wallpapers installed!"

echo ""
echo "🔑 Here's your public SSH key:"
cat ~/.ssh/id_ed25519.pub

echo ""
echo "🎉 Done! Now run '2-dotfiles.sh'"

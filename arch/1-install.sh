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
  makepkg -si
  cd ~/dotfiles/arch

  echo ""
  echo "yay has been installed successfully."
fi

echo ""
echo "==> Installing main packages"

packagesPacman=("pacman-contrib" "kitty" "rofi" "firefox" "nitrogen" "dunst" "starship" "neovim" "thunar" "mousepad" "ttf-font-awesome" "ttf-fira-sans" "ttf-fira-code" "ttf-firacode-nerd" "figlet" "vlc" "eza" "python-pip" "pqython-psutil" "python-rich" "python-click" "xdg-desktop-portal-gtk" "pavucontrol" "tumbler" "xautolock" "blueman" "bluez" "sddm" "bat" "neofetch" "thunderbird" "gimp" "zsh" "htop" "iotop" "zip" "unzip" "unrar" "lm_sensors" "sqlite3" "curl" "wget" "docker" "docker-compose" "yarn" "flatpak" "inkscape" "gparted" "xsensors" "qbittorrent" "steam" "lutris" "cups" "cups-pdf" "dnsmasq" "eog" "file-roller" "btop" "font-manager" "git-delta" "gnome-keyring" "gnome-system-monitor" "gradience" "grub-customizer" "gvfs" "iotop" "kvantum" "man-db" "noto-fonts-emoji" "obs-studio" "os-prober" "otf-font-awesome" "qemu-full" "virt-manager" "virt-viewer" "snapshot" "system-config-printer" "thefuck" "ttf-icomoon-feather" "wine-lol-bin" "xfce4-power-manager");

packagesYay=("pfetch" "dracula-cursors-git" "kora-icon-theme" "visual-studio-code-bin" "tidal-hifi-bin" "spotify" "parsec-bin" "teamviewer" "sublime-text-4" "insomnia-bin" "figma-linux-bin" "minecraft-launcher" "ttf-ms-fonts" "heroic-games-launcher-bin" "hstr" "jetbrains-toolbox" "leagueoflegends-git" "noto-fonts-emoji-flags" "nwg-look" "runebook-bin" "sddm-catppuccin-git" "sddm-config-git" "update-grub" "pywal");

packagesFlatpak=("com.discordapp.Discord" "com.github.tchx84.Flatseal" "org.ferdium.Ferdium" "sh.ppy.osu" "org.gtk.Gtk3theme.adw-gtk3" "org.gtk.Gtk3theme.adw-gtk3-dark")

_installPackagesPacman "${packagesPacman[@]}";
_installPackagesYay "${packagesYay[@]}";
_installPackagesFlatpak "${packagesFlatpak[@]}"

echo ""
echo "==> Cleaning font cache"
fc-cache -f

echo ""
echo "==> Enabling sddm display manager"
sudo systemctl enable sddm.service

echo ""
echo "==> Installing wallapers"
git clone https://github.com/mathcale/wallpapers.git ~/wallpapers
echo "👌 wallpapers installed!"

echo ""
echo "==> Copying default wallpaper to .cache"
cp ~/wallpapers/default.jpg ~/.cache/current_wallpaper.jpg
echo "default wallpaper copied."

echo ""
echo "🔑 Here's your public SSH key:"
cat ~/.ssh/id_ed25519.pub

echo ""
echo "🎉 Done! Now run '2-install-hyprland.sh'"

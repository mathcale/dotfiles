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

packagesPacman=("amd-ucode" "base" "base-devel" "bat" "bind" "bleachbit" "blueman" "bluez-hid2hci" "bluez-utils" "btop" "btrfs-progs" "cliphist" "cmatrix" "corectrl" "cups" "cups-pdf" "dnsmasq" "docker" "docker-compose" "dunst" "efibootmgr" "eog" "eza" "fastfetch" "feh" "ffmpeg4.4" "figlet" "file-roller" "firefox" "flatpak" "font-manager" "freerdp" "gamescope" "gimp" "git" "git-delta" "gnome-calculator" "gnome-keyring" "gnome-system-monitor" "gnome-themes-extra" "gparted" "grim" "grub" "grub-customizer" "gvfs" "gvfs-nfs" "gvfs-smb" "htop" "hyprpaper" "imagemagick" "inkscape" "iotop" "kitty" "kubectl" "kvantum" "lazygit" "libguestfs" "linux" "linux-firmware" "lutris" "man-db" "mangohud" "mpc" "mpd" "mpv" "nano" "ncmpcpp" "neofetch" "neovim" "networkmanager" "nm-connection-editor" "noto-fonts-emoji" "nwg-look" "obs-studio" "os-prober" "otf-font-awesome" "otf-monaspace" "pacman-contrib" "pavucontrol" "pipewire-alsa" "pipewire-pulse" "polkit-gnome" "powertop" "protobuf" "python-click" "python-pip" "python-psutil" "python-rich" "qbittorrent" "qemu-full" "qt5ct" "radeontop" "ripgrep" "rlwrap" "rofi" "samba" "slurp" "speedtest-cli" "spice-vdagent" "starship" "steam" "swappy" "swayidle" "system-config-printer" "thefuck" "thunar" "thunar-archive-plugin" "thunderbird" "traceroute" "ttf-fira-code" "ttf-fira-sans" "ttf-firacode-nerd" "ttf-joypixels" "ttf-overpass" "tumbler" "unrar" "virt-manager" "virt-viewer" "waybar" "wget" "whois" "xdg-desktop-portal-gnome" "xdg-desktop-portal-gtk" "xfce4-power-manager" "xorg-xhost" "xsensors" "yarn" "zsh" "zip");

packagesYay=("1password" "adw-gtk-theme" "adw-gtk3-git" "appimagelauncher" "cava" "cbonsai" "docker-buildx-git" "dracula-cursors-git" "evans" "figma-linux-bin" "google-chrome" "heroic-games-launcher-bin" "hstr" "insomnia-bin" "jetbrains-toolbox" "k6" "kora-icon-theme" "libratbag-git" "lssecret-git" "minecraft-launcher" "mycli" "pfetch" "piper-git" "python-cssutils" "python-material-color-utilities" "python-sqlglot" "qtilitools-git" "quickemu" "quickgui-bin" "sddm-catppuccin-git" "sddm-conf-git" "sddm-sugar-dark" "spotify" "sublime-text-4" "swaylock-effects" "teamviewer" "tidal-hifi-bin" "trizen" "ttf-font-awesome-4" "ttf-icomoon-feather" "ttf-ms-fonts" "ttf-twemoji" "tty-clock" "update-grub" "visual-studio-code-bin" "wdisplays" "wlogout" "yay-git" "yay-git-debug" "zsh-autopair-git");

packagesFlatpak=("com.discordapp.Discord" "com.github.tchx84.Flatseal" "org.ferdium.Ferdium" "sh.ppy.osu" "org.gtk.Gtk3theme.adw-gtk3" "org.gtk.Gtk3theme.adw-gtk3-dark" "org.gnome.Snapshot")

_installPackagesPacman "${packagesPacman[@]}";
_installPackagesYay "${packagesYay[@]}";
_installPackagesFlatpak "${packagesFlatpak[@]}"

echo ""
echo "==> Installing Go packages"
go install github.com/traefik/yaegi/cmd/yaegi@latest
go install github.com/jesseduffield/lazydocker@latest

echo ""
echo "==> Adding symlink for emoji font"
sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf

echo ""
echo "==> Cleaning font cache"
fc-cache -f

echo ""
echo "==> Enabling sddm"
sudo systemctl enable sddm.service

echo ""
echo "==> Installing wallapers"
git clone https://github.com/mathcale/wallpapers.git ~/wallpapers
echo "👌 wallpapers installed!"

echo ""
echo "==> Copying default wallpaper to .cache"
cp ~/wallpapers/joenco-GSNJzQeLSmw-unsplash.jpg ~/.cache/current_wallpaper.jpg
echo "default wallpaper copied."

echo ""
echo "🔑 Here's your public SSH key:"
cat ~/.ssh/id_ed25519.pub

echo ""
echo "🎉 Done! Now run '2-install-hyprland.sh'"

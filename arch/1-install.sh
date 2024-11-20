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

packagesPacman=("amd-ucode" "bat" "base" "base-devel" "bind" "blueman" "bluez-hid2hci" "bluez-utils" "btop" "cliphist" "cmatrix" "corectrl" "cups" "cups-pdf" "dnsmasq" "docker" "docker-compose" "dunst" "easyeffects" "efibootmgr" "eog" "eza" "fastfetch" "feh" "ffmpeg4.4" "gdm" "figlet" "file-roller" "firefox" "flatpak" "font-manager" "freerdp" "gamemode" "gamescope" "gimp" "git" "git-delta" "gnome-themes-extra" "gnome-tweaks" "goverlay" "gparted" "grim" "grub" "grub-customizer" "gst-plugin-pipewire" "gstreamer-vaapi" "htop" "hypridle" "hyprpaper" "imagemagick" "inkscape" "iotop" "jenv" "jq" "kitty" "kubectl" "kvantum" "lazygit" "libguestfs" "libpulse" "lutris" "man-db" "mangohud" "mpd" "mpv" "nano" "ncmpcpp" "neovim" "networkmanager" "nm-connection-editor" "noto-fonts-emoji" "nwg-look" "obs-studio" "openssh" "os-prober" "otf-font-awesome" "pavucontrol" "pipewire" "pipewire-alsa" "pipewire-jack" "pipewire-pulse" "polkit-gnome" "power-profiles-daemon" "powertop" "protobuf" "python-click" "python-pip" "python-psutil" "python-pynvim" "python-pyusb" "python-rich" "qbittorrent" "qemu-full" "radeontop" "ripgrep" "rlwrap" "rofi" "rust" "samba" "slurp" "speedtest-cli" "starship" "steam" "swappy" "system-config-printer" "thefuck" "thunar" "thunar-archive-plugin" "thunderbird" "tmux" "traceroute" "ttf-fira-code" "ttf-fira-sans" "ttf-firacode-nerd" "ttf-joypixels" "ttf-overpass" "tumbler" "unrar" "virt-manager" "virt-viewer" "waybar" "wget" "whois" "wireplumber" "xdg-desktop-portal-gtk" "xdg-desktop-portal-wlr" "xorg-xhost" "xsensors" "yarn" "yt-dlp" "zsh");

packagesYay=("1password" "adw-gtk-theme" "adw-gtk3-git" "amdgpu-pro-oglp" "amf-amdgpu-pro" "appimagelauncher" "aylurs-gtk-shell" "bun-bin" "cava" "cbonsai" "dmg2img" "docker-buildx-git" "downgrade" "dracula-cursors-git" "dualsensectl-git" "fancontrol-gui" "figma-linux-bin" "fnm" "golangci-lint" "heroic-games-launcher-bin" "hstr" "huiontablet" "hyprlock-git" "k6" "kora-icon-theme" "lib32-amdgpu-pro-oglp" "lib32-vulkan-amdgpu-pro" "libratbag-git" "lssecret-git" "minecraft-launcher" "mycli" "obs-gstreamer" "oh-my-zsh-git" "piper-git" "python-cssutils" "python-inputs" "python-material-color-utilities" "python-mock" "python-sqlglot" "python-steam" "python-vdf" "qtilitools-git" "soundux" "spotify" "stremio-beta" "sublime-text-4" "swaylock-effects" "tidal-hifi-bin" "ttf-font-awesome-4" "ttf-icomoon-feather" "ttf-ms-fonts" "ttf-twemoji" "tty-clock" "update-grub" "visual-studio-code-bin" "vulkan-amdgpu-pro" "waypaper" "wdisplays" "wlogout" "yay-git" "yt-dlp-drop-in" "zen-browser-bin" "zsh-autopair-git");

packagesFlatpak=("com.discordapp.Discord" "com.github.tchx84.Flatseal" "org.ferdium.Ferdium" "org.gtk.Gtk3theme.adw-gtk3" "org.gtk.Gtk3theme.adw-gtk3-dark" "org.gnome.Snapshot" "info.cemu.Cemu" "net.pcsx2.PCSX2" "org.DolphinEmu.dolphin-emu" "org.duckstation.DuckStation" "org.ppsspp.PPSSPP")

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
echo "==> Enabling GDM"
sudo systemctl enable gdm

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
echo "🎉 Done! Now run '2-dotfiles.sh'"

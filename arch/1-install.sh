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

packagesPacman=("amd-ucode" "amdgpu_top" "arandr" "base" "base-devel" "bat" "bc" "bind" "blueman" "bluez-deprecated-tools" "bluez-hid2hci" "bluez-utils" "btop" "cmatrix" "cowsay" "cups-pdf" "discord" "dnsmasq" "docker" "dysk" "easyeffects" "efibootmgr" "ethtool" "eza" "fastfetch" "fd" "feh" "ffmpeg4.4" "ffmpegthumbs" "figlet" "filezilla" "fortune-mod" "gamemode" "gamescope" "gdm" "gimp" "git" "git-delta" "github-cli" "glances" "glaze" "gnome" "golangci-lint" "goverlay" "gparted" "grub" "gst-libav" "gst-plugin-pipewire" "guestfs-tools" "gvfs" "gvfs-afc" "gvfs-dnssd" "gvfs-goa" "gvfs-google" "gvfs-gphoto2" "gvfs-mtp" "gvfs-nfs" "gvfs-smb" "gvfs-wsdd" "htop" "hyprcursor" "hyprgraphics" "hypridle" "hyprland" "hyprlock" "hyprpaper" "hyprpicker" "i2c-tools" "iotop" "iwd" "jenv" "jq" "kitty" "kvantum" "libguestfs" "libpulse" "linux" "linux-firmware" "lutris" "man-db" "mangohud" "masscan" "mesa-demos" "mpv" "nano" "neovim" "network-manager-applet" "networkmanager" "nfs-utils" "nwg-displays" "nwg-look" "obs-studio" "openvpn" "os-prober" "otf-font-awesome" "pavucontrol" "piper" "pipewire" "pipewire-alsa" "pipewire-jack" "pipewire-pulse" "plymouth" "polkit-gnome" "power-profiles-daemon" "powertop" "proton-vpn-gtk-app" "protonmail-bridge" "protonmail-bridge-core" "python-click" "python-hatch" "python-pip" "python-pynvim" "python-pyusb" "python-rich" "qbittorrent" "qemu-full" "qqc2-desktop-style" "qt6-5compat" "radeontop" "ripgrep" "rlwrap" "rust" "samba" "screen" "smartmontools" "speedtest-cli" "starship" "steam" "swtpm" "system-config-printer" "thunderbird" "tmux" "traceroute" "tree" "ttf-fira-code" "ttf-fira-sans" "ttf-firacode-nerd" "ttf-overpass" "unrar" "vim" "virt-manager" "virt-viewer" "vlc" "vulkan-radeon" "vulkan-tools" "webkit2gtk" "webp-pixbuf-loader" "wev" "wget" "whois" "wine" "wine-gecko" "wine-mono" "winetricks" "wireguard-tools" "wireless_tools" "wireplumber" "xdg-desktop-portal-gnome" "xdg-desktop-portal-hyprland" "xdg-desktop-portal-wlr" "xdg-user-dirs-gtk" "xdg-utils" "xorg-server" "xorg-xcursorgen" "xorg-xhost" "xorg-xinit" "xsensors" "yt-dlp" "zsh");

packagesYay=("1password" "nautilus-open-any-terminal" "xdg-terminal-exec" "ulauncher" "adw-gtk3-git" "android-sdk-build-tools" "apfs-fuse-git" "appimagelauncher" "brave-bin" "bun-bin" "cbonsai" "code-minimap" "cozette-otb" "dmg2img" "dms-shell-bin" "docker-buildx-git" "downgrade" "dualsensectl-git" "etcher-bin" "ferdium-bin" "figma-linux-bin" "fnm" "gdm-settings" "gpth-bin" "grub-customizer" "heroic-games-launcher-bin" "hstr" "huiontablet" "hydroxide" "insomnia-bin" "jdownloader2" "jetbrains-toolbox" "k6" "kora-icon-theme" "localsend-bin" "lssecret-git" "minecraft-launcher" "mycli" "nerdfetch" "obs-gstreamer" "oh-my-zsh-git" "opentabletdriver" "phinger-cursors" "pipes.sh" "plymouth-theme-catppuccin-mocha-git" "python-cssutils" "python-inputs" "python-material-color-utilities" "python-mock" "python-sqlglot" "python-steam" "python-vdf" "qtilitools-git" "rpi-imager-bin" "sublime-text-4" "ttf-font-awesome-4" "ttf-icomoon-feather" "ttf-joypixels" "ttf-ms-fonts" "ttf-twemoji" "tty-clock" "update-grub" "visual-studio-code-bin" "vkbasalt" "wdisplays" "yt-dlp-drop-in" "zen-browser-bin" "zsh-autopair-git");

packagesFlatpak=("com.github.tchx84.Flatseal" "com.mattjakeman.ExtensionManager" "com.stremio.Stremio" "info.cemu.Cemu" "io.github.flattool.Warehouse" "io.github.Soundux" "it.mijorus.smile" "net.pcsx2.PCSX2" "net.rpcs3.RPCS3" "org.DolphinEmu.dolphin-emu" "org.duckstation.DuckStation" "org.gnome.Snapshot" "org.gtk.Gtk3theme.adw-gtk3-dark" "org.gtk.Gtk3theme.adw-gtk3" "org.ppsspp.PPSSPP")

_installPackagesPacman "${packagesPacman[@]}";
_installPackagesYay "${packagesYay[@]}";
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
echo "==> Installing wallapers"
git clone https://github.com/mathcale/wallpapers.git ~/wallpapers
echo "👌 wallpapers installed!"

echo ""
echo "🔑 Here's your public SSH key:"
cat ~/.ssh/id_ed25519.pub

echo ""
echo "🎉 Done! Now run '2-dotfiles.sh'"

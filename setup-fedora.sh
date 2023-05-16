#!/bin/bash

SECONDS=0

NODE_FULL_VERSION="v18.16.0"
NODE_MAJOR_VERSION="18"

clear
echo -e "✨ @mathcale's Fedora setup wizardry ✨\n"

if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "==> Creating new SSH key..."
  ssh-keygen -t ed25519 -C "hello@matheus.me" -q -P ""
fi

mkdir -p $HOME/Dev
mkdir -p $HOME/Dev/tmp
mkdir -p $HOME/Random
mkdir -p $HOME/.goworkspace

if [ ! -d "$HOME/Dev/dotfiles" ]; then
  echo
  echo "==> Cloning 'mathcale/dotfiles'..."
  echo

  git clone https://github.com/mathcale/dotfiles.git $HOME/Dev/dotfiles
fi

echo
echo "==> Updating system dependencies..."
echo

sudo dnf upgrade -y
sudo dnf distro-sync -y
sudo dnf autoremove -y

echo
echo "==> Enabling RPM Fusion..."
echo

sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

echo
echo "=>> Adding Yarn repo..."
echo

curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo

echo
echo "==> Installing shell packages..."
echo

sudo dnf install -y \
  zsh git htop iotop neofetch zip unzip unrar \
  lm_sensors youtube-dl sqlite neovim curl wget \
  go dnf-plugins-core git-delta bat exa yarn \
  fira-code-fonts python3-virtualenv

if [ $? -ne 0 ]; then
  echo
  echo "Shell dependencies installation failed!"
  exit 1
fi

echo
echo "==> Installing GUI packages with DNF..."
echo

sudo dnf install -y \
  tilix gimp plank inkscape audacity vlc gparted \
  xsensors conky bleachbit qbittorrent cheese steam lutris \
  ulauncher gnome-tweaks

if [ $? -ne 0 ]; then
  echo
  echo "GUI packages installation failed!"
  exit 2
fi

echo
echo "==> Installing GUI packages with Flatpak..."
echo

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.brave.Browser \
  com.visualstudio.code \
  com.github.GradienceTeam.Gradience \
  com.github.tchx84.Flatseal \
  org.gnome.Extensions \
  com.ktechpit.whatsie \
  com.discordapp.Discord \
  com.mastermindzh.tidal-hifi \
  com.spotify.Client \
  net.davidotek.pupgui2

if [ $? -ne 0 ]; then
  echo
  echo "Flatpak packages installation failed!"
  exit 3
fi

echo
echo "==> Installing Docker..."
echo

sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $(whoami)

echo
echo "==> Installing Nerd Fonts..."
echo

mkdir -p $HOME/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraCode.zip
unzip FiraCode.zip -d $HOME/.fonts
fc-cache $HOME/.fonts
rm FiraCode.zip

echo
echo "==> Copying .gitconfig to home dir..."
echo

cp $HOME/Dev/dotfiles/git/.gitconfig $HOME

echo
echo "==> Copying custom scripts..."
echo

mkdir -p $HOME/.local/bin
cp $HOME/Dev/dotfiles/scripts/s0 $HOME/.local/bin
cp $HOME/Dev/dotfiles/scripts/up.fedora $HOME/.local/bin/up
chmod +x $HOME/.local/bin/*

echo
echo "🔑 Here's your public SSH key:"
cat $HOME/.ssh/id_ed25519.pub
echo

read -p "Please configure it on GitHub then press any key to proceed..." -n1 -s

echo
echo "==> Installing nvm..."
echo

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo
echo "==> Installing Node.js..."
echo

nvm install $NODE_FULL_VERSION
nvm alias $NODE_MAJOR_VERSION $NODE_FULL_VERSION
nvm alias default $NODE_MAJOR_VERSION

echo
echo "==> Installing sdkman..."
echo

curl -s "https://get.sdkman.io" | bash

echo
echo "=>> Installing jEnv..."
echo

git clone https://github.com/jenv/jenv.git ~/.jenv

echo
echo "==> Installing nvchad..."
echo

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

if [ -f $HOME/.zshrc ]; then
  echo
  echo "==> Removing existing .zshrc file..."
  echo

  rm $HOME/.zshrc
fi

echo
echo "==> Copying .zshrc to home dir..."
echo

cp $HOME/Dev/dotfiles/shell/.zshrc-linux $HOME/.zshrc

if [ ! -f $HOME/.config/starship.toml ]; then
  echo
  echo "==> Copying starship config..."
  echo

  cp $HOME/Dev/dotfiles/shell/starship.toml $HOME/.config
fi

echo
echo "==> Copying Tilix config..."
echo

dconf load /com/gexperts/Tilix/ < $HOME/Dev/dotfiles/terminal/tilix.dconf


echo
echo "==> Copying Neofetch config..."
echo

cp -R $HOME/Dev/dotfiles/neofetch $HOME/.config

echo
echo "==> Copying Neovim configs..."
echo

cp -R $HOME/Dev/dotfiles/nvim $HOME/.config


echo
echo "==> Copying Conky config..."
echo

cp -R $HOME/Dev/dotfiles/conky $HOME/.config

echo
echo "==> Installing Catppuccin GTK theme..."
echo

mkdir -p $HOME/.themes
mkdir -p $HOME/.icons

cd /tmp
git clone --recurse-submodules git@github.com:catppuccin/gtk.git
cd gtk
virtualenv -p python3 venv
source venv/bin/activate
pip install -r requirements.txt
python install.py mocha -a mauve -d $HOME/.themes
cd $HOME/Dev/dotfiles

echo
echo "=>> Installing Ulauncher 'Catppuccin' theme..."
echo

cd /tmp
git clone https://github.com/catppuccin/ulauncher.git
cd ulauncher
chmod +x ./install.sh
./install.sh --mocha-mauve
cd $HOME/Dev/dotfiles

echo
echo "==> Configuring GTK theming stuff..."
echo

mkdir -p "${HOME}/.config/gtk-4.0"
ln -sf "${THEME_DIR}/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/assets"
ln -sf "${THEME_DIR}/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk.css"
ln -sf "${THEME_DIR}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"

sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons
sudo flatpak override --env=GTK_THEME=Catppuccin-Mocha-Standard-Mauve

echo
echo "==> Cleanup..."
echo

rm -rf /tmp/gtk
rm -rf /tmp/ulauncher

echo
echo -e "🎉 Done in ${SECONDS}s\n"
echo "🖥  Run the following command to complete nvchad's installation:"
echo -e "nvim +'hi NormalFloat guibg=#1e222a' +PackerSync\n"

echo "🔑 Here's your public SSH key:"
cat $HOME/.ssh/id_ed25519.pub


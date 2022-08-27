#!/bin/bash

SECONDS=0

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
  echo "==> Cloning 'mathcale/dotfiles'..."
  git clone https://github.com/mathcale/dotfiles.git $HOME/Dev/dotfiles
fi

echo "==> Updating system dependencies..."
sudo dnf upgrade -y
sudo dnf distro-sync -y
sudo dnf autoremove -y

echo "==> Installing core packages..."
sudo dnf install -y \
  zsh git htop iotop neofetch zip unzip unrar \
  lm_sensors youtube-dl sqlite neovim curl wget \
  go dnf-plugins-core

echo "==> Installing GUI packages..."
sudo dnf install -y \
  tilix gimp plank inkscape audacity vlc gparted \
  xsensors conky bleachbit qbittorrent cheese steam lutris

echo "==> Installing Docker..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker

echo "==> Copying .gitconfig to home dir..."
cp $HOME/Dev/dotfiles/git/.gitconfig $HOME

echo "==> Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

if [ -z "$ZSH_CUSTOM" ]; then
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
  mkdir -p $ZSH_CUSTOM
fi

echo "==> Installing spaceship-prompt..."
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "==> Installing starship-prompt..."
curl -sS https://starship.rs/install.sh | sh

echo "==> Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "==> Installing sdkman..."
curl -s "https://get.sdkman.io" | bash

echo "=>> Installing jEnv..."
git clone https://github.com/jenv/jenv.git ~/.jenv

echo "==> Installing nvchad..."
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

if [ -f $HOME/.zshrc ]; then
  echo "Removing existing .zshrc file..."
  rm $HOME/.zshrc
fi

echo "==> Copying .zshrc to home dir..."
cp $HOME/Dev/dotfiles/shell/.zshrc-linux $HOME/.zshrc

echo -e "🎉 Done in ${SECONDS}s\n"
echo "🖥  Run the following command to complete nvchad's installation:"
echo -e "nvim +'hi NormalFloat guibg=#1e222a' +PackerSync\n"

echo "🔑 Here's your public SSH key:"
cat $HOME/.ssh/id_ed25519.pub


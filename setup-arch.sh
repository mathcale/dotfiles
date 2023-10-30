#!/bin/bash

SECONDS=0

NODE_FULL_VERSION="v18.18.0"
NODE_MAJOR_VERSION="18"

clear
echo -e "✨ @mathcale's Arch setup wizardry ✨\n"

if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "==> Creating new SSH key..."
  ssh-keygen -t ed25519 -C "hello@matheus.me" -q -P ""
fi

mkdir -p $HOME/Dev
mkdir -p $HOME/Dev/tmp
mkdir -p $HOME/Random
mkdir -p $HOME/.goworkspace
mkdir -p $HOME/.local/bin

if [ ! -d "$HOME/Dev/dotfiles" ]; then
  echo "==> Cloning 'mathcale/dotfiles'..."
  git clone https://github.com/mathcale/dotfiles.git $HOME/Dev/dotfiles
fi

#echo "==> Enabling multilib..."
#sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

echo "==> Updating system dependencies..."
sudo pacman -Syu

echo "==> Installing core packages..."
sudo pacman -Sy \
  zsh git htop iotop neofetch zip unzip unrar \
  lm_sensors sqlite3 neovim curl wget \
  docker docker-compose yarn go

echo "==> Installing GUI packages..."
sudo pacman -Sy \
  gimp inkscape vlc gparted \
  xsensors conky bleachbit qbittorrent cheese steam lutris \
  ttf-fira-code

#echo "==> Installing 'yay'..."
#git clone https://aur.archlinux.org/yay.git $HOME/.cache/install-packages/yay
#cd $HOME/.cache/install-packages/yay
#makepkg -si
#cd -

echo "==> Installing packages from AUR with 'yay'..."
yay --noconfirm -Sy visual-studio-code-bin neovim \
  tidal-hifi-bin spotify parsec-bin teamviewer nomachine \
  sublime-text-4 insomnia-bin ferdium-bin figma-linux-bin \
  nerd-fonts-fira-code minecraft-launcher ttf-ms-fonts

echo "==> Copying .gitconfig to home dir..."
cp $HOME/Dev/dotfiles/git/.gitconfig $HOME

echo "==> Copying scripts..."
cp $HOME/Dev/dotfiles/scripts/s0 $HOME/.local/bin/s0
cp $HOME/Dev/dotfiles/scripts/up.arch $HOME/.local/bin/up

chmod +x $HOME/.local/bin/*

#echo "==> Installing oh-my-zsh..."
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#if [ -z "$ZSH_CUSTOM" ]; then
#  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
#  mkdir -p $ZSH_CUSTOM
#fi

#echo "==> Installing spaceship-prompt..."
#git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
#ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

#echo "==> Installing starship-prompt..."
#curl -sS https://starship.rs/install.sh | sh

#echo "==> Installing nvm..."
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

#echo "==> Installing Node.js..."
#nvm install $NODE_FULL_VERSION
#nvm alias $NODE_MAJOR_VERSION $NODE_FULL_VERSION
#nvm alias default $NODE_MAJOR_VERSION

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

#if [ ! -f $HOME/.config/starship.toml ]; then
#  echo "==> Copying starship config..."
#  cp $HOME/Dev/dotfiles/shell/starship.toml $HOME/.config
#fi

#echo "==> Copying Tilix config..."
#dconf load /com/gexperts/Tilix/ < $HOME/Dev/dotfiles/terminal/tilix.dconf

echo -e "🎉 Done in ${SECONDS}s\n"
echo "🖥  Run the following command to complete nvchad's installation:"
echo -e "nvim +'hi NormalFloat guibg=#1e222a' +PackerSync\n"

echo "🔑 Here's your public SSH key:"
cat $HOME/.ssh/id_ed25519.pub


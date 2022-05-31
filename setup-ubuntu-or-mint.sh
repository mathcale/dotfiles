#!/bin/bash

PPAS=("ppa:neovim-ppa/stable" "ppa:obsproject/obs-studio")

echo "@mathcale's Linux Mint/Ubuntu setup wizardry ✨"

if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating new SSH key..."

  ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/id_rsa -q -P ""
  ssh-add ~/.ssh/id_rsa
fi

echo "==> Updating system dependencies..."

sudo apt update
sudo apt full-upgrade -y

echo "==> Adding PPAs..."

for PPA in ${PPAS[@]}; do
  sudo add-apt-repository $PPA -y
done

echo "==> Installing core packages..."

echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
sudo apt install -y zsh git build-essential htop iotop neofetch zip unzip rar unrar lm-sensors youtube-dl apt-transport-https zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev ttf-mscorefonts-installer neovim curl

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt install yarn -y --no-install-recommends

echo "==> Installing GUI packages..."

sudo apt install -y tilix gimp plank inkscape audacity vlc gparted xsensors conky bleachbit typecatcher qbittorrent cheese

echo "==> Creating 'Dev' and 'Random' dirs..."

mkdir -p $HOME/Dev
mkdir -p $HOME/Dev/tmp
mkdir -p $HOME/Random

echo "==> Cloning 'mathcale/dotfiles'..."

cd $HOME/Dev
git clone https://github.com/mathcale/dotfiles.git
cd $HOME

if [ -f $HOME/.zshrc ]; then
  echo "==> Removing existing .zshrc file..."

  rm $HOME/.zshrc
fi

echo "==> Copying .zshrc to home dir..."
cp $HOME/Dev/dotfiles/shell/.zshrc $HOME

echo "==> Copying .gitconfig to home dir..."
cp $HOME/Dev/dotfiles/git/.gitconfig $HOME

echo "==> Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "==> Installing spaceship-prompt..."

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "==> Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "==> Installing sdkman..."
curl -s "https://get.sdkman.io" | bash

echo "==> Installing nvchad..."

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
echo "==> Run 'nvim +'hi NormalFloat guibg=#1e222a' +PackerSync' to complete installation!"

echo "🎉 Done!"

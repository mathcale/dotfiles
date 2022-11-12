#!/bin/bash

SECONDS=0

PPAS=("ppa:neovim-ppa/unstable")

GO_VERSION="1.18.2"
NODE_FULL_VERSION="v18.12.1"
NODE_MAJOR_VERSION="18"

echo -e "✨ @mathcale's WSL2 setup wizardry ✨\n"

if [ ! -f $HOME/.ssh/id_rsa ]; then
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

sudo apt update
sudo apt full-upgrade -y

echo "==> Adding PPAs..."

for PPA in ${PPAS[@]}; do
  sudo add-apt-repository $PPA -y
done

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

echo "==> Installing core packages..."

echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

sudo apt install -y \
  zsh git build-essential htop iotop neofetch \
  zip unzip rar unrar lm-sensors youtube-dl \
  apt-transport-https zlib1g-dev libssl-dev \
  libreadline-dev libyaml-dev libsqlite3-dev \
  sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev neovim curl

sudo apt install yarn -y --no-install-recommends

echo "==> Copying .gitconfig to home dir..."
cp $HOME/Dev/dotfiles/git/.gitconfig $HOME

echo "==> Copying scripts..."
cp $HOME/Dev/dotfiles/scripts/s0 $HOME/.local/bin
cp $HOME/Dev/dotfiles/scripts/up.debian $HOME/.local/bin/up

chmod +x $HOME/.local/bin/*

echo "==> Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "==> Installing spaceship-prompt..."
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "==> Installing starship-prompt..."
curl -sS https://starship.rs/install.sh | sh

echo "==> Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "==> Installing Node.js..."
nvm install $NODE_FULL_VERSION
nvm alias $NODE_MAJOR_VERSION $NODE_FULL_VERSION
nvm alias default $NODE_MAJOR_VERSION

echo "==> Installing sdkman..."
curl -s "https://get.sdkman.io" | bash

echo "==> Installing Go..."
wget "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"

echo "==> Installing nvchad..."
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

if [ -f $HOME/.zshrc ]; then
  echo "==> Removing existing .zshrc file..."
  rm $HOME/.zshrc
fi

echo "==> Copying .zshrc to home dir..."
cp $HOME/Dev/dotfiles/shell/.zshrc-linux $HOME/.zshrc

if [ ! -f $HOME/.config/starship.toml ]; then
  echo "==> Copying starship config..."
  cp $HOME/Dev/dotfiles/shell/starship.toml $HOME/.config
fi

echo -e "🎉 Done in ${SECONDS}s\n"
echo "💻 Run the following command to complete nvchad's installation:"
echo -e "nvim +'hi NormalFloat guibg=#1e222a' +PackerSync\n"

echo "🔑 Here's your public SSH key:"
cat $HOME/.ssh/id_rsa.pub

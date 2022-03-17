#!/bin/bash

echo "@mathcale's macOS setup wizardry ✨"

if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating new SSH key..."

  ssh-keygen -t rsa -b 4096 -q -P ""
  ssh-add ~/.ssh/id_rsa
fi

echo "Copying SSH public key to clipboard..."
cat .ssh/id_rsa.pub | pbcopy

mkdir -p $HOME/Dev
mkdir -p $HOME/Dev/tmp
mkdir -p $HOME/Random

echo "Cloning 'mathcale/dotfiles'..."

cd $HOME/Dev
git clone https://github.com/mathcale/dotfiles.git
cd $HOME

echo "Installing Homebrew..."

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ -f $HOME/.zshrc ]; then
  echo "Removing existing .zshrc file..."

  rm $HOME/.zshrc
fi

echo "Copying .zshrc to home dir..."
cp $HOME/Dev/dotfiles/shell/.zshrc-mac $HOME/.zshrc

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing spaceship-prompt..."

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "Installing sdkman..."
curl -s "https://get.sdkman.io" | bash

echo "Installing brew taps, packages and casks..."

cd $HOME/Dev/dotfiles/brew
brew bundle

echo "Installing nvchad..."

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
echo "Open neovim and run 'nvim +'hi NormalFloat guibg=#1e222a' +PackerSync' to complete installation!"

echo "🎉 Done!"

#!/bin/bash

SECONDS=0

clear
echo -e "✨ @mathcale's macOS setup wizardry ✨\n"

if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "==> Creating new SSH key..."
  ssh-keygen -t ed25519 -C "hello@matheus.me" -q -P ""
fi

mkdir -p $HOME/Dev
mkdir -p $HOME/Dev/tmp
mkdir -p $HOME/Random
mkdir -p $HOME/.goworkspace

echo "==> Cloning 'mathcale/dotfiles'..."
git clone https://github.com/mathcale/dotfiles.git $HOME/Dev/dotfiles

echo "==> Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "==> Installing brew taps, packages and casks..."
cd $HOME/Dev/dotfiles/brew
brew bundle

echo "==> Copying .gitconfig to home dir..."
cp $HOME/Dev/dotfiles/git/.gitconfig $HOME

echo "==> Copying scripts..."
cp $HOME/Dev/dotfiles/scripts/s0 $HOME/.local/bin
cp $HOME/Dev/dotfiles/scripts/up.brew $HOME/.local/bin/up

chmod +x $HOME/.local/bin/*

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
  echo "==> Removing existing .zshrc file..."
  rm $HOME/.zshrc
fi

echo "==> Copying .zshrc to home dir..."
cp $HOME/Dev/dotfiles/shell/.zshrc-mac $HOME/.zshrc

echo -e "🎉 Done in ${SECONDS}s\n"
echo "🖥  Run the following command to complete nvchad's installation:"
echo -e "nvim +'hi NormalFloat guibg=#1e222a' +PackerSync\n"

echo "🔑 Here's your public SSH key:"
cat $HOME/.ssh/id_rsa.pub

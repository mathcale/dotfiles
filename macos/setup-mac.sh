#!/bin/bash

SECONDS=0

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
cd $HOME/Dev/dotfiles/macos/brew
brew bundle

echo "==> Copying .gitconfig to home dir..."
cp $HOME/Dev/dotfiles/macos/git/.gitconfig $HOME

echo "==> Copying scripts..."
cp $HOME/Dev/dotfiles/macos/scripts/s0 $HOME/.local/bin
cp $HOME/Dev/dotfiles/macos/scripts/up $HOME/.local/bin/up

chmod +x $HOME/.local/bin/*

echo "==> Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

if [ -z "$ZSH_CUSTOM" ]; then
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
  mkdir -p $ZSH_CUSTOM
fi

echo "==> Installing starship-prompt..."
curl -sS https://starship.rs/install.sh | sh

echo "==> Installing sdkman..."
curl -s "https://get.sdkman.io" | bash

echo "=>> Installing jEnv..."
git clone https://github.com/jenv/jenv.git ~/.jenv

if [ -f $HOME/.zshrc ]; then
  echo "==> Removing existing .zshrc file..."
  rm $HOME/.zshrc
fi

echo "==> Copying .zshrc to home dir..."
cp $HOME/Dev/dotfiles/shell/.zshrc-mac $HOME/.zshrc

echo "🎉 Done in ${SECONDS}s"
echo "🔑 Here's your public SSH key:"
cat $HOME/.ssh/id_ed25519.pub

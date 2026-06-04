#!/bin/bash

SECONDS=0
DOTFILES="$HOME/Dev/dotfiles"

echo -e "@mathcale's macOS setup wizardry\n"

if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "==> Creating new SSH key..."
  ssh-keygen -t ed25519 -C "hello@matheus.me" -q -P ""
fi

mkdir -p $HOME/Dev $HOME/Dev/tmp $HOME/Random $HOME/.goworkspace $HOME/.local/bin

if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "==> Homebrew already installed, skipping."
fi

echo "==> Installing brew packages and casks..."
cd $DOTFILES/macos/brew
brew bundle

echo "==> Symlinking dotfiles..."

ln -sf $DOTFILES/cross/git/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES/cross/git/theme.gitconfig $HOME/.gitconfig-theme

mkdir -p $HOME/.config/kitty
ln -sf $DOTFILES/cross/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
ln -sf $DOTFILES/cross/kitty/themes $HOME/.config/kitty/themes

ln -sf $DOTFILES/cross/nvim $HOME/.config/nvim
ln -sf $DOTFILES/cross/starship.toml $HOME/.config/starship.toml

ln -sf $DOTFILES/macos/zsh/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/macos/zsh/.zprofile $HOME/.zprofile
ln -sf $DOTFILES/macos/zsh/.workrc $HOME/.workrc

echo "==> Symlinking scripts..."
ln -sf $DOTFILES/macos/scripts/s0 $HOME/.local/bin/s0
ln -sf $DOTFILES/macos/scripts/up $HOME/.local/bin/up
chmod +x $HOME/.local/bin/*

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  if [ -z "$ZSH_CUSTOM" ]; then
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    mkdir -p $ZSH_CUSTOM
  fi
else
  echo "==> oh-my-zsh already installed, skipping."
fi

if [ ! -d "$HOME/Pictures/wallpapers" ]; then
  echo "==> Cloning wallpapers..."
  git clone https://github.com/mathcale/wallpapers.git $HOME/Pictures/wallpapers
else
  echo "==> Wallpapers already present, skipping."
fi

echo ""
echo "Done in ${SECONDS}s"
echo "Public SSH key:"
cat $HOME/.ssh/id_ed25519.pub

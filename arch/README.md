# Arch Linux Dotfiles

Hard fork from Stephan Raabe's [dotfiles](https://gitlab.com/stephan-raabe/dotfiles).

## Common Packages

- **Terminal**: Kitty
- **Editors**: Neovim (feat. LunarVim), Visual Studio Code and Sublime Text
- **Shell**: zsh
- **Prompt**: Starship
- **Glyphs**: Font Awesome
- **Menus**: Rofi
- **Color scheme**: Catppuccin Mocha
- **Browser**: Firefox
- **File manager**: Thunar
- **Cursor**: Dracula
- **Icons**: Kora

## Hyprland

- **Status Bar**: waybar
- **Screenshots**: grim & slurp
- **Clipboard Manager**: cliphist
- **Logout**: wlogout
- **Screenlock**: swaylock-effects

## Getting started

To make it easy for you to get started with my dotfiles, here's a list of recommended next steps.

PLEASE BACKUP YOUR EXISTING .config WITH YOUR DOTFILES BEFORE STARTING THE SCRIPTS.

```sh
# Make sure that you're in your home directory
cd

# Clone the repository from your home directory
git clone https://github.com/mathcale/dotfiles.git

# Change into the new dotfiles folder
cd dotfiles/arch

# Install all required packages
./1-install.sh

# Install hyprland window manager
./2-install-hyprland.sh

# Install dotfiles
./3-install-dotfiles.sh
```

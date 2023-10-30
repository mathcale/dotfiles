# Arch Linux Dotfiles

Hard fork from Stephan Raabe's [dotfiles](https://gitlab.com/stephan-raabe/dotfiles).

## Common Packages

- **Terminal**: kitty
- **Editor**: nvim
- **Shell**: zsh
- **Prompt**: starship
- **Icons**: Font Awesome
- **Menus**: Rofi
- **Colorscheme**: pywal (dynamic)
- **Browser**: Firefox
- **Filemanager**: Thunar
- **Cursor**: Dracula
- **Icons**: Kora

## Hyprland

- **Status Bar**: waybar
- **Screenshots**: grim & slurp
- **Clipboard Manager**: cliphist
- **Logout**: wlogout
- **Screenlock**: swaylock-effects

## Templating

Included is a pywal configuration that changes the color scheme based on a randomly selected wallpaper. With the key binding `Super + Shift + w` you can change the wallpaper. `Super + Ctrl + w` opens rofi with a list of installed wallpapers for your individual selection. See also the .bashrc and the key bindings on Hyprland for more alias definitions.

In addition, you can switch the Waybar Template with SUPER + CTRL + T or by pressing the "..." icon in Waybar. The templates are available in ~/dev/dotfiles/arch/waybar/themes. You can add your own personal themes into this folder. The script will read in the folder structure.

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

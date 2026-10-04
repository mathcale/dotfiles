#!/bin/bash

echo ""
echo "✨ @mathcale's Arch Linux base setup shenanigans ✨"
echo "Heavily inspired by Stephan Raabe's dotfiles"
echo "Original source: https://gitlab.com/stephan-raabe/dotfiles"
echo ""

source ~/dotfiles/arch/scripts/library.sh

if [ ! -d ~/.config ]; then
  mkdir ~/.config
  echo "👌 ~/.config folder created."
fi

if [ ! -d ~/Dev ]; then
  mkdir ~/Dev
  echo "👌 ~/Dev folder created."
fi

if [ ! -d ~/Random ]; then
  mkdir ~/Random
  echo "👌 ~/Random folder created."
fi

if [ ! -d ~/.goworkspace ]; then
  mkdir ~/.goworkspace
  echo "👌 ~/.goworkspace folder created."
fi

if [ ! -d ~/.local/bin ]; then
  mkdir -p ~/.local/bin
  echo "👌 ~/.local/bin folder created."
fi

if [ ! -f ~/.privaterc ]; then
  touch ~/.privaterc
fi

echo ""
echo "==> Installing general dotfiles"
# Syntax: name link source target-dir

_installSymLink .zshrc ~/.zshrc ~/dotfiles/arch/shell/.zshrc ~/.zshrc
_installSymLink .warprc ~/.warprc ~/dotfiles/arch/shell/.warprc ~/.warprc
_installSymLink .gitconfig ~/.gitconfig ~/dotfiles/cross/git/.gitconfig ~/.gitconfig
_installSymLink .gitconfig-theme ~/.gitconfig-theme ~/dotfiles/cross/git/theme.gitconfig ~/.gitconfig-theme
_installSymLink kitty ~/.config/kitty ~/dotfiles/cross/kitty ~/.config
_installSymLink starship ~/.config/starship.toml ~/dotfiles/cross/starship.toml ~/.config/starship.toml
_installSymLink fastfetch ~/.config/fastfetch ~/dotfiles/arch/fastfetch/ ~/.config
_installSymLink nvim ~/.config/nvim ~/dotfiles/cross/nvim/ ~/.config
_installSymLink ulauncher ~/.config/ulauncher ~/dotfiles/arch/ulauncher ~/.config
_installSymLink xdg-terminals.list ~/.config/xdg-terminals.list ~/dotfiles/arch/xdg-terminals.list ~/.config/xdg-terminals.list
_installSymLink Kvantum ~/.config/Kvantum ~/dotfiles/arch/Kvantum/ ~/.config
_installSymLink mimeapps.list ~/.config/mimeapps.list ~/dotfiles/arch/hypr/mimeapps.list ~/.config/mimeapps.list
_installSymLink opencode.jsonc ~/.config/opencode/opencode.jsonc ~/dotfiles/cross/opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc

echo ""
echo "==> Installing shared agent config (OpenCode, Copilot, Pi)"

if [ ! -d ~/.claude ]; then
  mkdir -p ~/.claude
  echo "👌 ~/.claude folder created."
fi

if [ ! -d ~/.copilot ]; then
  mkdir -p ~/.copilot
  echo "👌 ~/.copilot folder created."
fi

if [ ! -d ~/.pi/agent ]; then
  mkdir -p ~/.pi/agent
  echo "👌 ~/.pi/agent folder created."
fi

if [ ! -d ~/.agents ]; then
  mkdir -p ~/.agents
  echo "👌 ~/.agents folder created."
fi

_installSymLink opencode-AGENTS.md ~/.config/opencode/AGENTS.md ~/dotfiles/cross/agents/AGENTS.md ~/.config/opencode/AGENTS.md
_installSymLink opencode-agents ~/.config/opencode/agents ~/dotfiles/cross/agents/agents ~/.config/opencode/agents
_installSymLink agents-skills ~/.agents/skills ~/dotfiles/cross/agents/skills ~/.agents/skills
_installSymLink claude-CLAUDE.md ~/.claude/CLAUDE.md ~/dotfiles/cross/agents/AGENTS.md ~/.claude/CLAUDE.md
_installSymLink copilot-agents ~/.copilot/agents ~/dotfiles/cross/agents/agents ~/.copilot/agents
_installSymLink pi-AGENTS.md ~/.pi/agent/AGENTS.md ~/dotfiles/cross/agents/AGENTS.md ~/.pi/agent/AGENTS.md

echo ""
echo "==> Installing GTK dotfiles"

_installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 ~/dotfiles/arch/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
_installSymLink gtk-3.0 ~/.config/gtk-3.0 ~/dotfiles/arch/gtk/gtk-3.0/ ~/.config/

echo ""
echo "==> Installing Catppuccin-GTK-Theme"

CATPPUCCIN_GTK_THEME_DIR="$HOME/Random/Catppuccin-GTK-Theme"

if [ ! -d "$CATPPUCCIN_GTK_THEME_DIR" ]; then
  git clone git@github.com:Fausto-Korpsvart/Catppuccin-GTK-Theme.git "$CATPPUCCIN_GTK_THEME_DIR"
  echo "👌 Catppuccin-GTK-Theme cloned."
else
  echo "👌 Catppuccin-GTK-Theme already present, skipping clone."
fi

# ~/.config/gtk-4.0 is normally a symlink into this dotfiles repo (see below),
# managed by Noctalia's app-theming templates. Unlink it first so the installer's
# --libadwaita (-l) step writes its generated theme symlinks to a plain directory
# instead of clobbering the repo-tracked files through the symlink.
if [ -L ~/.config/gtk-4.0 ]; then
  unlink ~/.config/gtk-4.0
fi

(cd "$CATPPUCCIN_GTK_THEME_DIR/themes" && ./install.sh -l -a mauve --shell no-border --tweaks macos)
echo "👌 Catppuccin-GTK-Theme installed."

echo ""
echo "==> Restoring Noctalia's GTK4 config"

# Reasserts Noctalia's generated theme as the authority over ~/.config/gtk-4.0,
# discarding whatever --libadwaita just linked there.
_installSymLink gtk-4.0 ~/.config/gtk-4.0 ~/dotfiles/arch/gtk/gtk-4.0/ ~/.config/

echo ""
echo "==> Applying Flatpak theme overrides"

sudo flatpak override --filesystem="$HOME/.themes"
sudo flatpak override --filesystem="$HOME/.icons"
flatpak override --user --filesystem=xdg-config/gtk-4.0
echo "👌 Flatpak theme overrides applied."

echo ""
echo "==> Installing Hyprland dotfiles"

_installSymLink hypr ~/.config/hypr ~/dotfiles/arch/hypr/ ~/.config

echo ""
echo "==> Installing Noctalia dotfiles"

mkdir -p ~/.config/noctalia
_installSymLink config.toml ~/.config/noctalia/config.toml ~/dotfiles/arch/noctalia/config.toml ~/.config/noctalia/config.toml

# GUI-managed overrides; loads after config.toml and wins on conflicts.
mkdir -p ~/.local/state/noctalia
_installSymLink settings.toml ~/.local/state/noctalia/settings.toml ~/dotfiles/arch/noctalia/settings.toml ~/.local/state/noctalia/settings.toml

echo ""
echo "==> Installing environment.d overrides"

if [ ! -d ~/.config/environment.d ]; then
  mkdir -p ~/.config/environment.d
  echo "👌 ~/.config/environment.d folder created."
fi

_installSymLink 90-dms.conf ~/.config/environment.d/90-dms.conf ~/dotfiles/arch/environment.d/90-dms.conf ~/.config/environment.d/90-dms.conf

echo ""
echo "==> Applying GNOME keybindings"

dconf load / <~/dotfiles/arch/dconf/gnome.conf
echo "👌 GNOME keybindings applied."

echo ""
echo "==> Enabling hyprland-resume service (reloads monitor config after suspend)"

_installSymLink hyprland-resume.service \
  ~/.config/systemd/user/hyprland-resume.service \
  ~/dotfiles/arch/systemd/hyprland-resume.service \
  ~/.config/systemd/user/hyprland-resume.service

systemctl --user daemon-reload
systemctl --user enable hyprland-resume.service
echo "👌 hyprland-resume service enabled."

echo ""
echo "==> Enabling ulauncher service (GNOME only)"

if [ ! -d ~/.config/systemd/user/ulauncher.service.d ]; then
  mkdir -p ~/.config/systemd/user/ulauncher.service.d
  echo "👌 ~/.config/systemd/user/ulauncher.service.d folder created."
fi

_installSymLink gnome-only.conf \
  ~/.config/systemd/user/ulauncher.service.d/gnome-only.conf \
  ~/dotfiles/arch/systemd/ulauncher.service.d/gnome-only.conf \
  ~/.config/systemd/user/ulauncher.service.d/gnome-only.conf

systemctl --user daemon-reload
systemctl --user enable --now ulauncher.service
echo "👌 ulauncher service enabled (restricted to GNOME sessions)."

echo ""
echo "==> Restoring wallpapers"

# Noctalia's own wallpaper is restored automatically from the symlinked
# ~/.config/noctalia/config.toml ([wallpaper] section) above.
GNOME_WALLPAPER="file://$HOME/Pictures/wallpapers/valentine-dexheimer-wzTSUHBRVJU-unsplash.jpg"

# GNOME: restore via gsettings
if command -v gsettings &>/dev/null; then
  gsettings set org.gnome.desktop.background picture-uri "$GNOME_WALLPAPER"
  gsettings set org.gnome.desktop.background picture-uri-dark "$GNOME_WALLPAPER"

  echo "👌 GNOME wallpaper set to $GNOME_WALLPAPER"
fi

echo ""
echo "==> Restoring user avatar"

if [ -f ~/dotfiles/arch/avatar.png ]; then
  cp ~/dotfiles/arch/avatar.png ~/.face

  if [ -d /var/lib/AccountsService/icons ]; then
    sudo cp ~/dotfiles/arch/avatar.png "/var/lib/AccountsService/icons/$USER"
    sudo chown root:root "/var/lib/AccountsService/icons/$USER"
    sudo chmod 644 "/var/lib/AccountsService/icons/$USER"
  fi

  echo "👌 User avatar restored."
fi

echo ""
echo "==> Copying scripts"

cp ~/dotfiles/arch/scripts/s0 ~/.local/bin/s0
cp ~/dotfiles/arch/scripts/up.sh ~/.local/bin/up
cp ~/dotfiles/arch/scripts/screenshot.sh ~/.local/bin/screenshot

chmod +x ~/.local/bin/*

echo "🎉 Done! Please reboot your system!"

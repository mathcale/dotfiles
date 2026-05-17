#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Updating package lists in ${DOTFILES_DIR}"

pacman -Qqen > "${DOTFILES_DIR}/pkglist-repo.txt"
echo "  pacman : $(wc -l < "${DOTFILES_DIR}/pkglist-repo.txt") packages -> pkglist-repo.txt"

pacman -Qqem > "${DOTFILES_DIR}/pkglist-aur.txt"
echo "  aur    : $(wc -l < "${DOTFILES_DIR}/pkglist-aur.txt") packages -> pkglist-aur.txt"

flatpak list --app --columns=application 2>/dev/null > "${DOTFILES_DIR}/pkglist-flatpak.txt"
echo "  flatpak: $(wc -l < "${DOTFILES_DIR}/pkglist-flatpak.txt") packages -> pkglist-flatpak.txt"

echo "Done."

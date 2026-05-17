#!/bin/bash

set -x

DEVEL_FLAG=""
for arg in "$@"; do
  case "$arg" in
    --devel|-d)
      DEVEL_FLAG="--devel"
      ;;
  esac
done

sudo pacman --noconfirm -Syu
yay --noconfirm -Syu $DEVEL_FLAG
flatpak upgrade -y

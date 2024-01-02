#!/bin/bash

set -x

sudo pacman --noconfirm -Syu
yay --noconfirm -Syu
flatpak upgrade -y

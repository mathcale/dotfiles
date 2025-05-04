#!/bin/sh

THEME="2025"

killall waybar
waybar \
  -c ~/dotfiles/arch/waybar/themes/$THEME/config \
  -s ~/dotfiles/arch/waybar/themes/$THEME/style.css &

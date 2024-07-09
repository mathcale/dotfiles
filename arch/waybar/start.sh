#!/bin/sh

killall waybar
waybar \
  -c ~/dotfiles/arch/waybar/themes/2024/config \
  -s ~/dotfiles/arch/waybar/themes/2024/style.css &

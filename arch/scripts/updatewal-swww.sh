#!/bin/bash

wal -q -i ~/wallpapers/default.jpg

source "$HOME/.cache/wal/colors.sh"
cp $wallpaper ~/.cache/current_wallpaper.jpg

newwall=$(echo $wallpaper | sed "s|$HOME/wallpapers/||g")

swww img $wallpaper \
  --transition-bezier .43,1.19,1,.4 \
  --transition-fps=60 \
  --transition-type="random" \
  --transition-duration=0.7 \
  --transition-pos "$( hyprctl cursorpos )"

~/dotfiles/arch/waybar/launch.sh

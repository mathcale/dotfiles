#!/bin/bash

DIR="$HOME/Pictures/Screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

option2="Selected area"
option3="Fullscreen (delay 2 sec)"

options="$option2\n$option3"

choice=$(echo -e "$options" | rofi -dmenu -config ~/dotfiles/arch/rofi/config-screenshot.rasi -i -no-show-icons -l 4 -width 30 -p "Take Screenshot")

case $choice in
  $option2)
    grim -g "$(slurp)" - | swappy -f -
    # grim -g "$(slurp)" $(xdg-user-dir PICTURES)/screenshots/$(date +'%s_grim.png')
    notify-send "Screenshot created" "Mode: Selected area"
  ;;
  $option3)
    sleep 2
    grim - | swappy -f -
    # grim $(xdg-user-dir PICTURES)/screenshots/$(date +'%s_grim.png')
    notify-send "Screenshot created" "Mode: Fullscreen"
  ;;
esac

#!/bin/bash

DIR="$HOME/Pictures/screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

option1="Selected window (delay 2 sec)"
option2="Selected area"
option3="Fullscreen (delay 2 sec)"

options="$option2\n$option3\n$option1"

choice=$(echo -e "$options" | rofi -i -dmenu -config ~/dotfiles/arch/rofi/config-screenshot.rasi -width 30 -p "Take Screenshot")

case $choice in
  $option1)
    scrot $DIR$NAME -d 2 -e 'xclip -selection clipboard -t image/png -i $f' -c -z -u
    notify-send "Screenshot created" "Mode: Selected window"
    ;;
  $option2)
    scrot $DIR$NAME -s -e 'xclip -selection clipboard -t image/png -i $f'
    notify-send "Screenshot created" "Mode: Selected area"
    ;;
  $option3)
    scrot $DIR$NAME -d 2 -e 'xclip -selection clipboard -t image/png -i $f'
    notify-send "Screenshot created" "Mode: Fullscreen"
    ;;
esac

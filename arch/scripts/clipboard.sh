#!/bin/bash

case $1 in
  d)
    cliphist list | rofi -dmenu -config ~/dotfiles/arch/rofi/config-clipboard.rasi | cliphist delete
    ;;

  w)
    if [ $(echo -e "Clear\nCancel" | rofi -dmenu -config ~/dotfiles/arch/rofi/config-short.rasi) == "Clear" ]; then
      cliphist wipe
    fi
    ;;

  *)
    cliphist list | rofi -dmenu -config ~/dotfiles/arch/rofi/config-clipboard.rasi | cliphist decode | wl-copy
    ;;
esac

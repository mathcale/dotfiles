#!/bin/bash

if pidof -s -q waybar; then
  killall waybar
else
  . $HOME/dotfiles/arch/waybar/start.sh
fi

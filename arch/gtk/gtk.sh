#!/bin/sh

CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
if [ ! -f "$CONFIG" ]; then exit 1; fi

GNOME_SCHEMA="org.gnome.desktop.interface"
GTK_THEME="$(grep 'gtk-theme-name' "$CONFIG" | sed 's/.*\s*=\s*//')"
ICON_THEME="$(grep 'gtk-icon-theme-name' "$CONFIG" | sed 's/.*\s*=\s*//')"
CURSOR_THEME="$(grep 'gtk-cursor-theme-name' "$CONFIG" | sed 's/.*\s*=\s*//')"
FONT_NAME="$(grep 'gtk-font-name' "$CONFIG" | sed 's/.*\s*=\s*//')"

gsettings set "$GNOME_SCHEMA" gtk-theme "$GTK_THEME"
gsettings set "$GNOME_SCHEMA" icon-theme "$ICON_THEME"
gsettings set "$GNOME_SCHEMA" cursor-theme "$CURSOR_THEME"
gsettings set "$GNOME_SCHEMA" font-name "$FONT_NAME"

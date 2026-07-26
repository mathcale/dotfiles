#!/usr/bin/env bash
# Launch 1Password minimized to tray, waiting for the StatusNotifierWatcher
# DBus service to be ready first. Without this, the tray icon silently fails
# to register when 1Password starts before the tray host (e.g. Waybar, DMS).

until dbus-send \
    --session \
    --print-reply \
    --dest=org.freedesktop.DBus \
    /org/freedesktop/DBus \
    org.freedesktop.DBus.GetNameOwner \
    string:org.kde.StatusNotifierWatcher \
    &>/dev/null; do
  sleep 0.5
done

exec 1password --silent

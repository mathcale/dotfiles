#!/usr/bin/env bash
# Launch ProtonVPN minimized to tray, waiting for the StatusNotifierWatcher
# DBus service to be ready first. Without this, the tray icon silently fails
# to register and --start-minimized is ignored (the app opens its window
# unconditionally when no tray is detected at startup).

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

exec protonvpn-app --start-minimized

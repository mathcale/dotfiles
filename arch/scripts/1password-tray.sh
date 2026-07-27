#!/usr/bin/env bash

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

#!/usr/bin/env bash

PADDING=5

ACTIVE_WINDOW=$(hyprctl activewindow -j)
WINDOW_TITLE=$(echo "$ACTIVE_WINDOW" | jq -r '.title // ""')

if [[ "$WINDOW_TITLE" != "Picture-in-Picture" ]]; then
  exit 0
fi

MONITOR_ID=$(echo "$ACTIVE_WINDOW" | jq -r '.monitor')
MONITOR_INFO=$(hyprctl monitors -j | jq -r ".[] | select(.id == $MONITOR_ID)")
RESERVED_TOP=$(echo "$MONITOR_INFO" | jq -r '.reserved[1]')

WIN_X=$(echo "$ACTIVE_WINDOW" | jq -r '.at[0]')
WIN_Y=$(echo "$ACTIVE_WINDOW" | jq -r '.at[1]')
WIN_W=$(echo "$ACTIVE_WINDOW" | jq -r '.size[0]')
WIN_H=$(echo "$ACTIVE_WINDOW" | jq -r '.size[1]')

MON_X=$(echo "$MONITOR_INFO" | jq -r '.x')
MON_Y=$(echo "$MONITOR_INFO" | jq -r '.y')
MON_W=$(echo "$MONITOR_INFO" | jq -r '.width')
MON_H=$(echo "$MONITOR_INFO" | jq -r '.height')

# Window center relative to the monitor (accounting for reserved top bar area)
USABLE_Y=$((MON_Y + RESERVED_TOP))
USABLE_H=$((MON_H - RESERVED_TOP))

WIN_CX=$(( WIN_X + WIN_W / 2 - MON_X ))
WIN_CY=$(( WIN_Y + WIN_H / 2 - USABLE_Y ))

# Determine nearest horizontal edge
if (( WIN_CX < MON_W / 2 )); then
  SNAP_X=$(( MON_X + PADDING ))
else
  SNAP_X=$(( MON_X + MON_W - WIN_W - PADDING ))
fi

# Determine nearest vertical edge
if (( WIN_CY < USABLE_H / 2 )); then
  SNAP_Y=$(( USABLE_Y + PADDING ))
else
  SNAP_Y=$(( MON_Y + MON_H - WIN_H - PADDING ))
fi

ADDRESS=$(echo "$ACTIVE_WINDOW" | jq -r '.address')

hyprctl dispatch movewindowpixel "exact $SNAP_X $SNAP_Y,address:$ADDRESS"

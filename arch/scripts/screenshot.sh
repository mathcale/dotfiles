#!/usr/bin/env bash
# Screenshot helper using grimblast + satty.
#
# Modes:
#   area              - select region, copy to clipboard + save
#   screen            - full screen, copy to clipboard + save
#   active            - active/focused window, copy to clipboard + save
#   area-annotate     - select region, open in satty for annotation
#   screen-annotate   - full screen, open in satty for annotation
#   active-annotate   - active window, open in satty for annotation
#
# Usage: screenshot.sh <mode>

set -euo pipefail

MODE="${1:-area}"
OUT_DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"
TS="$(date +%Y-%m-%d_%H-%M-%S)"
OUT="$OUT_DIR/$TS.png"

mkdir -p "$OUT_DIR"

notify() {
    command -v notify-send >/dev/null && notify-send -t 2500 -i image-x-generic "Screenshot" "$1" || true
}

# Map our mode to grimblast's mode (area/screen/active/output).
grimblast_mode() {
    case "$1" in
        area*)   echo "area" ;;
        screen*) echo "screen" ;;
        active*) echo "active" ;;
        *) echo "area" ;;
    esac
}

case "$MODE" in
    area|screen|active)
        # Save to file AND copy to clipboard.
        grimblast --notify copysave "$(grimblast_mode "$MODE")" "$OUT"
        ;;

    area-annotate|screen-annotate|active-annotate)
        # Capture once to a temp file, then:
        #   1. Save the raw capture to $OUT immediately, so closing satty via
        #      Super+Q / window-close still leaves an un-annotated screenshot on disk
        #      (satty has no hook for compositor-initiated close).
        #   2. Pipe the same image into satty for annotation. On Enter/Esc, satty
        #      overwrites $OUT with the annotated version and copies to clipboard.
        TMP="$(mktemp --suffix=.png)"
        trap 'rm -f "$TMP"' EXIT
        grimblast save "$(grimblast_mode "$MODE")" "$TMP"
        cp "$TMP" "$OUT"
        satty \
            --filename "$TMP" \
            --output-filename "$OUT" \
            --early-exit \
            --copy-command 'wl-copy' \
            --actions-on-enter save-to-clipboard,save-to-file \
            --actions-on-escape save-to-clipboard,save-to-file,exit
        notify "Screenshot saved to $OUT"
        ;;

    *)
        echo "usage: $0 <area|screen|active|area-annotate|screen-annotate|active-annotate>" >&2
        exit 1
        ;;
esac

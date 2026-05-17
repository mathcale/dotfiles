#!/usr/bin/env bash
# Watch DMS-generated hyprlang files and apply them to a running lua-mode Hyprland.
# Reads:  ~/.config/hypr/dms/{colors,layout,outputs}.conf
# Applies via: hyprctl eval 'hl.config(...)' / hl.monitor(...)
#
# Triggered by inotify on the dms/ directory.

set -euo pipefail

DMS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/dms"
[[ -d "$DMS_DIR" ]] || { echo "no dms dir: $DMS_DIR" >&2; exit 1; }

log() { printf '[dms-watcher %s] %s\n' "$(date +%H:%M:%S)" "$*" >&2; }

# --- translators ------------------------------------------------------------

# Strip comments and blank lines.
strip() { sed -E 's/#.*$//' "$1" | sed -E '/^\s*$/d'; }

apply_colors() {
    local f="$DMS_DIR/colors.conf"
    [[ -f "$f" ]] || return 0
    # Resolve $var = value lines, then substitute and grab col.* assignments.
    local content; content=$(strip "$f")
    # Build associative-style sed: turn $primary -> rgb(cba6f7), etc.
    local subs=""
    while IFS= read -r line; do
        if [[ "$line" =~ ^\$([A-Za-z_]+)[[:space:]]*=[[:space:]]*(.+)$ ]]; then
            subs+="s|\\\$${BASH_REMATCH[1]}|${BASH_REMATCH[2]}|g;"
        fi
    done <<< "$content"
    local resolved; resolved=$(echo "$content" | sed -E "$subs")
    # Extract general.col.active_border / inactive_border.
    local active inactive
    active=$(echo "$resolved" | awk '/^general[[:space:]]*\{/,/^\}/' | grep -E 'col\.active_border' | head -1 | sed -E 's/.*=[[:space:]]*//')
    inactive=$(echo "$resolved" | awk '/^general[[:space:]]*\{/,/^\}/' | grep -E 'col\.inactive_border' | head -1 | sed -E 's/.*=[[:space:]]*//')
    [[ -z "$active$inactive" ]] && return 0
    local lua="hl.config({general={col={"
    [[ -n "$active"   ]] && lua+="active_border=\"$active\","
    [[ -n "$inactive" ]] && lua+="inactive_border=\"$inactive\","
    lua+="}}})"
    log "colors: $lua"
    hyprctl eval "$lua" >/dev/null || log "colors apply failed"
}

apply_layout() {
    local f="$DMS_DIR/layout.conf"
    [[ -f "$f" ]] || return 0
    local content; content=$(strip "$f")
    local g_in g_out border rounding
    g_in=$(echo "$content"     | awk '/^general[[:space:]]*\{/,/^\}/'    | grep -E '^\s*gaps_in'     | head -1 | sed -E 's/.*=[[:space:]]*//')
    g_out=$(echo "$content"    | awk '/^general[[:space:]]*\{/,/^\}/'    | grep -E '^\s*gaps_out'    | head -1 | sed -E 's/.*=[[:space:]]*//')
    border=$(echo "$content"   | awk '/^general[[:space:]]*\{/,/^\}/'    | grep -E '^\s*border_size' | head -1 | sed -E 's/.*=[[:space:]]*//')
    rounding=$(echo "$content" | awk '/^decoration[[:space:]]*\{/,/^\}/' | grep -E '^\s*rounding'    | head -1 | sed -E 's/.*=[[:space:]]*//')
    local parts=""
    [[ -n "$g_in$g_out$border" ]] && {
        parts+="general={"
        [[ -n "$g_in"   ]] && parts+="gaps_in=$g_in,"
        [[ -n "$g_out"  ]] && parts+="gaps_out=$g_out,"
        [[ -n "$border" ]] && parts+="border_size=$border,"
        parts+="},"
    }
    [[ -n "$rounding" ]] && parts+="decoration={rounding=$rounding,},"
    [[ -z "$parts" ]] && return 0
    local lua="hl.config({$parts})"
    log "layout: $lua"
    hyprctl eval "$lua" >/dev/null || log "layout apply failed"
}

apply_outputs() {
    local f="$DMS_DIR/outputs.conf"
    [[ -f "$f" ]] || return 0
    # Each monitor= line becomes one hl.monitor({...}) call.
    while IFS= read -r line; do
        [[ "$line" =~ ^monitor=(.+)$ ]] || continue
        local args="${BASH_REMATCH[1]}"
        # Two formats: "name,resolution@hz,pos,scale" or "name,prop,value" (e.g. transform).
        IFS=',' read -ra p <<< "$args"
        local name="${p[0]}"
        if [[ "${#p[@]}" -ge 4 && "${p[1]}" =~ x.+@ ]]; then
            # Full monitor spec.
            local res="${p[1]}" pos="${p[2]}" scale="${p[3]}"
            local mode="${res%@*}" rate="${res#*@}"
            local mw="${mode%x*}" mh="${mode#*x}"
            local px="${pos%x*}" py="${pos#*x}"
            local lua="hl.monitor({name=\"$name\",mode={width=$mw,height=$mh,refresh_rate=$rate},position={x=$px,y=$py},scale=$scale})"
            log "output: $lua"
            hyprctl eval "$lua" >/dev/null || log "output apply failed: $line"
        elif [[ "${p[1]}" == "transform" && -n "${p[2]:-}" ]]; then
            local lua="hl.monitor({name=\"$name\",transform=${p[2]}})"
            log "output xform: $lua"
            hyprctl eval "$lua" >/dev/null || log "transform apply failed: $line"
        else
            log "skipping unrecognized monitor= line: $line"
        fi
    done < <(strip "$f" | grep -E '^monitor=')
}

apply_all() {
    apply_colors
    apply_layout
    apply_outputs
}

log "starting; watching $DMS_DIR"
apply_all  # initial sync

# CLOSE_WRITE catches atomic rewrites; MOVED_TO catches mv-into-place.
inotifywait -m -q -e close_write,moved_to --format '%f' "$DMS_DIR" |
while read -r changed; do
    case "$changed" in
        colors.conf)  apply_colors ;;
        layout.conf)  apply_layout ;;
        outputs.conf) apply_outputs ;;
        *) ;;
    esac
done

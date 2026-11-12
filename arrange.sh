#!/bin/bash
# arrange.sh — put everything back into the known-good state:
#   1. no window left in macOS native fullscreen (AeroSpace can't manage those,
#      and they make apps open a NEW window when you click their Dock icon)
#   2. every window on its app's workspace
#   3. every workspace shows one window at a time (accordion), oriented to
#      match the monitor it is on
#
# Runs at AeroSpace startup, whenever monitors are plugged or unplugged, and on
# demand with ⌃⌥/ then A. Safe to run any time; it only changes what is off.

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

LOCK_DIR="${TMPDIR:-/tmp}/aerospace_arrange.lock"
mkdir "$LOCK_DIR" 2>/dev/null || {
    # Another run is in progress (or died less than a minute ago): skip
    [ -n "$(find "$LOCK_DIR" -maxdepth 0 -mmin +1 2>/dev/null)" ] || exit 0
    rmdir "$LOCK_DIR" 2>/dev/null; mkdir "$LOCK_DIR" 2>/dev/null || exit 0
}
trap 'rmdir "$LOCK_DIR" 2>/dev/null' EXIT

# aerospace with a hard timeout (macOS has no coreutils `timeout`)
aero() { perl -e 'alarm shift; exec @ARGV' 5 aerospace "$@"; }

# 1. Leave macOS native fullscreen
aero list-windows --all --format '%{window-id}|%{window-layout}' |
    awk -F'|' '$2 == "macos_native_fullscreen" { print $1 }' |
    while read -r wid; do
        aero macos-native-fullscreen off --window-id "$wid"
        sleep 1.5 # let the macOS animation finish before the next one
    done

# 2. Every window to its app's workspace
aero run-callback --for-every-window on-window-detected >/dev/null 2>&1

# 3. One window at a time everywhere. AeroSpace numbers monitors left to right,
#    so the Nth display by x position tells us whether monitor N is portrait.
portrait=" $(sketchybar --query displays 2>/dev/null |
    jq -r 'sort_by(.frame.x, .frame.y) | to_entries[] | select(.value.frame.h > .value.frame.w) | .key + 1' 2>/dev/null | tr '\n' ' ')"

aero list-workspaces --all --format '%{workspace}|%{monitor-id}|%{workspace-root-container-layout}' |
    while IFS='|' read -r ws monitor layout; do
        want=h_accordion
        case "$portrait" in *" $monitor "*) want=v_accordion ;; esac
        [ "$layout" = "$want" ] && continue
        aero flatten-workspace-tree --workspace "$ws"
        aero layout --workspace "$ws" --root "$want"
    done >/dev/null 2>&1

# Redraw the bar
"$HOME/.config/sketchybar/plugins/workspaces.sh" >/dev/null 2>&1 &

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
#
# Usage: arrange.sh [seconds-to-wait-first]

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

[ -n "$1" ] && sleep "$1"

LOCK_DIR="${TMPDIR:-/tmp}/aerospace_arrange.lock"
PENDING="$LOCK_DIR.pending"

# aerospace with a hard timeout (macOS has no coreutils `timeout`)
aero() { perl -e 'alarm shift; exec @ARGV' 5 aerospace "$@"; }

acquire_lock() {
    mkdir "$LOCK_DIR" 2>/dev/null && { echo $$ > "$LOCK_DIR/pid"; return 0; }
    # Take over a lock left behind by a dead process
    local holder
    holder=$(cat "$LOCK_DIR/pid" 2>/dev/null)
    if [ -n "$holder" ] && ! kill -0 "$holder" 2>/dev/null; then
        rm -rf "$LOCK_DIR"
        mkdir "$LOCK_DIR" 2>/dev/null && { echo $$ > "$LOCK_DIR/pid"; return 0; }
    fi
    return 1
}

arrange() {
    local portrait ws monitor layout want wid

    # 1. Leave macOS native fullscreen
    aero list-windows --all --format '%{window-id}|%{window-layout}' |
        awk -F'|' '$2 == "macos_native_fullscreen" { print $1 }' |
        while read -r wid; do
            aero macos-native-fullscreen off --window-id "$wid"
            sleep 1.5 # let the macOS animation finish before the next one
        done

    # 2. Every window to its app's workspace
    aero run-callback --for-every-window on-window-detected >/dev/null 2>&1

    # 3. One window at a time everywhere. AeroSpace numbers monitors left to
    #    right, so the Nth display by x position says if monitor N is portrait.
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
}

if ! acquire_lock; then
    # Another run is in progress (e.g. several display events while docking);
    # ask it to go once more when it finishes, so the last state always wins
    touch "$PENDING"
    exit 0
fi
trap 'rm -rf "$LOCK_DIR"' EXIT

while :; do
    rm -f "$PENDING"
    arrange
    [ -e "$PENDING" ] || break
    sleep 1
done

# Redraw the bar. SENDER is cleared: when sketchybar's display_change event
# started this run, an inherited SENDER would make the bar script start
# arrange again, forever.
env -u SENDER "$HOME/.config/sketchybar/plugins/workspaces.sh" >/dev/null 2>&1 &

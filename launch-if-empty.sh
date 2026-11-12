#!/bin/bash
# launch-if-empty.sh <workspace> <open args...>
# Called after a "go to workspace" key press: if that workspace has no windows,
# launch its app. Runs in the background, so it never delays the switch.
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

count=$(perl -e 'alarm 3; exec @ARGV' aerospace list-windows --workspace "$1" --count) || exit 0
shift
[ "$count" = 0 ] && open "$@"

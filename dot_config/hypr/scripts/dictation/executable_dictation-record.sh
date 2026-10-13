#!/usr/bin/env bash
# Push-to-talk for voxtype: `start` begins recording, `stop` transcribes and
# types the text into the focused window. Bound to key press/release in
# hypr/land/binds.lua. The daemon must already be running (see
# dictation-daemon-toggle.sh).

set -euo pipefail

notify() { notify-send -t 1500 -i "$1" "Dictation" "$2"; }

if ! systemctl --user is-active --quiet voxtype; then
  [[ "${1:-}" == start ]] && notify microphone-sensitivity-muted "Daemon not running"
  exit 0
fi

case "${1:-}" in
  start) voxtype record start ;;
  stop) voxtype record stop ;;
  *) echo "usage: $0 start|stop" >&2; exit 2 ;;
esac

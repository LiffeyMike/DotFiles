#!/usr/bin/env bash
# Power-toggle the voxtype daemon (systemd user service) from a single keybind.
#   - ON : start the service, which loads the Parakeet model.
#   - OFF: stop the service so the model is unloaded.

set -euo pipefail

notify() { notify-send -t 1500 -i "$1" "Dictation" "$2"; }

if systemctl --user is-active --quiet voxtype; then
  systemctl --user stop voxtype
  notify microphone-sensitivity-muted "Stopped"
else
  systemctl --user start voxtype
  notify audio-input-microphone "Started"
fi

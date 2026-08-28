#!/bin/bash

wid=$(xdotool search --class "sptlrx" | head -1)
if [ -z "$wid" ]; then
  exit 1
fi
if bspc query -N -n "$wid.hidden" >/dev/null 2>&1; then
  bspc node "$wid" -g hidden=off
else
  bspc node "$wid" -g hidden=on
fi

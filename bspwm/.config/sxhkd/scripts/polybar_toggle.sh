#! /bin/sh

statusfile="/tmp/polybar.status"
status=$(cat "$statusfile")
if [ "$status" == 1 ]; then
  bspc config top_padding 0
  echo 0 >"$statusfile"
else
  bspc config top_padding 50
  echo 1 >"$statusfile"
fi

polybar-msg cmd toggle

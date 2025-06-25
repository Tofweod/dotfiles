#! /bin/bash

bspc desktop -f $1
count=$(bspc query -N -d focused -n .!hidden.window | wc -l)
if [ "$count" -eq 0 ]; then
  cmd="${@:2}"
  /bin/zsh -c "$cmd" &
fi

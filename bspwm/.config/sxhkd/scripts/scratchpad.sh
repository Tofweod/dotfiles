#! /bin/bash

exists=false
ids=($(bspc query -N -n .window | tr ' ' '\n'))
for id in "${ids[@]}"; do
  wm_class=$(xprop -id "$id" | rg "WM_CLASS" | cut -d '"' -f 2)

  if [ "$wm_class" == "scratchpad" ]; then
    exists=true
    hidden=$(bspc query -T -n $id | jq .hidden)
    if [ "$hidden" == true ]; then
      bspc node $id -g hidden=off
      bspc node $id -f
    else
      bspc node $id -g hidden=on
    fi
  fi
done

if [ "$exists" == "false" ]; then
  alacritty --class=scratchpad &
fi

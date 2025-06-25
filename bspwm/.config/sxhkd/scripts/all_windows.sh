#! /bin/bash

title="All Windows"
raw=$(bspc query -N -n .window)
ids=($(echo $raw | tr ' ' '\n'))

choices=()

for id in "${ids[@]}"; do
  hidden=$(bspc query -T --node $id | jq -r .hidden)
  name=$(bspc query -T --node $id | jq -r .client.instanceName)
  choice="$name:$id"
  if [ "$hidden" == true ]; then
    choice="! $choice"
  fi
  choices+=("$choice")
done

selected=$(printf "%s\n" "${choices[@]}" | rofi -dmenu -i -p "$title")
id=${selected#*:}
if [ "${selected:0:1}" == "!" ]; then
  bspc node $id -g hidden=off
fi
bspc node $id -f

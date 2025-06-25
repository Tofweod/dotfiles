#! /bin/bash

title="Select Window"
raw=$(bspc query -N -d focused -n .!hidden.window)
ids=($(echo $raw | tr ' ' '\n'))

choices=()

for id in "${ids[@]}"; do
  name=$(bspc query -T --node $id | jq -r .client.instanceName)
  choices+=($name:$id)
done

selected=$(printf "%s\n" "${choices[@]}" | rofi -dmenu -i -p "$title")
id=${selected#*:}
bspc node $id -f

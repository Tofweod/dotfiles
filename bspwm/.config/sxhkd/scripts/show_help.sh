#!/usr/bin/env bash

awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' $HOME/.config/sxhkd/sxhkdrc |
  column -t -s $'\t' | rofi -dmenu -i -markup-rows -no-show-icons -no-config -yoffset 40 -l 25 -theme-str 'window { width: 1200px; }'

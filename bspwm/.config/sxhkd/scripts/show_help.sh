#!/usr/bin/env bash

awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' $HOME/.config/sxhkd/sxhkdrc |
  column -t -s $'\t' | rofi -dmenu -i -markup-rows -no-show-icons -width 2000 -yoffset 40 -no-config

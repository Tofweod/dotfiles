#!/bin/sh

desktop=$(bspc query -D -d focused --names)

layout=$(bsp-layout get "$desktop")

if [[ $layout == "tall" ]]; then
  layout="-"
fi

echo "[${layout:0:2}]"

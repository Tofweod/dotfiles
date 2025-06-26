#!/bin/bash

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#cdb0eecc'
TEXT='#f48484ee'
WRONG='#880000bb'
VERIFYING='#bb00bbbb'

SCREEN='/tmp/lock-tmp.jpg'
LOCKOUT='/tmp/lock-out.jpg'
CHARACTER="$HOME/dwm/dwm/i3lock/PIO5.png"
HELLO="                  The sense of the world must lie outside the world.
  In the word everything is as it is and happens as it does happen.In it there is no value -and if 
                        there were,it would be of no value."

scrot $SCREEN
magick $SCREEN -blur 5x5 - | magick - $CHARACTER -geometry +5+2310 -composite $LOCKOUT

i3lock \
  -i $LOCKOUT \
  --greeter-text="$HELLO" \
  --greeter-font='Monaco Nerd Font' \
  --greeter-pos="2700:2400" \
  --greeter-size=35 \
  --greeter-color='#5F9EA0' \
  --insidever-color=$CLEAR \
  --ringver-color=$VERIFYING \
  --insidewrong-color=$CLEAR \
  --ringwrong-color=$WRONG \
  \
  --inside-color=$BLANK \
  --ring-color=$DEFAULT \
  --line-color=$BLANK \
  --separator-color=$DEFAULT \
  \
  --verif-color=$TEXT \
  --wrong-color=#ff0000 \
  --time-color=$TEXT \
  --date-color=#a5c689 \
  --layout-color=$TEXT \
  --keyhl-color=$WRONG \
  --bshl-color=$WRONG \
  \
  --screen 1 \
  --blur 3 \
  --clock \
  --force-clock \
  --indicator \
  --time-str="%H:%M:%S" \
  --time-size=128 \
  --date-str="%A  %Y-%m-%d" \
  --date-size=32 \
  --wrong-size=60 \
  --verif-size=60 \
  --radius=350 \
  --pointer default \
  --show-failed-attempts \
  --time-font="Monaco" \
  --date-font="Monaco"

rm $SCREEN
rm $LOCKOUT

xdotool mousemove_relative 1 1 # 该命令用于解决自动锁屏后未展示锁屏界面的问题(移动一下鼠标)

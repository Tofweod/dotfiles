export QT_QPA_PLATFORMTHEME=qt5ct

# nvidia drivers settings from offical,dont change
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# 100%
xrandr --dpi 96

#display settings
# LAPTOP_DISPLAY="eDP"
# PRIMARY_DISPLAY="HDMI-0"
#
# xrandr --output "$PRIMARY_DISPLAY" --mode 2560x1440 --rate 144 --primary
# xrandr --output "$LAPTOP_DISPLAY" --right-of "$PRIMARY_DISPLAY" --auto

xset s off
xset s expose
xset m 0 0

#nitrogen
cwp

# desktop settings
export TOFWEOD_PRIMARY_DESKTOPS="1 2 3 4 5 6 7 8 9 10"
export TOFWEOD_SIDE_DESKTOPS="11 12 13"

export TOFWEOD_BROWSER_DESKTOP=8
export TOFWEOD_MUSIC_PLAYER_DESKTOP=9
export TOFWEOD_TMUX_DESKTOP=10

export TOFWEOD_MONITOR_DESKTOP=11

# dwm
# exec dwm
# bspwm
export DESKTOP_SESSION=bspwm
xsetroot -cursor_name left_ptr
exec sxhkd &
exec bspwm

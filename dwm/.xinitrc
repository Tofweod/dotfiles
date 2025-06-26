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
$HOME/.local/bin/rand_change_nitrogen_primary_wallpaper
nitrogen --restore &

# dwm
# exec dwm
# bspwm
export DESKTOP_SESSION=bspwm
xsetroot -cursor_name left_ptr
exec sxhkd &
exec bspwm


# nvidia drivers settings from offical,dont change
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# 125%
xrandr --dpi 120

#display settings
# LAPTOP_DISPLAY="eDP"
# PRIMARY_DISPLAY="HDMI-0"
#
# xrandr --output "$PRIMARY_DISPLAY" --mode 2560x1440 --rate 144 --primary
# xrandr --output "$LAPTOP_DISPLAY" --right-of "$PRIMARY_DISPLAY" --auto

#nitrogen
nitrogen --restore &

# dwm
dwm

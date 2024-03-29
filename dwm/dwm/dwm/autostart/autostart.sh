#! /bin/sh

# If you find fcitx5 icon is located at the most left of the straybar, please increase the delay value
# sleep 1 # need to wait dwm start complete and fcitx5 start complete

# Notice that cron need exec before other program
cron() {
    let i=1
    while true; do
        [ $((i % 3)) -eq 0 ] && ~/dwm/dwm/autostart/autoscreen.sh # check screen and autoset
        sleep 1; let i+=1
    done
}
cron&

# start autostart shells
for file in ~/.config/autostart/*.sh; do
  "$file" # execute
done


# start process
# crow & # translate
# copyq & # copy software
xfce4-power-manager > /dev/null 2>&1 &
redshift > /dev/null 2>&1 &
xautolock -time 30 -locker "~/dwm/dwm/i3lock/lock.sh" > /dev/null 2>&1 &
dunst > /dev/null 2>&1 &
fcitx5 > /dev/null 2>&1 &
qbittorrent > /dev/null 2>&1 &
# use only-office instead
# onedrive --synchronize > /dev/null 2>&1 &

picom --animations& 

# # start btop at secondary screen
# # 检测屏幕是否连接且不是主屏幕，此处指定为eDP
# output=$(xrandr | rg 'eDP.*connected' | rg -v 'primary')
#
# if ! [[ -z "$output" ]]; then
#     p_info=$(xrandr | grep -w "connected" | awk 'NR==2')
#     l_width=$(xrandr | grep -w "connected" | awk 'NR==1' | awk '{print $3}' | cut -d 'x' -f1)
#     p_width=$(echo $p_info | awk '{print $4}' | cut -d 'x' -f1)
#     p_height=$(echo $p_info | awk '{print $4}' | cut -d 'x' -f2)
#     xdotool mousemove ${p_width}+${l_width}/2 ${p_height}
# 	  alacritty -t statusutil --class floatingTerminal -e btop > /dev/null 2>&1 &
#     sleep 0.3
#     xdotool mousemove 0 0
# fi


pkill -f statusbar.py
python3 ~/dwm/dwm/statusbar/statusbar.py cron &>/dev/null


libinput-gestures-setup start # touchpad open gesture
xinput --set-prop 15 'libinput Accel Speed' 0.5 # set touchpad sensitivity

xhost + # add support for docker gui app

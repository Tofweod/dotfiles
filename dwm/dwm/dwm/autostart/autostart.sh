#! /bin/bash

# If you find fcitx5 icon is located at the most left of the straybar, please increase the delay value
# sleep 1 # need to wait dwm start complete and fcitx5 start complete

errorlogdir="$HOME/.my_log/autostart-errorlog"
if [[ ! -d $errorlogdir ]]; then
  mkdir $errorlogdir
fi
date="${errorlogdir}/$(/bin/date +"%Y-%m-%d")"
if [[ ! -d $date ]]; then
  mkdir $date
fi

statusbarlog="$HOME/.my_log/statusbarlog"
if [[ ! -f $statusbarlog ]]; then
  touch $statusbarlog
fi
truncate -s 0 $statusbarlog

# Notice that cron need exec before other program
cron() {
  let i=1
  while true; do
    [ $((i % 3)) -eq 0 ] && ~/dwm/dwm/autostart/autoscreen.sh # check screen and autoset
    sleep 1
    let i+=1
  done
}
cron &

run_and_log() {
  program_name=$1

  log_name="${date}/${program_name}.log"
  if [[ ! -f ${log_name} ]]; then
    touch $log_name
  fi

  program_arg=("${@:2:$#-1}")

  echo "%%" >>${log_name}
  echo "$(date)" >>${log_name}
  r_cmd="$program_name ${program_arg[@]}>/dev/null 2>>${log_name} &"

  echo "[INFO of $program_name]:" >>$log_name
  echo $r_cmd >>$log_name
  eval $r_cmd
}

# this occurs when using multi monitors
if [ $(xrandr --listmonitors | rg 'Monitor' | awk '{print $2}') -gt 1 ]; then
  # load sound card
  # pactl load-module module-alsa-sink device=hw:1,7
  # sink=$(pactl list short sinks | rg 'hw' | awk '{print $1}')
  # pactl set-default-sink $sink
  # open statusutil
  # navigator to second screen
  xdotool keydown Super Alt l keyup l Alt Super
  # clear state bar
  xdotool keydown Super b keyup b Super
  run_and_log alacritty -o "font.size=8.5" -t statusutil --class statusutil -e btop
  sleep 0.2
  run_and_log alacritty -t cava --class cava -e cava
  xdotool keydown Super Control period keyup period Control Super
  sleep 0.5
  # back to main screen
  xdotool keydown Super Alt l keyup l Alt Super
fi

# start autostart shells
for file in ~/.config/autostart/*.sh; do
  "$file" # execute
done

# start process
# crow & # translate
# copyq & # copy software
# nekoray > /dev/null 2>&1 &
run_and_log xfce4-power-manager
run_and_log redshift
run_and_log xautolock -time 30 -locker "~/dwm/dwm/i3lock/lock.sh"
run_and_log dunst
run_and_log fcitx5
run_and_log qbittorrent
# xfce4-power-manager >/dev/null 2>>$errorlog &
# redshift >/dev/null 2>>$errorlog &
# xautolock -time 30 -locker "~/dwm/dwm/i3lock/lock.sh" >/dev/null 2>>$errorlog &
# dunst >/dev/null 2>>$errorlog &
# fcitx5 >/dev/null 2>>$errorlog &
# qbittorrent >/dev/null 2>>$errorlog &
# use only-office instead
# onedrive --synchronize > /dev/null 2>&1 &

picom --animations &

pkill -f statusbar.py
python3 ~/dwm/dwm/statusbar/statusbar.py cron >>$statusbarlog 2>&1 &

libinput-gestures-setup start                   # touchpad open gesture
xinput --set-prop 15 'libinput Accel Speed' 0.5 # set touchpad sensitivity

xhost + # add support for docker gui app

while true; do
  size=$(stat -c %s "$statusbarlog")

  if [ $size -ge 1000 ]; then
    notify-send 'statusbar error!'
    break
  fi

  sleep 10
done

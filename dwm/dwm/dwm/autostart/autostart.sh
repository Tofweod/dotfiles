#! /bin/sh

# If you find fcitx5 icon is located at the most left of the straybar, please increase the delay value
# sleep 1 # need to wait dwm start complete and fcitx5 start complete

errorlog="$HOME/.my_log/autostart-errorlog"
if [[ ! -f $errorlog ]]; then
	touch $errorlog
fi
truncate -s 0 $errorlog
echo $(date) >>$errorlog

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

# mount nas
passwd=$(openssl enc -aes-256-cbc -d -in $HOME/.passwd -pass pass:$(uname -n) -pbkdf2)
echo $passwd | sudo -S mount -t cifs //Laptop-tofweod/nas /mnt/nas -o credentials=/home/tofweod/.smb,uid=1000,gid=1000 >/dev/null 2>>$errorlog &

# this occurs when using multi monitors
if [ $(xrandr --listmonitors | rg 'Monitor' | awk '{print $2}') -ge 1 ]; then
	# load sound card
	pactl load-module module-alsa-sink device=hw:1,7
	sink=$(pactl list short sinks | rg 'hw' | awk '{print $1}')
	pactl set-default-sink $sink
	# open statusutil
	# navigator to second screen
	xdotool keydown Super Alt l keyup l Alt Super
	# clear state bar
	xdotool keydown Super b keyup b Super
	alacritty -o "font.size=8.5" -t statusutil --class statusutil -e btop >/dev/null 2>>$errorlog &
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
xfce4-power-manager >/dev/null 2>>$errorlog &
redshift >/dev/null 2>>$errorlog &
xautolock -time 30 -locker "~/dwm/dwm/i3lock/lock.sh" >/dev/null 2>>$errorlog &
dunst >/dev/null 2>>$errorlog &
fcitx5 >/dev/null 2>>$errorlog &
qbittorrent >/dev/null 2>>$errorlog &
# use only-office instead
# onedrive --synchronize > /dev/null 2>&1 &

picom --animations &

pkill -f statusbar.py
python3 ~/dwm/dwm/statusbar/statusbar.py cron >>$statusbarlog &

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

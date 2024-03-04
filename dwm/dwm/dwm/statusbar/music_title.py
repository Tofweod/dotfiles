#!/usr/bin/env python

import os
import sys
import subprocess
import re
import time
import _thread
from typing import clear_overloads
import common

music_program = common.MUSIC_PROGRAM

icon_fg = common.black
icon_bg = common.blue
icon_tr = "0xff"
text_fg = common.blue
text_bg = common.black
text_tr = "0xff"

icon_color = "^c" + str(icon_fg) + "^^b" + str(icon_bg) + str(icon_tr) + "^"
text_color = "^c" + str(text_fg) + "^^b" + str(text_bg) + str(text_tr) + "^"
DELAY_TIME = 1

filename = os.path.basename(__file__)
name = re.sub("\..*", "", filename)


def get_music_title():
    # cmd="echo $(dbus-send --print-reply --dest=org.mpris.MediaPlayer2."+str(music_program)+" /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}' "+"| cut -d '"+'"'+"' -f 2) 2>/dev/null"
    # cmd="curl http://127.0.0.1:27232/player | jq '.currentTrack.name + \"-\" + .currentTrack.ar[0].name' -r"
    # cmd = "echo $(pactl -p " + str(music_program) + " metadata | grep -E 'title/artist' | awk '{for(i=3;i<NF;i++){printf \"%s \",$i};printf \"%s\\n\",$i})'"
    cmd = "echo $(playerctl -p yesplaymusic metadata | grep -E 'title|artist' | awk  '{for(i=3;i<NF;i++){printf \"%s \",$i};printf \"%s/03\",$i}')"  # /03 special asc2 code
    result = subprocess.run(
        cmd, shell=True, timeout=3, stderr=subprocess.PIPE, stdout=subprocess.PIPE
    )
    title = result.stdout.decode("utf-8").replace("/03", "-")
    title = title.replace("'", "")  # 解决一些歌曲带'的问题
    title = title.replace('"', "")
    title = title[:-2]
    return title


def update(loop=False, exec=True):
    while True:
        icon = "󰎆"  # 󰎆
        text = get_music_title()

        txt = (
            "^s"
            + str(name)
            + "^"
            + str(icon_color)
            + str(icon)
            + str(text_color)
            + str(text)
        )
        common.write_to_file(txt + "\n", str(name))
        if loop == False:
            if exec == True:
                os.system("xsetroot -name '" + str(txt) + "'")
            break
        time.sleep(DELAY_TIME)


def update_thread():
    _thread.start_new_thread(update, (False, False))


def click(string=""):
    match string:
        case "L":
            os.system("xdotool keydown Super m keyup m Super")
        case "M":
            pass
        case "R":
            pass
        case "U":
            pass
        case "D":
            pass
        case _:
            pass


def notify(string=""):
    pass


if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "update":
            pass
        else:
            click(sys.argv[1])
            update(exec=False)
    else:
        update()

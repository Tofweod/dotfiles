#!/usr/bin/env python

import os
import sys
import subprocess
import re
import time
import common
import _thread


icon_fg = common.black
icon_bg = common.green
icon_tr = "0xff"
text_fg = common.black
text_bg = common.green
text_tr = "0xff"

icon_color = "^c" + str(icon_fg) + "^^b" + str(icon_bg) + str(icon_tr) + "^"
text_color = "^c" + str(text_fg) + "^^b" + str(text_bg) + str(text_tr) + "^"
DELAY_TIME = 2

filename = os.path.basename(__file__)
name = re.sub("\\..*", "", filename)


def connect_status():
    ret = -1
    cmd = "cat /sys/class/net/e*/operstate"
    result = subprocess.run(
        cmd,
        shell=True,
        timeout=3,
        stderr=subprocess.PIPE,
        stdout=subprocess.PIPE,
    )
    connect = str(result.stdout.decode("utf-8").replace("\n", ""))
    match connect:
        case "up":
            ret = 1
        case "down":
            ret = 0
        case _:
            ret = -1
    return ret


def get_eth_icon():
    icon = "󰈂"
    connect_status_ = connect_status()
    match connect_status_:
        case 0:
            cmd = "cat /sys/class/net/e*/flags"
            result = subprocess.run(
                cmd,
                shell=True,
                timeout=3,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
            )
            flags = str(result.stdout.decode("utf-8").replace("\n", ""))
            if str(flags) == "0x1003":
                icon = "睊"
            else:
                icon = "󰈂"
            pass
        case 1:
            icon = "󰀂"
    return icon


def update(loop=False, exec=True):
    while True:
        icon = " " + get_eth_icon() + " "
        text = ""
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


def notify(string=""):
    connect_status_ = connect_status()
    match int(connect_status_):
        case 1:
            cmd = (
                "echo $(nmcli -t -f name,device connection show --active | grep -E '"
                + common.netname
                + "' | cut -d\\: -f2)"
            )
            result = subprocess.run(
                cmd,
                shell=True,
                timeout=3,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
            )
            net_name = result.stdout.decode("utf-8").replace("\n", "")
            cmd = (
                "notify-send 'Net connected' "
                + "'Net name : "
                + str(net_name)
                + "\n'"
                + " -r 1025"
            )
            os.system(cmd)
        case -1:
            os.system(
                "notify-send 'Net no connected' 'Press right buttom to open net connect tool.(nmtui)' -r 1024"
            )
            pass
        case _:
            os.system(
                "notify-send 'The net device is disable, please cheack your net device' 'Press right buttom to open wifi connect tool.(nmtui)' -r 1024"
            )
            pass


def click(string=""):
    match string:
        case "L":
            notify()
        case "M":
            os.system("nm-connection-editor")
            pass
        case "R":
            os.system("alacritty -t nmtui --class floatingTerminal -e nmtui ")
        case "U":
            pass
        case "D":
            pass
        case _:
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

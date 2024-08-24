#! /usr/bin/env python

import os
import sys
import subprocess
import re
import time
import _thread
import common
import screeninfo


icon_fg = common.black
icon_bg = common.green
icon_tr = "0xff"
text_fg = common.black
text_bg = common.green
text_tr = "0xff"

icon_color = "^c" + str(icon_fg) + "^^b" + str(icon_bg) + str(icon_tr) + "^"
text_color = "^c" + str(text_fg) + "^^b" + str(text_bg) + str(text_tr) + "^"
DELAY_TIME = 3

filename = os.path.basename(__file__)
name = re.sub("\\..*", "", filename)

_TODOFILE = "~/.todo/todo.txt"
TODOFILE = os.path.expanduser(_TODOFILE)


class Colors:
    RESET = "</span>"
    COMMON = "<span color='#000000'>"
    COMMENT = "<span color='#808080'>"
    PRIORITY_A = "<span color='#c93756'>"
    PRIORITY_B = "<span color='#ff7500'>"
    PRIORITY_C = "<span color='#5d513c'>"
    DATE = "<span color='#789262'>"
    CONTEXT = "<span color='#b0a4e3'>"
    PROJECT = "<span color='#758a99'>"


patterns = {
    "TodoDone": r'^[xX]\s.+$',
    "TodoPriorityA": r'^\([aA]\)\s.+$',
    "TodoPriorityB": r'^\([bB]\)\s.+$',
    "TodoPriorityC": r'^\([cC]\)\s.+$',
    "TodoPriorityD": r'^\([dD]\)\s.+$',
    "TodoPriorityE": r'^\([eE]\)\s.+$',
    "TodoPriorityF": r'^\([fF]\)\s.+$',
    "TodoPriorityG": r'^\([gG]\)\s.+$',
    "TodoPriorityH": r'^\([hH]\)\s.+$',
    "TodoPriorityI": r'^\([iI]\)\s.+$',
    "TodoPriorityJ": r'^\([jJ]\)\s.+$',
    "TodoPriorityK": r'^\([kK]\)\s.+$',
    "TodoPriorityL": r'^\([lL]\)\s.+$',
    "TodoPriorityM": r'^\([mM]\)\s.+$',
    "TodoPriorityN": r'^\([nN]\)\s.+$',
    "TodoPriorityO": r'^\([oO]\)\s.+$',
    "TodoPriorityP": r'^\([pP]\)\s.+$',
    "TodoPriorityQ": r'^\([qQ]\)\s.+$',
    "TodoPriorityR": r'^\([rR]\)\s.+$',
    "TodoPriorityS": r'^\([sS]\)\s.+$',
    "TodoPriorityT": r'^\([tT]\)\s.+$',
    "TodoPriorityU": r'^\([uU]\)\s.+$',
    "TodoPriorityV": r'^\([vV]\)\s.+$',
    "TodoPriorityW": r'^\([wW]\)\s.+$',
    "TodoPriorityX": r'^\([xX]\)\s.+$',
    "TodoPriorityY": r'^\([yY]\)\s.+$',
    "TodoPriorityZ": r'^\([zZ]\)\s.+$',
    "TodoDate": r'\d{2,4}-\d{2}-\d{2}',
    "TodoProject": r'\B\+\S+',
    "TodoContext": r'\B@\S+',
}

highlight_rules = {
    "TodoDone": Colors.COMMENT,
    "TodoPriorityA": Colors.PRIORITY_A,
    "TodoPriorityB": Colors.PRIORITY_B,
    "TodoPriorityC": Colors.PRIORITY_C,
    "TodoDate": Colors.DATE,
    "TodoProject": Colors.PROJECT,
    "TodoContext": Colors.CONTEXT,
}


def get_todo_num():
    cmd = f"echo $(cat {TODOFILE} | wc -l)"
    result = subprocess.run(
        cmd,
        shell=True,
        timeout=1,
        stderr=subprocess.PIPE,
        stdout=subprocess.PIPE,
    )
    return result.stdout.decode("utf-8")


def update(loop=False, exec=True):
    while True:
        icon = "󰺲"
        todonum = get_todo_num()
        text = " " + str(todonum)
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


def parse_todo_line(line):
    for syntax_group, pattern in patterns.items():
        color = highlight_rules.get(syntax_group, Colors.COMMON)
        line = re.sub(
            pattern,
            lambda m: f"{color}{m.group(0)}{Colors.RESET}",
            line,
            flags=re.MULTILINE,
        )
    return line + '\n'


def get_todo_list():
    result = ""
    try:
        with open(TODOFILE, "r") as todolist:
            for line in todolist:
                line = line.strip()
                result += parse_todo_line(line)
    except FileNotFoundError:
        result = f"Not found file: {TODOFILE}"

    return result


def notify(string=""):
    send_string = ""
    for string_ in get_todo_list():
        send_string += string_
    os.system(
        "notify-send " + " '󰺲 TodoList' " + "\"" + send_string + "\" -r 1212"
    )
    pass


def click(string=""):
    match string:
        case "L":
            notify()
            pass
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


if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "update":
            pass
        else:
            click(sys.argv[1])
            update(exec=False)
    else:
        update()

#!/bin/bash

pkill sptlrx >/dev/null || alacritty -T sptlrx --class=sptlrx -e sptlrx

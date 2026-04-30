#!/bin/sh

filename="$HOME/.my_log/storage-dump.log"

if [[ ! -e ${filename} ]]; then
  touch $filename
fi

timestr=$(date +%Y-%m-%d\ %H:%M:%S)

storagestr=$(df -Th | sed -n '/nvme[[:alnum:]]*3/p' | head -n 1)

output="${timestr} >>>>> ${storagestr}"

echo $output >>$filename

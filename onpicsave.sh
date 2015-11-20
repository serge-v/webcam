#!/bin/sh

set -e
set -x

LOG=/tmp/evt.log
URL=`cat /root/.config/motion-conf/ftp-url.txt`

echo file: $1 >> $LOG
ftp -u "$URL" $1 >> $LOG
find /tmp -name '*.jpg' -mmin +2 -print -delete >> $LOG

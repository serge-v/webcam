set -e

LOG=/tmp/evt.log
date >> $LOG
echo file: $1 >> $LOG
ftp -u '`cat ~/.config/motion-conf/ftp-url.txt`' $1 >> $LOG
find /tmp -name '*.jpg' -mmin +2 -print -delete >> $LOG

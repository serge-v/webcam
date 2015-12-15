TTY=/dev/ttyU0

set -e
set -x

file=`find ~/obj -name kernel`

#stty -f $TTY.init -icanon -isig -echo echoe echok echoke echoctl -icrnl -ixany -imaxbel ignpar -opost -onlcr -oxtabs cs8 -parenb -hupcl clocal

echo stty -echo > $TTY

gzip -c $file | b64encode kernel.gz > $TTY

echo stty echo > $TTY

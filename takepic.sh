set -x
set -e
/sbin/ldconfig /opt/vc/lib/
/opt/vc/bin/raspistill -o /tmp/1.jpg
uuencode /tmp/1.jpg 1.jpg | mail -s "pic" serge0x76+cam@gmail.com


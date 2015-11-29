
#set -x
set -e

for f in 20151128*.jpg ; do
    text=`echo $f | cut -d'-' -f 1 -f 2 | sed s/.jpg//`
    echo $text
    [ ! -f ann-$f ] && /usr/local/bin/magick $f -rotate 180 -font sourcecode-light.ttf -fill red -pointsize 100 -draw "text 60,60 \'$text\'" ann-$f
done

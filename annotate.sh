
#set -x
set -e

cd ~/cam

find ~/cam -name '*.jpg' -size 0 -delete

for f in 20*.jpg ; do
    text=`echo $f | cut -d'-' -f 1 -f 2 | sed s/.jpg//`
    echo $text
    /usr/local/bin/magick $f -rotate 180 -font sourcecode-light.ttf -fill red -pointsize 40 -draw "text 60,60 \'$text\'" ann-$f
    rm $f
done


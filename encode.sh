
set -e
set -x

[ "_$1" == "_" ] && { echo specify timestamp ; exit ; }

cd ~/cam

day=`ls -1 ann-$1*.jpg | sed 's/ann-//;s/-.*//' | uniq | head -1`

outfile=${day}.mp4
echo encode day ${day} to ${outfile}?

ffmpeg -y -framerate 8 -pattern_type glob -i "ann-${day}*.jpg" -c:v libxvid ${outfile}

rm ann-${day}*.jpg


set -e
set -x

cd ~/cam

day=`ls -1 ann-20*.jpg | sed 's/ann-//;s/-.*//' | uniq | head -1`

outfile=${day}.mp4
echo encode day ${day} to ${outfile}?

read aa
ffmpeg -y -framerate 8 -pattern_type glob -i "ann-${day}*.jpg" -c:v libxvid ${outfile}

read aa
rm ann-${day}*.jpg

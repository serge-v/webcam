SRCDIR=$HOME/src/xtree/webcam

uname=$(uname)

if [ "$uname" == "Darwin" ] ; then
	mkdir -p ~/b/webcamx
	cd ~/b/webcamx
	cmake -G Xcode -DCMAKE_TOOLCHAIN_FILE=$SRCDIR/macports.cmake $SRCDIR
fi

mkdir -p ~/b/webcamb
cd ~/b/webcamb
cmake -DCMAKE_TOOLCHAIN_FILE=$SRCDIR/macports.cmake $SRCDIR

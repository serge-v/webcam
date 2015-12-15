# set environment for building for RPI on amd64

export BUILDWORLD=${HOME}/obj/arm.armv6/usr${HOME}/src
export CC=$BUILDWORLD/tmp/usr/bin/cc
export CPP=$BUILDWORLD/tmp/usr/bin/cpp
export CXX=$BUILDWORLD/tmp/usr/bin/c++
export AS=$BUILDWORLD/tmp/usr/bin/as
export NM=$BUILDWORLD/tmp/usr/bin/nm
export LD=$BUILDWORLD/tmp/usr/bin/ld
export OBJCOPY=$BUILDWORLD/tmp/usr/bin/objcopy
export SIZE=$BUILDWORLD/tmp/usr/bin/size
export STRIPBIN=$BUILDWORLD/tmp/usr/bin/strip
export MACHINE=arm
export MACHINE_ARCH=armv6

$CC test.c -v

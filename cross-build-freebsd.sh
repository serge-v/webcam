#!/bin/sh

usage() {
    cat <<EOS
    sh cross-build-frebsd [command]
    commands:
      bw     build world. Usualy runs first after 'svnlite up'
      bk     build kernel.
      ik     install kernel into ~/dist.
    Then use:
      ./copy-kernel.sh to copy kernel and uwrtn modules to RPI.
EOS
}

[ "_$1" = "_" ] { usage(); exit; }

set -e

WDIR=/home/noro

cd ${HOME}/src

find ~/obj -name kernel -print -delete;
find ~/obj -name '*.ko' -print -delete;

if [ "_$1" = "_bw" ] ; then

    env MAKEOBJDIRPREFIX=${WDIR}/obj \
    make buildworld \
    TARGET_ARCH=armv6 \
    DESTDIR=${WDIR}/dist \
    NO_ROOT=YES \
    KERNCONF=MYRPI \
    -j4 | tee bw.log | grep --line-buffered -e stage

    env MAKEOBJDIRPREFIX=${WDIR}/obj \
    make installworld \
    TARGET_ARCH=armv6 \
    DESTDIR=${WDIR}/dist \
    NO_ROOT=YES \
    KERNCONF=MYRPI \
    -j4 | tee iw.log | grep --line-buffered -e stage

    env MAKEOBJDIRPREFIX=${WDIR}/obj \
    make distribution \
    TARGET_ARCH=armv6 \
    DESTDIR=${WDIR}/dist \
    NO_ROOT=YES \
    KERNCONF=MYRPI \
    -j4 | tee di.log | grep --line-buffered -e stage
fi

if [ "_$1" = "_bk" ]; then
    env MAKEOBJDIRPREFIX=${WDIR}/obj \
    make buildkernel \
    TARGET_ARCH=armv6 \
    DESTDIR=${WDIR}/dist \
    NO_ROOT=YES \
    KERNCONF=MYRPI \
    -j4 | tee bk.log | grep --line-buffered -e stage
    find ~/obj -name kernel -exec ls -l {} \;
fi

if [ "_$1" = "_ik" ]; then
    env MAKEOBJDIRPREFIX=${WDIR}/obj \
    make installkernel \
    TARGET_ARCH=armv6 \
    DESTDIR=${WDIR}/dist \
    NO_ROOT=YES \
    KERNCONF=MYRPI \
    -j4 | tee ik.log
    find ~/dist -name kernel -exec ls -l {} \;
fi


#NO_CLEAN=YES \
#SRCCONF=${HOME}/rpi-freebsd-tools/src.conf \
#-j4

Description
===========
This repository contains config files and scripts for webcamera based on Raspberry PI and FreeBSD.
Camera records motion as jpegs and transmits then to remote storage.
Remote storage encodes jpegs into xvid.

Components
==========
Raspberry PI-A
Realtek Wifi dongle
Onboard camera
FreeBSD 11.0 (GH/freebsd)
urtwn support in kernel
Raspberry PI userland compiled for FreeBSD (GH/gonzoua/userland/freebsd)
Motion software with mmal support (GH/serge-v/motion/rpi-freebsd)
FreeBSD virtual server (digitalocean)
ffmpeg

Tools
=====

Cloud server
------------
annotate.sh    Draws timestamp on picture
create-movie   Coverts jpegs into mp4
gen-cmake.sh   Generate makefiles for the project
departures     Not a part of webcamera. Emails NJTransit departures to me.
weather        Not a part of webcamera. Emails local weather to me.

Raspberry PI camera
-------------------
motion.conf             motion config for RPI.
motion.rc               motion startup file for RPI.
onpicsave.sh            motion script to transmit jpg from the camera to the cloud.

Builder
-------
cross-build-freebsd.sh  Build FreeBSD for Raspberry PI.
copy-kernel.sh          Copy built kernel to Raspberry PI.
set-cross-rpi.sh        Set cross-compile tools for userspace projects.

Crontab
=======
7 * * * * ~/src/xtree/webcam/annotate.sh
14 11 * * * /usr/local/bin/departures -f XG -t HB -m
18 10 * * * /usr/local/bin/weather -z 10974 -m aa -t
22 2 * * * /usr/local/bin/create-movie

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

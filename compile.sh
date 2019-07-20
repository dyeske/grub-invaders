#!/bin/bash

set -e
set -v
#Compiling fix by Thomas Lane/allbombson
CFLAGS="-ffreestanding -m32 -nostdinc -nostdlib -I. -O2 -W -Wall -fno-stack-protector"
LDFLAGS="-Wl,-N -Wl,-Ttext -Wl,100000 -Wl,--build-id=none"
gcc $CFLAGS -c keyboard.c
gcc $CFLAGS -c delay.c
gcc $CFLAGS -c common.c
gcc $CFLAGS -c sound.c
gcc $CFLAGS -c game.c
gcc $CFLAGS -c kernel.c
gcc $CFLAGS -c video.c
gcc $CFLAGS -c memory.c
gcc $CFLAGS -c boot.S
gcc $CFLAGS $LDFLAGS -o invaders.exec boot.o kernel.o keyboard.o video.o game.o sound.o delay.o common.o memory.o
objcopy -O binary invaders.exec invaders

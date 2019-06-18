#!/usr/bin/env bash
HOST=${1:-"pi@raspberrypi"}
DIR="$(grealpath .)"

git describe --long --tags --always > ./version.txt

ssh $HOST 'mkdir -p ~/spl' && \
scp -rp $DIR/* $HOST:~/spl


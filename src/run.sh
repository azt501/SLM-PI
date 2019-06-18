#!/usr/bin/env bash

BASE="/home/pi/spl/src"
python $BASE/spl_meter_text.py &
python $BASE/display.py &
python $BASE/blinkt_op.py &

#!/bin/bash

killall conky
sleep 2s

conky -c $HOME/.config/conky/xfactor/xfactor &> /dev/null &

exit


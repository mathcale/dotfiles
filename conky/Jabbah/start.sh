#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Jabbah/Jabbah.conf &> /dev/null &

exit

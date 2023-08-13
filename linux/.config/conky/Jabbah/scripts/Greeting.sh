#!/bin/bash

Greeting=$(date +%H)
cat $0 | grep $Greeting | sed 's/# '$Greeting' //'

# 
# --------------------------------------------------------------------------------
# 00 Good midnight
# 01 Good morning
# 02 Good morning
# 03 Good morning
# 04 Good morning
# 05 Good morning
# 06 Good morning
# 07 Good morning
# 08 Good morning
# 09 Good morning
# 10 Good morning
# 11 Good day
# 12 Good day
# 13 Good afternoon
# 14 Good afternoon
# 15 Good afternoon
# 16 Good afternoon
# 17 Good afternoon
# 18 Good evening
# 19 Good evening
# 20 Good evening
# 21 Good evening
# 22 Good evening
# 23 Good evening

#!/bin/sh
# using fzf and urxvt to make a quick and small application launcher
urxvt -name menu -e sh -c 'cmd=$(compgen -c | sort -u | fzf); setsid -f $cmd' 

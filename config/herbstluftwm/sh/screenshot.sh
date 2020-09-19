#!/bin/sh
#take an area screenshot and copy it to a folder
maim -m 4 -g $(slop) $HOME/Pictures/$(date +"%m-%d-%Y-%T").png

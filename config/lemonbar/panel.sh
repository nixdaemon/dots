#!/bin/sh
# making sure all processes are killed beforehand, on each reload
pkill -9 lemonbar

# a simple clock
clock () {
    TIME=$(date "+%I:%M %p" | tr '[:upper:]' '[:lower:]')
	echo "%{B#f9c5c5}%{F#1b1e23}%{+u}%{+o} $TIME %{B-}%{F-}%{-u}%{-o}"
}

# a simple calendar
calendar () {
	CALENDAR=$(date "+%a, %b %d %Y" | tr '[:upper:]' '[:lower:]')
	echo "%{B#3bdcff}%{+u}%{+o} $CALENDAR %{B-}%{-u}%{-o}"
}

# a simple volume widget
vol () {
    VOL=$(amixer get Master | grep % | sed -n 1p | awk -F '[' '{print $2}' | awk -F ']' '{printf $1}')
	if [ "$VOL" = '0%' ]; then
    	echo "$(printf '%b' "muted")%{F#f9c5c5} Mute"
	else
		echo "%{B#3bdcff}%{F#fefefe}%{+u}%{+o} $(printf '%b' "vol:") $VOL %{F-}%{B-}%{-u}%{-o}"
	fi
}

# displays the current active windowtitle. uses xdotool
windowpane () {
	TITLE=$(xdotool getactivewindow getwindowname 2>/dev/null | sed -n 1p || echo "" | cut -c 1-50)
    echo "%{B#fefefe}%{F#1b1e23}%{+u}%{+o} $TITLE %{B-}%{F-}%{-u}%{-o}"
}

# display memory usage
memory () {
	MEMORY=$(free -m | grep Mem | awk '{print ($3/$2)*100}' | xargs printf '%.*f\n' 1)%
	echo "%{B#fbc5c5}%{F#1b1e23}%{+u}%{+o} mem: $MEMORY %{B-}%{F-}%{-u}%{-o}"
}

# display cpu usage
cpu () {
	CPU=$(grep 'cpu ' /proc/stat | awk -v CONVFMT='%.1f' '{usage=($2+$4)*100/($2+$4+$5)}{print usage "%"}')
	echo "%{B#fbc5c5%}%{F#1b1e23}%{+u}%{+o} cpu: $CPU %{B-}%{F-}%{-u}%{-o}"
}

#main config
while true; do
    echo "%{l} $(calendar) $(clock)%{c} $(windowpane)%{r} $(memory)$(cpu) $(vol) "
	sleep 1
done |
lemonbar -p -d -b -n 'statusbar' -g 1200x24+350+3 -B '#fefefe' -u 3O -f

#!/bin/bash
# Terminate already running bar instances
killall polybar

monitors=$(polybar --list-monitors | cut -d":" -f1)
IFS=$'\n' read -r -d '' -a monitor_array <<< "$monitors"

m1="${monitor_array[0]}"
MONITOR=$m1 polybar -c ~/.config/polybar.old/config.ini main &

if [ ${#monitor_array[@]} -gt 1 ]; then
    for m in "${monitor_array[@]:1}"; do
        MONITOR=$m polybar -c ~/.config/polybar.old/config.ini secondary &
    done
fi


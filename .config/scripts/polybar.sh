#!/bin/bash
CONFIG_LOCATION="/home/jfelmeden/.config/polybar.old/config.ini"
bars=("main" "secondary")

# make sure tray only goes on primary monitor
monitors=$(polybar --list-monitors | cut -d":" -f1)
IFS=$'\n' read -r -d '' -a monitor_array <<< "$monitors"
PRIMARY="${monitor_array[0]}"

# find monitors (active + disabled)
ACTIVE_MONITORS=$(xrandr | awk '/ connected/{print $1}')
DISABLED_MONITORS=$(xrandr | awk '/disconnected/{print $1}')

## For each bar, do the following
for bar in "${bars[@]}"
do
# kill polybar instances on disabled monitors
for i in $DISABLED_MONITORS
do
    WM_NAME=polybar-${bar}_${i}
    PID=$(xprop -name "$WM_NAME" 2>/dev/null | awk '/_NET_WM_PID\(CARDINAL\)/{print $NF}')
    if [ "$PID" ]
    then
        kill "$PID"
    fi
done
done

# let monitors settle
sleep 1

# start additional polybar instances on new monitors
for j in $ACTIVE_MONITORS
do
    bar="secondary"
    BAR_INACTIVE="main"
    TRAY_POS="none"
    if [[ "$j" == "$PRIMARY" ]]; then
        bar="main"
        BAR_INACTIVE="secondary"
        TRAY_POS="right"
    fi

    # kill other bars on each window
    WM_NAME_INACTIVE=polybar-${BAR_INACTIVE}_${j}
    PID_INACTIVE=$(xprop -name "$WM_NAME_INACTIVE" 2>/dev/null | awk '/_NET_WM_PID\(CARDINAL\)/{print $NF}')
    if [ "$PID_INACTIVE" ]; then kill "$PID_INACTIVE"; fi

    WM_NAME=polybar-${bar}_${j}
    PID=$(xprop -name "$WM_NAME" 2>/dev/null | awk '/_NET_WM_PID\(CARDINAL\)/{print $NF}')
    if [ ! "$PID" ]
    then
        POLYBAR_TRAY_POS=$TRAY_POS MONITOR=$j polybar -c $CONFIG_LOCATION $bar &
    fi
done

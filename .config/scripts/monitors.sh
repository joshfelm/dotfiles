#!/bin/bash

# TODO: allow different scale/resolutions with manual

# Function to display usage
usage() {
    echo "Usage: $0 [-d]"
    echo "  -d    Enable manual monitor selection"
    exit 1
}

# Parse command line options
while getopts ":d" opt; do
    case ${opt} in
        d ) manual_selection=true ;;
        \? ) usage ;;
    esac
done

# Get the list of connected monitors
connected_monitors=$(xrandr | grep 'connected' | awk '/connected/ && !/disconnected/ {print $1}')
disconnected_monitors=$(xrandr | grep 'connected' | awk '/disconnected/ {print $1}')

# Convert connected_monitors to an array
IFS=$'\n' read -d '' -r -a monitor_array <<< "$connected_monitors"
IFS=$'\n' read -d '' -r -a dis_monitor_array <<< "$disconnected_monitors"

# Use default order (order of detection)
monitors=("${monitor_array[@]}")
dis_monitors=("${dis_monitor_array}")

if [ "$manual_selection" = true ]; then
    # Display available monitors
    echo "Connected monitors:"
    echo "$connected_monitors" | nl

    # Ask user for monitor order
    echo "Enter the number of the monitor you want to be the primary"
    read -a monitor_order

    # Validate input
    if [ ${#monitor_order[@]} -eq 0 ]; then
        echo "No input provided. Exiting."
        exit 1
    fi

    primary_monitor=$(echo "$connected_monitors" | sed -n "${monitor_order}p")
else
    # Set the primary monitor (first in the list)
    primary_monitor=${monitors[0]}
fi


echo $primary_monitor

# Set up the primary monitor
xrandr --output "$primary_monitor" --primary --auto

#  Disconntect irrelevant monitors
for i in "${!dis_monitors[@]}"; do
    monitor=${dis_monitors[$i]}
    xrandr --output "$monitor" --off
done

mon_str=""
# Set up each monitor
prev_monitor=$primary_monitor
for i in "${!monitors[@]}"; do
    monitor=${monitors[$i]}
    if [ $i -eq 0 ]; then
        mon_str="$i. ${monitor}"
    else
        mon_str="${mon_str}\n$i. ${monitor}"
    fi

    if [ "$monitor" = "$primary_monitor" ]; then
        mon_str="${mon_str} (p)"
        continue  # Skip the primary monitor as it's already set up
    fi

    # # Get the width of the previous monitor
    # prev_monitor=${monitors[$((i-1))]}

    attach_dir="--right-of"
    if [ "$manual_selection" = true ]; then
        echo "Attach $monitor to the ([l]eft [r]ight [u]p [d]own) of $prev_monitor (x to exit)"
        read -a direction

        # Validate input
        if [ ${#monitor_order[@]} -eq 0 ]; then
            echo "No input provided. Exiting."
            exit 1
        fi

        case $direction in
            l ) attach_dir="--left-of" ;;
            r ) attach_dir="--right-of" ;;
            u ) attach_dir="--above" ;;
            d ) attach_dir="--below" ;;
            * ) echo "Exiting"
                exit 1 ;;
        esac
    fi

    # Set up the monitor to the right of the previous one
    xrandr --output $monitor --auto $attach_dir $prev_monitor
    prev_monitor=$monitor
done

# run the polybar script
$HOME/.config/scripts/polybar.sh

# run background update
feh --bg-fill ~/Pictures/wallpapers/liquicity-trees.png --bg-fill ~/Pictures/wallpapers/liquicity-mountain.png

notify-send -a "monitors.sh" "Updated monitors!" "$mon_str"

echo "Monitor setup complete."

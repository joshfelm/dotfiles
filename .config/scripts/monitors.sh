#!/bin/bash

## Function to display usage
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

if [ "$manual_selection" = true ]; then
    # Display available monitors
    echo "Connected monitors:"
    echo "$connected_monitors" | nl

    # Ask user for monitor order
    echo "Enter the numbers of the monitors in the order you want them (left to right), separated by spaces:"
    read -a monitor_order

    # Validate input
    if [ ${#monitor_order[@]} -eq 0 ]; then
        echo "No input provided. Exiting."
        exit 1
    fi

    # Convert numbers to monitor names
    monitors=()
    for num in "${monitor_order[@]}"; do
        monitor=$(echo "$connected_monitors" | sed -n "${num}p")
        if [ -z "$monitor" ]; then
            echo "Invalid monitor number: $num. Exiting."
            exit 1
        fi
        monitors+=("$monitor")
    done
else
    # Use default order (order of detection)
    monitors=("${monitor_array[@]}")
fi

dis_monitors=("${dis_monitor_array}")

# Set the primary monitor (first in the list)
primary_monitor=${monitors[0]}

# Set up the primary monitor
xrandr --output "$primary_monitor" --primary --auto

# Variable to keep track of the rightmost edge
x_offset=0

#  Disconntect irrelevant monitors
for i in "${!dis_monitors[@]}"; do
    monitor=${dis_monitors[$i]}
    xrandr --output "$monitor" --off
done


# Set up each monitor
for i in "${!monitors[@]}"; do
    monitor=${monitors[$i]}
    if [ $i -eq 0 ]; then
        continue  # Skip the primary monitor as it's already set up
    fi

    # Get the width of the previous monitor
    prev_monitor=${monitors[$((i-1))]}
    
    # Set up the monitor to the right of the previous one
    xrandr --output $monitor --auto --right-of $prev_monitor
done

$HOME/.config/scripts/polybar.sh

echo "Monitor setup complete."


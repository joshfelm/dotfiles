#!/bin/bash
if pgrep spotifyd > /dev/null; then
    playerctl --player=spotifyd play-pause
else
    spotifyd
fi

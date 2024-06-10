# Terminate already running bar instances
if [ $(pgrep polybar) ]; then
    killall polybar
fi


for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar -c ~/.config/polybar/config example -r &
done

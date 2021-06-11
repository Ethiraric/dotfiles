#!/usr/bin/env bash
# {{@@ header() @@}}

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

{%@@ if profile == "Tswarra" @@%}

MONITOR=$MAIN_SCREEN polybar main_top -c ~/.config/polybar/config.ini &
MONITOR=$MAIN_SCREEN polybar main_bot -l info -c ~/.config/polybar/config.ini &

# MONITOR=$SECONDARY_SCREEN polybar secondary_top -c ~/.config/polybar/config.ini &
# MONITOR=$SECONDARY_SCREEN polybar tertiary_top -c ~/.config/polybar/config.ini &
{%@@ endif @@%}

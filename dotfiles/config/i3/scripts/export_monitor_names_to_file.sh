#!/usr/bin/env bash
# {{@@ header() @@}}

SCREENS=( $(xrandr -q | grep " connected" | cut -d ' ' -f 1 | tr '\n' ' ' | rev | cut -c 1- | rev) )

{%@@ if profile == "Tswarra" @@%}
NAMES=('MAIN_SCREEN')
NB_SCREENS=1
{%@@ else @@%}
NB_SCREENS=0
{%@@ endif @@%}
FILE=~/.config/bash/monitors.env

rm -rf $FILE

for ((i = 0 ; i < $NB_SCREENS ; i++)); do
    echo "export ${NAMES[$i]}=${SCREENS[$i]}" >> $FILE
done

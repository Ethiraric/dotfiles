#!/bin/sh

# {{@@ header() @@}}

{%@@ if profile == "Jotho" @@%}
xrandr --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1200 --pos 1920x0 --rotate normal --output DP-3 --off --output DP-4 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-5 --off
{%@@ endif @@%}

#!/bin/sh

# {{@@ header() @@}}

{%@@ if profile == "Jotho" @@%}
xrandr --output HDMI-0 --off --output DP-0 --mode 1920x1080 --pos 0x60 --rate 140.00 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1200 --pos 1920x0 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off
{%@@ endif @@%}

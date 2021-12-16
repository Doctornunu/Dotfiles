#!/bin/bash

terminator -e 'neo -D -m "Welcome back doctornunu" -c green' &
sleep 0.5

i3-msg fullscreen

i3lock -n; i3-msg kill
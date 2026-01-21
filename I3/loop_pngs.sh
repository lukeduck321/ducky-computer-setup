#!/bin/bash

# PID file
pidfile="/tmp/loop_pngs.pid"

# If PID file exists and process is running, kill it
if [ -f "$pidfile" ]; then
    oldpid=$(cat "$pidfile")
    if ps -p $oldpid > /dev/null 2>&1; then
        kill $oldpid
    fi
fi

# Save current PID
echo $$ > "$pidfile"

# Default pattern & interval
if [ -z "$1" ]; then
    pattern="*"
else
    pattern=$1/*
fi

if [ -z "$2" ]; then
    interval="0.1"
else
    interval=$2
fi

# Main loop
while true; do
    for image in $pattern; do
        feh --bg-scale $image
        sleep $interval
    done
done

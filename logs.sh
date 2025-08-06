#!/bin/bash
logfile="$1"
if [ ! -f "$logfile" ]; then
    echo "Log file not found."
    exit 1
fi

grep -n "ERROR" "$logfile"


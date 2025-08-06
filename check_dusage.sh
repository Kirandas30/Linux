#!/bin/bash
usage=$(df / | grep / | awk '{print $5}' | sed 's/%//')

if [ "$usage" -gt 80 ]; then
    echo "ALERT: Root partition usage is at ${usage}%"
else
    echo "Disk usage is normal: ${usage}%"
fi


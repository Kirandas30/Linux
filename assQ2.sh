#!/bin/bash

user=$(last | grep -v 'reboot' | awk 'NR==1 {print $1}')
echo "Last user: $user"

echo "Files owned by $user:"
find /home -user "$user" 2>/dev/null

time=$(last "$user" | grep -v 'wtmp' | awk '
  /[0-9]+:[0-9]+/ {
    split($(NF-2), t, ":");
    total += t[1]*60 + t[2]
  }
  END { print total " minutes" }')
echo "Total login time: $time"


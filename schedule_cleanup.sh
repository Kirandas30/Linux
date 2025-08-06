#!/bin/bash


dir="/var/log" 

echo "Cleaning .log files older than 7 days in $dir"
find "$dir" -type f -name "*.log" -mtime +7 -print -delete


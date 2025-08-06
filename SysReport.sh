#!/bin/bash


echo "Hostname: $(hostname)"
echo "IP Address: $(hostname -I | awk '{print $1}')"
echo "CPU Model: $(lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^ *//')"
echo "Total Memory: $(free -h | grep Mem | awk '{print $2}')"
echo "Disk Usage:"
df -h /


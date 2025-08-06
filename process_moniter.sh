#!/bin/bash


read -p "Enter process name: " pname

ps aux | grep "$pname" | grep -v grep | awk '{print "PID: " $2 ", MEM: " $4"%"}'


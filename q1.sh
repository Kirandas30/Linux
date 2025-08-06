#!/bin/bash
grep "sshd" /var/log/auth.log | grep "Accepted" | awk '{print $1, $2, $3, $9, $11}' | sort | uniq


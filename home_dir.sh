#!/bin/bash
cut -d: -f1,6 /etc/passwd | while IFS=: read user home; do
    if [ -d "$home" ]; then
        echo "User $user: Home directory exists"
    else
        echo "User $user: Home directory MISSING"
    fi
done


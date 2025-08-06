#!/bin/bash
services=("ssh" "cron" "apache2") # add service names here

for service in "${services[@]}"; do
    status=$(systemctl is-active "$service")
    echo "$service: $status"
done


#!/bin/bash
read -s -p "Enter password: " password
echo

if [[ ${#password} -ge 8 && "$password" =~ [0-9] && "$password" =~ [\!\@\#\$\%\^\&\*\(\)\_\+\.\,\;\:] ]]; then
    echo "Strong password."
else
    echo "Weak password. Must be 8+ characters, include a number and special character."
fi


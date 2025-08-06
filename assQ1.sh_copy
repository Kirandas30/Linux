#!/bin/bash

[ -z "$1" ] && echo "Provide directory!" && exit 1

file=$(ls -t "$1" 2>/dev/null | head -1)
[ -z "$file" ] && echo "No files found!" && exit 1

cp "$1/$file" "$1/${file}_copy"

word=$(tr -s '[:space:]' '\n' < "$1/$file" | grep -Eo '\w+' | awk '{freq[$1]++} END {for (w in freq) print freq[w], w}' | sort -nr | head -1 | awk '{print $2}')
echo "Most frequent word: $word"


#!/bin/bash
input="data.csv"  # replace with your CSV file
cat "$input" | sed 's/ *, */,/g' | awk -F, '{print $1, $2, $4}'  # edit column indexes as needed


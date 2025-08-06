#!/bin/bash
E_NO_ARGS=65
if [ $# -eq 0 ] 
then
echo "Please invoke this script with one or more command-line arguments."
exit $E_NO_ARGS
fi
var01=${@}
echo "var01 = ${var01}"
echo "Length of var01 = ${#var01}"
var02="${var01} EFGH28ij"
echo "var02 = ${var02}"
echo "Length of var02 = ${#var02}"
echo "Number of command-line arguments passed to script = ${#@}"
echo "Number of command-line arguments passed to script = ${#*}"
exit 0

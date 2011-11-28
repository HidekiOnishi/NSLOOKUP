#!/bin/sh

while read line
do
nslookup -type=mx $line
done < $1

exit 0

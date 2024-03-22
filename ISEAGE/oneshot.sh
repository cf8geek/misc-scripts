#!/bin/bash

# gives TSI from an NTLM hash
#echo $1
mydate=`date +%Y-%m-%d_%H-%M-%S_%N`
#CLEANSTRING=${1//[^a-zA-Z0-9]/}
#echo "$CLEANSTRING" > /tmp/$mydate.txt
echo "$1" > /tmp/$mydate.txt

/opt/hashcat/hashcat.bin --hwmon-temp-abort=88 -O -m 1000 -a 3 /tmp/$mydate.txt -1 bcdfghjklmnpqrstvwxyz -2 aeiou ?1?2?1?d?d?d?1?2?1 -w 3 -o /tmp/$mydate.output --potfile-disable --quiet > /dev/null
cat /tmp/$mydate.output | cut -d: -f2
rm /tmp/$mydate.txt
rm /tmp/$mydate.output
#EOF

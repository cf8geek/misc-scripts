#!/bin/bash

if [ -z "$2" ]
then
	echo "usage: ./probe.sh [fqdn/ip] [port] [interval]"
	echo "interval is optional; defaults to 1 second"
	exit
fi

if [ -z $3 ]
then
	INTERVAL=1
else
	INTERVAL=$3
fi

nmap -Pn -p$2 $1 | grep -e filt -e open -e clos -B1
sleep $INTERVAL
while true
do
	nmap -Pn -p$2 $1 | grep -e filt -e open -e clos
	sleep $INTERVAL
done

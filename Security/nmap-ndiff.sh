#!/bin/bash

# Ndiff and Nmap script
# make sure to install nmap and ndiff

echo -e "Type the address to scan (e.g: 192.168.1.2/24)"
read TARGETS
# default nmap options:
OPTIONS="-v -T4 -F -sV"

date=$(date +%F)

# default output folder
cd /opt/nmap_diff

nmap $OPTIONS $TARGETS -oA scan-$date > /dev/null
	if [ -e scan-prev.xml ]; then
		ndiff scan-prev.xml scan-$date.xml > diff-$date
		echo "---------- NDIFF RESULTS ----------"
		cat diff-$date
		echo
	fi
echo "--------- NMAP RESULTS -----------"
cat scan-$date.nmap
	ln -sf scan-$date.xml scan-prev.xml

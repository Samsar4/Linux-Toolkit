#!/bin/bash

### Buffered disk read time for /dev/sda1
if [ "$EUID" -ne 0 ]; then
	echo "Err! - hdparm command require sudo privileges"
else
	echo "------------------------------------------"
	echo [+] Testing Buffered disk read speed - sda1
	hdparm -t /dev/sda1
fi

### Cached disk read time
if [ "$EUID" -ne 0 ]; then
	echo "Err! - hdparm command require sudo privileges"
else
	echo "------------------------------------------"
	echo [+] Testing Cached disk read speed - sda1
	hdparm -T /dev/sda1
fi

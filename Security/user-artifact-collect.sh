#!/bin/bash

# Live forensic Script to collect user artifacts

LSPCI=/usr/bin/lspci
LSB=/usr/bin/lsb_release
W=/usr/bin/w
LASTLOG=/usr/bin/lastlog
CAT=/bin/cat
EGREP=/bin/egrep
LSOF=/usr/bin/lsof
DATE=/bin/date
HOSTNAME=/bin/hostname
UNAME=/bin/uname
FAILLOG=/usr/bin/faillog
## Files
PASSWD="/etc/passwd"
SUDOERS="/etc/sudoers"
SHADOW="/etc/shadow"
GROUP="/etc/group"
ROOTHIST="/root/.bash_history"

## Output file
OUTPUT="user.$(date +'%m-%d-%y').info.txt"

check_root(){
	local meid=$(id -u)
	if [ $meid -ne 0 ]; then
		echo "[-] Err! You need to execute as root or sudo!"
		exit 1
	fi
}

header_split(){
	echo "--------------------------------------------" >> $OUTPUT
	echo "$@" >> $OUTPUT
	echo "--------------------------------------------" >> $OUTPUT
}

user_info(){
	echo "* Hostname: $(hostname)" > $OUTPUT
	echo "* Run date and time: $(date)" >> $OUTPUT

	header_split "Linux Distro"
	echo "Linux kernel: $(uname -mrs)" >> $OUTPUT
	$LSB -a >> $OUTPUT

	header_split "Logged in Users"
	$W >> $OUTPUT

	header_split "Remote User Logins"
	$LASTLOG >> $OUTPUT

	header_split "Failed Logins"
	$FAILLOG -a >> $OUTPUT

	header_split "Local User Accounts"
  $CAT $PASSWD >> $OUTPUT
	$CAT $SHADOW >> $OUTPUT

	header_split "Local Groups"
	$CAT $GROUP >> $OUTPUT

	header_split "Root Bash History" $CAT $ROOTHIST >> $OUTPUT
	echo "-------------------------------------"
	echo "[+] User Report written to $OUTPUT."
}

check_root
user_info

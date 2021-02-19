#!/bin/bash

# Live forensic script to collect OS system artifacts

LSPCI=/usr/bin/lspci
LSB=/usr/bin/lsb_release
UPTIME=/usr/bin/uptim
DISK_USAGE=/bin/df
HOME_SPACE=/usr/bin/du
CPU="/proc/cpuinfo"
MEMORY="/proc/meminfo"
MOUNTS="/proc/mounts"
FSTAB="/etc/fstab"

## Output file
OUTPUT="system.$(date +'%m-%d-%y').info.txt"

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

sys_info(){
	echo "* Hostname: $(hostname)" >$OUTPUT
	echo "* Run date and time: $(date)" >> $OUTPUT

	header_split "Linux Distro"
	echo "Linux kernel: $(uname -mrs)" >> $OUTPUT
	$LSB -a >> $OUTPUT

	header_split "PCI Devices"
	${LSPCI} -v >> $OUTPUT

	header_split "Disk Space Output"
	${DISK_USAGE} -h >> $OUTPUT

	header_split "Home Space Output"
	${HOME_SPACE} -sh /home/* >> $OUTPUT

	header_split "Host Uptime"
	$UPTIME >> $OUTPUT

	header_split "CPU Info"
	cat $CPU >> $OUTPUT

	header_split "Memory Info"
	cat $MEMORY >> $OUTPUT

	header_split "Mounts"
	cat $MOUNTS >> $OUTPUT

	header_split "FSTAB"
	cat $FSTAB >> $OUTPUT

	header_split "Installed Packages"
	dpkg -l >> $OUTPUT
	echo "The System report written to $OUTPUT." 
}

check_root
sys_info

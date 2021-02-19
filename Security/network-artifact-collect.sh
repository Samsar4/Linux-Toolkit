#!/bin/bash

# Live forensic script to collect network activity artifacts

IP4FW=/sbin/iptables
IP6FW=/sbin/ip6tables
LSPCI=/usr/bin/lspci
ROUTE=/sbin/route
NETSTAT=/bin/netstat
LSB=/usr/bin/lsb_release
IFCFG=/sbin/ifconfig
ARP=/usr/sbin/arp

DNSCLIENT="/etc/resolv.conf"
DRVCONF="/etc/modprobe.conf"
NETALIASCFC="/etc/sysconfig/network-scripts/ifcfg-eth?-range?"
NETCFC="/etc/sysconfig/network-scripts/ifcfg-eth?"
NETSTATICROUTECFC="/etc/sysconfig/network-scripts/route-eth?"
SYSCTL="/etc/sysctl.conf"

## Output file
OUTPUT="network.$(date +'%m-%d-%y').info.txt"

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

network_info(){
	echo "* Hostname: $(hostname)" >$OUTPUT
	echo "* Run date and time: $(date)" >>$OUTPUT

	header_split "Linux Distro"
	echo "Linux kernel: $(uname -mrs)" >> $OUTPUT
	$LSB -a >> $OUTPUT

	header_split "IFCONFIG Output"
	${IFCFG} -a >> $OUTPUT
	
	header_split "Kernel Routing Table"
	${ROUTE} -n >> $OUTPUT

	header_split "DNS Client $DNSCLIENT Configuration"
	[ -f $DNSCLIENT ] && cat $DNSCLIENT >> $OUTPUT || echo "[-] Error! $DNSCLIENT file not found." >> $OUTPUT

	header_split "IP4 Firewall Configuration"
	$IP4FW -L -n >> $OUTPUT

	header_split "IP6 Firewall Configuration"
	$IP6FW -L -n >> $OUTPUT

	header_split "Network Stats"
	$NETSTAT -s >> $OUTPUT

	header_split "ARP Cache"
	$ARP -a >> $OUTPUT

	header_split "Network Tweaks via $SYSCTL"
	[ -f $SYSCTL ] && cat $SYSCTL >> $OUTPUT || echo "[-] Error! $SYSCTL not found." >>$OUTPUT

	echo "The Network report written to $OUTPUT." 
}

check_info
network_info

#!/bin/bash

# Grab multiple interface tcpdumps to files rotating every 30 minutes(1800 sec)

tcpdump -pni any -s65535 -G 1800 -w any%Y-%m-%d_%H:%M:%S.pcap

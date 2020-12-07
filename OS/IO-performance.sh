#!/bin/bash

# IO speed for linux  

# Write speed
echo "------------------------------------------"
echo "[+] Measuring throughput/writing speed"
dd if=/dev/zero of=/tmp/test1.img bs=1G count=1 oflag=dsync

# Server latency
echo "------------------------------------------"
echo [+] Measuring latency speed
dd if=/dev/zero of=/tmp/test2.img bs=512 count=1000 oflag=dsync 

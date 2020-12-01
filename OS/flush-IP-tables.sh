#!/bin/bash

echo [+] Flushing IP Tables...

iptables --flush
iptables --table nat --flush 
iptables --delete-chain 
iptables -P FORWARD ACCEPT

echo [+] Complete.

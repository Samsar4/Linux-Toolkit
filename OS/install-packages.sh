#!/bin/bash

# install multiple useful packages for this repo 

sudo apt-get update -y
# packages
declare -a list_of_packages=("ndiff" "nmap" "dig" "whois" "curl" "vim")

for var in ${list_of_packages[@]}; do
	sudo apt-get --ignore-missing install $var
done

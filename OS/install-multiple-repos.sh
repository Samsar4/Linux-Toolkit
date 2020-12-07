#!/bin/bash

line="--------------------------------------------"

list=${1?[-] ERROR: Please enter your repo list line by line! (e.g.: ./repos.sh repo_list.txt) }

for f in `cat $list | egrep -o 'https?://[^ ]+'`; do
	`git clone $f`
	echo $line
done 

echo "[+] Number of repositories cloned:"
lines= cat $list | egrep -o 'https?://[^ ]+' | wc -l 
echo $lines

echo "--------------------------------------------"


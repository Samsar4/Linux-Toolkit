#!/bin/bash

urls=${1?[-] ERROR! Missing input file. (./organize.sh urls.txt) }

for f in `cat $urls | egrep -o 'https?://[^ ]+'`; do
	echo $f >> newfile.txt
done 

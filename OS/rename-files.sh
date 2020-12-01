#!/bin/bash

for file in *.htm; do
	name=$(basename "$file" .htm)
	mv "$file" "$name.html"
done

## TIP: before running this script, to test if works, make sure to output the mv command with echo to print out the responses and check if is correct awnser

	# ( e.g.: echo mv "$file" "$name.html" )

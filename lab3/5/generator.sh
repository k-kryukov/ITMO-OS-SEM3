#!/bin/bash

while true; do
	read LINE
	if [[ "$LINE" == "QUIT" ]]
	then
		echo "QUIT"
		killall handler.sh
		exit
	fi	
	
	if [[ "$LINE" != "+" && "$LINE" != "*" && ! "$LINE" =~ ^(-?[0-9]+)$ ]]
	then
		echo "wrong opt!"
		exit
	fi

	echo "$LINE" > pipe
done

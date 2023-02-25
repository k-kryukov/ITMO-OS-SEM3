#!/bin/bash

mode="+"
value=1

(tail -f pipe) |
while true; do
	read LINE;
	echo "Got $LINE"
	case "$LINE" in
		\+)
			echo "changed mode to +"
			mode="+"
		;;
		\*)
			echo "changed mode to *"
			mode="*"
		;;
		*)
			result=$(echo "$LINE$mode$value" | bc)
			value="$result"
            		echo "$result"
		;;
	esac
done

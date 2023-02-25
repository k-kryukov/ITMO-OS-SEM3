#!/bin/bash

a=()
let cnt=0
n=$1
>report.log

while true
do
	let cnt="$cnt+1"
	a+=(1 2 3 4 5 6 7 8 9 10)
	if [[ "$cnt" -ge $n ]]
	then
		echo "Successful exit!" >> log_file
		exit 0
	fi

done

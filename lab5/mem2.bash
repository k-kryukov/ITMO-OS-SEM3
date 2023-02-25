#!/bin/bash

a=()
let cnt=0
>report2.log

while true
do
	let cnt="$cnt+1"
	a+=(1 2 3 4 5 6 7 8 9 10)
	if (( $cnt % 100000 == 0 ))
	then
		echo ${#a[*]} > report2.log
	fi

done

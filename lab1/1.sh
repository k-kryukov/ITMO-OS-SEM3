#!/bin/bash

x=$1
y=$2
z=$3

res=x

if [[ "$x" -ge "$y" ]]; then
	res=$x
else
	res=$y
fi

if [[ "$res" -ge "$z" ]]; then
	echo "$res"
else
	echo "$z"
fi

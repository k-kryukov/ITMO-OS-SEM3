#!/bin/bash

read s
stop_string="q"
res=""

while [[ "$s" != "$stop_string" ]]
do
	res="$res$s"
	read s
done

echo "$res"

#!/bin/bash

k=$1
n=$2
> log_file

for (( i=0; i<k; i++ ))
do
	sleep 1
	./newmem.bash $n &
done

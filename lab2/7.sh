#!/bin/bash
wait_time=60
separator=:

for pid in $(ls /proc | grep -E "[0-9]+" | sort -n)
do
	echo $pid $(grep -s "read_bytes:" "/proc/$pid/io" | awk '{printf("%s", $2)}') >> buffer_1
done

sleep $wait_time

for pid in $(ls /proc | grep -E "[0-9]+" | sort -n)
do
	echo $pid $(grep -s "read_bytes:" "/proc/$pid/io" | awk '{printf("%s", $2)}') >> buffer_2
done

cat buffer_1 | while read line
do
	pid=$(echo $line | awk '{printf("%d", $1)}')

	prev_rchar=$(echo $line | awk '{printf("%d", $2)}')
	cur_rchar=$(cat buffer_2 | awk -v pid_awk=$pid '{if ($1 == pid_awk) printf("%d", $2)}')

	process_name=$(ps -q $pid | sed '1d' | awk '{printf("%s", $4)}')
	echo $pid"$separator"$process_name"$separator"$(($cur_rchar - $prev_rchar))
done | sort -t ":" -n -k3 | tail -3

rm buffer_*

#!/bin/bash

s=""

./useless_process_4.sh &
pid_1=$!

./useless_process_4.sh &
pid_2=$!

./useless_process_4.sh &
pid_3=$!

read s 

./control_useless_process_4.sh "$pid_1" &
control_pid=$!

read s

kill -9 $pid_3

read s

kill -9 $pid_2
kill -9 $pid_1
kill -9 $control_pid


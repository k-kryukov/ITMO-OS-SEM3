#!/bin/bash

echo $$ > .handler_pid

value=1

cur_signal=""

usr1()
{
	cur_signal=1
}
usr2()
{
	cur_signal=2
}
sigterm()
{
	cur_signal=3
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigterm' SIGTERM

while true; do
	sleep 1
	case $cur_signal in
		1)
			value=$(echo "$value+2" | bc -l)
			echo "now value is $value"	
		;;
		2)
			value=$(echo "$value*2" | bc -l)
			echo "now value is $value"	
		;;
		3)
			echo "My work here is done!"
			exit
			;;
		*)
			:
			;;
	esac
	cur_signal=""
done

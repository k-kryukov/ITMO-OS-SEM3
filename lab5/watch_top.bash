> top_results.log

while [ true ]
do
	sleep 1
	top -b -n 1 | grep "mem.bash" | head -1 | awk '{print $10}'
	top -b -n 1 | grep "mem2.bash" | head -1 | awk '{print $10}'
done

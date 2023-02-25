watching_pid=$1

echo "$watching_pid"

while true
do
	sleep 1
	cur_priority=$(top -bp "$watching_pid" -n1 | tail -1 | awk '{print $4}' | tr , .)
	percents=$(top -bp "$watching_pid" -n1 | tail -1 | awk '{print $9}' | tr , .)

	echo "$percents $cur_priority"
	
	if (( $(echo "$percents > 10.0" | bc -l) )); then		
		sudo renice $(echo "$cur_priority + 1" | bc -l) -p $watching_pid
	fi
done

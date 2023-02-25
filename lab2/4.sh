for PID in $(ps -eo pid | sed '1d') # take PID just from ps
do
	dir="/proc/$PID"
	CUR_PPID=$(grep -sE "^PPid" "$dir/status" | awk '{print $2}')
	
	sum_exec_runtime=$(grep -s "sum_exec_runtime" "$dir/sched" | awk '{printf("%s", $3)}')
	nr_switches=$(grep -s "nr_switches" "$dir/sched" | awk '{printf("%s", $3)}')

	#echo $(awk -F ":" '$1 ~ /sum_exec_runtime$/ {print $2}' "$dir/sched")
	#ART=$(awk -F ":" '$1 ~ /sum_exec_runtime$/ {print $2}' "$dir/sched")

	if [[ -n "$nr_switches" ]]
	then
		ART=$(echo "scale=2 ; $sum_exec_runtime / $nr_switches" | bc)
	else
		ART="-1"
	fi

	if [[ -n "$CUR_PPID" ]]
	then
		echo "ProcessID= $PID : Parent_ProcessID= $CUR_PPID : Average_Running_Time= $ART" >> temp4
	fi
done

cat temp4 | sort -n -k5
rm temp4

prev_ppid=-1
sm=0
cnt=0

echo -e "$(/bin/bash 4.sh) \nstop -228" | while read line
do
	pid=$(echo $line | awk '{print $2}')
	ppid=$(echo $line | awk '{print $5}')
	art=$(echo $line | awk '{print $8}')

	if [[ "$ppid" == "$prev_ppid" ]]
	then
		# echo "equal"
		sm=$(echo "$art + $sm" | bc)
		cnt=$(($cnt+1))	
	else
		# echo "not equal"
		if [[ "$cnt" != "0" ]]
		then
			#echo "We have $sm / $cnt"
			average=$(echo "scale=3; $sm/$cnt" | bc)
			echo "Average_Running_Children_of_ParentID= $prev_ppid is $average"
		fi
		
		prev_ppid=$ppid
		cnt=1
		sm=$art
		# echo "now sm is $sm"
	fi
	
	if [[ $(echo $line | awk '{print $1}') == "stop" ]]
	then
		# echo "last line is $line"
		exit 0
	fi	
	echo "ProccesID= $pid : Parent_ProcessID= $ppid : Average_Running_Time= $art"

done


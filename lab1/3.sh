read op_num

while [[ -n "$op_num" ]]
do
	if [[ "$op_num" = "1" ]]; then
		nano
	elif [[ "$op_num" = "2" ]]; then
		vi
	elif [[ "$op_num" == "3" ]]; then
		links
	elif [[ "$op_num" == "4" ]]; then
		exit
	else
		echo "Wrong option number!"
	fi

	read op_num
done

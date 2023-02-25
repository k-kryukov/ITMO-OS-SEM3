ps -aux | awk '$11 ~ /^\/sbin/{print $2}'

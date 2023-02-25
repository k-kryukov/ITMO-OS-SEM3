ps -aux | sed '1d' | sort -nrk 9 | head -8 | tail -1 | awk '{printf("pid: %s, cmd: %s", $2, $11)}'

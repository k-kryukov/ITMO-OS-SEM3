top -o RES | head -n 8 | tail -n 1 | awk 'BEGIN {printf("top output ")} {printf("pid:%s   res:%s\n", $2, $7)}'

grep "VmRSS" /proc/*/status | sort -nrk2 | head -1 | sed 's/\// /g' | awk 'BEGIN {printf("/proc output ")} {printf("pid:%s   res:%s\n", $2, $4)}'

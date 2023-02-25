
home_dir="~"

mkdir "$HOME/test" 2> /dev/null && {
	echo 'catalog test was created successfully' 1> "$HOME/report"
	> "$HOME/test/$(date '+%d%m%y_%H%M%S')"
}

# timeout 5
ping "www.net_nikogo.net" || echo "$(date '+%d%m%y_%H%M%S'): net_nikogo is not available!" >> "$HOME/report"

cwd=$(pwd)

if [[ "$cwd" == "$HOME" ]]; then
	echo "$HOME"
	exit 0
else
	echo "error: cur path is not home directory!"
	exit 1
fi

#!/bin/bash

file_name="$1"

if [ ! -d "$HOME/.trash" ]
then
	echo "Created trash directory"
	mkdir "$HOME/.trash"
fi

echo "$file_name"
cat -- "$file_name" 2>/dev/null 1>/dev/null
if [[ $? -ne 0 ]]
then
	echo "Error: file $file_name doesn't exist"
	exit 1	
fi

id=$(uuidgen)
ln "$PWD/$file_name" "$HOME/.trash/$id"
path=$(readlink -f "$PWD/$file_name")
echo "We have $path"

echo "$path $id">> $HOME/.trash.log
rm "$PWD/$file_name"

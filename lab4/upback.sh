#!/bin/bash

mkdir "$HOME/restore" 2>/dev/null

backup=$(ls $HOME | grep "Backup-" | sort -r | head -1)
if [[ backup = "" ]]
then
    echo "No backups found"
    exit 0
fi

regex="(\.[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1]))$"
IFS=$'\n'
for file in $(ls "$HOME/$backup" | sed -r "/$regex/d")
do
	echo "$file"
	cp "$HOME/$backup/$file" "$HOME/restore"
done

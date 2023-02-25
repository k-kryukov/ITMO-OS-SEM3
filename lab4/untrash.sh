#!/bin/bash

lines=$(awk '{print}' $HOME/.trash.log)
IFS=$'\n'
for line in $lines;
do
    trash_hash=$(echo $line | awk -F " " '{print $NF}')
    path=$(echo $line | awk -F " " '{NF--; print}')
    cur_file_name=$(echo $path | awk -F "/" '{print $NF}')
    echo "Cur path is $path"
    echo "Cur string is $line"
    echo "Hash is $trash_hash"
    echo "Name is $cur_file_name"
    if [ "$cur_file_name" != "$1" ]
    then
	continue
    fi
    echo "Do you want to restore file $path with hash $trash_hash?"
    read answer
    answer=$(echo "$answer" | tr [:upper:] [:lower:])
    if [ "$answer" == "y" ] || [ "$answer" == "yes" ]
    then
	echo "starting restoring"
	echo "Path to restored file is $path"
    else
	echo "ok, checking next"
	continue
    fi

    restore_folder=""
    folder=$(echo "$path" | awk -F "/" '{OFS="/"; NF--; print}')
    ls $folder 1>/dev/null 2>/dev/null
    if [ "$?" -ne 0 ]
    then
	echo "Folder doesn't exists, restoring to home directory"
	restore_folder=$HOME
    else
	restore_folder=$folder
    fi
    echo "$HOME/.trash/$trash_hash and $restore_folder/$name"

    cat "$path" 1>/dev/null 2>/dev/null 
    if [ "$?" -eq 0 ]
    then
	echo "File name already exists, choose another file name"
	read name
	ln "$HOME/.trash/$trash_hash" "$restore_folder/$name"
    else
	ln "$HOME/.trash/$trash_hash" "$restore_folder/$cur_file_name"
    fi

    rm "$HOME/.trash/$trash_hash"
    sed -i "/$trash_hash/d" $HOME/.trash.log    
    break
done


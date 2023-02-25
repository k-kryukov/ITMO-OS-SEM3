#!/bin/bash

backup=$(ls $HOME | grep "Backup-" | sort -r | head -1)
last_backup_date=$(echo "$backup" | cut -d "-" -f2-)
cur_date=$(date +"%Y-%m-%d")

echo "LBD: $last_backup_date, cur date $cur_date"

sec_in_week="604800"
let diff=($(date +%s -d "$cur_date")-$(date +%s -d "$last_backup_date"))
echo $diff

if [[ "$diff" -gt "$sec_in_week" ]] || [[ $backup = "" ]]
then	
	backup="Backup-$(date +'%Y-%m-%d')"
	mkdir "$HOME/$backup"
	echo "Created $backup"
	cp "$HOME/source/"* "$HOME/$backup" 2>/dev/null
	echo "New folder $HOME/$backup was created $(date)" >> "$HOME/backup-report"

	ls "$HOME/$backup" >> "$HOME/backup-report"
else
	touch .new_files_list
	touch .existing_files_list
	
	echo "Folder $HOME/$backup is changing $(date)" >> "$HOME/backup-report"
	IFS=$'\n'
	for file in $(ls $HOME/source)
	do
		if [[ -d "$HOME/source/$file" ]]
		then
			continue
		fi

		if ! [[ -f "$HOME/$backup/$file" ]]
		then
			cp "$HOME/source/$file" "$HOME/$backup/$file" 2>/dev/null
			echo "$file is copied as new" 
			echo "$file" >> .new_files_list
		else
			new_size=$(stat "$HOME/source/$file" -c %s)
			prev_size=$(stat "$HOME/$backup/$file" -c %s)
			if [[ new_size -eq prev_size ]]
			then
				echo "Omitting $file"
				continue
			else
				echo "Copying $file as existing"
				mv "$HOME/$backup/$file" "$HOME/$backup/$file.$cur_date"
				cp "$HOME/source/$file" "$HOME/$backup/$file"
				echo "$file" >> .existing_files_list
			fi
		fi
	done

	cat .new_files_list .existing_files_list >> "$HOME/backup-report"
	rm .new_files_list
	rm .existing_files_list
fi


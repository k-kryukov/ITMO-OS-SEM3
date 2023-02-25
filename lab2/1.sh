#!/bin/bash

ps -aux | awk '{if ($1 == "user") print}' | wc -l

ps -aux | awk '{if ($1 == "user") { {printf "%s: ", $2} {for(i=11;i<=NF;i++) printf("%s ", $i); } {printf "\n"}}}'

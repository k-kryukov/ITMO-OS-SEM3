#!/bin/bash

touch $HOME/report

at now +2 minutes -f ./1.sh &
tail -f -n0 $HOME/report

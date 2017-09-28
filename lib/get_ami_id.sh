#!/usr/bin/bash

logfile=$(find . -maxdepth 1 -name build\*.log | sort | tail -1)
ami_id=$(awk '/^us-east-1: / {print $2}' ${logfile})
echo ${ami_id}

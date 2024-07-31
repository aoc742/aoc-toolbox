#!/bin/bash

# This is your custom script that you want to run on startup.
# It can be any command(s) or application.

# This example script polls CPU usage every 5 seconds and logs 
# that information to a log file. 

LOGPATH=$(dirname -- "$0";)
LOGFILE=$LOGPATH/ps.log
echo "Logging at: $LOGFILE" 

while true; 
do 
    find $LOGFILE -size +1G -delete  # delete log file if larger than 1 GB
    (echo "%CPU %MEM ARGS $(date)" && 
    ps -e -o pcpu,pmem,args --sort=pcpu | cut -d" " -f1-5 | tail) >> $LOGFILE;
    sleep 5; 
done

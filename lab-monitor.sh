#!/bin/bash

CPU=$(top -bn1 | awk '/Cpu/ {print 100 - $8}')
DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

LOG="/var/log/lab-monitor.log"

if (( $(echo "$CPU > 80" | bc -l) )) || [ "$DISK" -gt 85 ]; then
    echo "$(date) ALERT CPU=$CPU DISK=$DISK" >> $LOG
    
    BADPID=$(ps aux --sort=-%cpu | awk 'NR>1 && $2!=1 {print $2; exit}')
    echo "$(date) Killing PID $BADPID" >> $LOG
    kill -9 $BADPID
    
    systemctl restart nginx
    echo "$(date) nginx restarted" >> $LOG
else
    echo "$(date) OK CPU=$CPU DISK=$DISK" >> $LOG
fi


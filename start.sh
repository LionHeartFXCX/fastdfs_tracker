#!/bin/bash
#set -e

# if the log file exists, delete it to avoid useless log content
FASTDFS_LOG_FILE="$FASTDFS_BASE_PATH/logs/trackerd.log"

if [  -f "$FASTDFS_BASE_PATH/logs/trackerd.log" ]; then 
	rm  "$FASTDFS_LOG_FILE"
fi

echo "start the tracker node..."

# start the tracker node	
fdfs_trackerd /etc/fdfs/tracker.conf

# wait for pid file(importent!)
sleep 3s

tail -F --pid=`cat $FASTDFS_BASE_PATH/data/fdfs_trackerd.pid`  $FASTDFS_BASE_PATH/logs/trackerd.log
	
# wait `cat /fastdfs/tracker/data/fdfs_trackerd.pid`
	
#tail -F --pid=`cat /fastdfs/tracker/data/fdfs_trackerd.pid`  /dev/null

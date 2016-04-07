#!/bin/bash
#set -e

# if the log file exists, delete it to avoid useless log content.
FASTDFS_LOG_FILE="$FASTDFS_BASE_PATH/logs/trackerd.log"
TRACKER_PID_NUMBER="$FASTDFS_BASE_PATH/data/fdfs_trackerd.pid"

if [ -f "$FASTDFS_LOG_FILE" ]; then 
	rm "$FASTDFS_LOG_FILE"
fi

echo "try to start the tracker node..."

# start the tracker node.	
fdfs_trackerd /etc/fdfs/tracker.conf start

# wait for pid file(important!),the max start time is 5 seconds,if the pid number does not appear in 5 seconds,tracker start failed.
TIMES=5
while [ ! -f "$TRACKER_PID_NUMBER" -a $TIMES -gt 0 ]
do
    sleep 1s
	TIMES=`expr $TIMES - 1`
done

# if the tracker node start successfully, print the started time.
if [ $TIMES -gt 0 ]; then
    echo "the tracker node started successfully at $(date +%Y-%m-%d_%H:%M)"
	
	# give the detail log address
	echo "please have a look at the log detail at $FASTDFS_LOG_FILE"
	
	# leave balnk lines to differ from next log.
    echo
    echo
	
	# make the container have foreground process(primary commond!)
    tail -F --pid=`cat $FASTDFS_BASE_PATH/data/fdfs_trackerd.pid` /dev/null
# else print the error.
else
    echo "the tracker node started failed at $(date +%Y-%m-%d_%H:%M)"
	
	# give the detail log address
	echo "please have a look at the log detail at $FASTDFS_LOG_FILE"
	
	# leave balnk lines to differ from next log.
    echo
    echo
fi
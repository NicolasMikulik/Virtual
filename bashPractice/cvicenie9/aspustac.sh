#!usr/bin/env bash
los_count=$( ps aux | grep losovac.sh | wc -l )
if [ "$los_count" -le 1 ]
then
	bash alosovac.sh &
	id=$!
	echo "Losovac was started in background with PID $id"
else
	id=$( ps aux | grep losovac.sh | head -1 | awk '{print $2}' )
	echo "Losovac is already running with PID $id"
fi
x=$((  ( RANDOM % 5) + 1))
sleep $(( x + 5 ))
echo "ID of losovac.sh is $id. Sending SIGUSR1"
kill -s SIGUSR1 "$id"
sleep 5
pkill sleep
kill -s SIGKILL "$id"

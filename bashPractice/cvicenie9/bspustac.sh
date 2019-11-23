#!usr/bin/env bash
id=$( ps aux | grep losovac.sh | head -1 | awk '{print $2}' )
echo "Losovac is already running with PID $id"
x=$((  ( RANDOM % 5) + 1))
sleep $(( x + 5 ))
echo "ID of losovac.sh is $id. Sending SIGUSR1"
kill -s SIGUSR1 "$id"
sleep 5
pkill sleep
kill -s SIGKILL "$id"

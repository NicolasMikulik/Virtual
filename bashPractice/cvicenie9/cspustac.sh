#!usr/bin/env bash
id=$( head -1 /tmp/losovac.PID )
x=$((  ( RANDOM % 5) + 1))
sleep $(( x + 5 ))
echo "ID of losovac.sh is $id. Sending SIGUSR1"
kill -s SIGUSR1 "$id"
sleep 5
pkill sleep
kill -s SIGKILL "$id"
rm /tmp/losovac.PID

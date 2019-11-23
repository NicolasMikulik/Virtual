#!usr/bin/env bash
x=$((  ( RANDOM % 10) + 1))
sleep $x
id=$( ps aux | grep losovac.sh | head -1 | awk '{print $2}' )
echo "ID of losovac.sh is $id. Sending SIGUSR1"
kill -s SIGUSR1 "$id"


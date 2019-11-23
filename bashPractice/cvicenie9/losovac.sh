#!usr/bin/env bash
x=10
if [ $# -eq 0 ]
        then
                echo "No number of participants supplied, number of participants set to 10."
                x=10
        else
                x="$1"
                echo "Number of participants is $1"     
fi
var=$(( ( RANDOM % "$x" ) + 1 ))
echo "$var"
this_script=$$
trap 'echo "Hello number $var"
        pkill -P $this_script sleep > /dev/null 2>&1' SIGUSR1 > /dev/null 2>&1
while :
do
        sleep infinity &
        wait > /dev/null 2>&1
        var=$(( ( RANDOM % "$x" ) + 1 ))
        echo "Hello $x participants"
done

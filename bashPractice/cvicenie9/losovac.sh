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
trap 'echo "Hello number $var"' SIGUSR1
while :
do
        sleep infinity
        echo "Hello $x participants"
done

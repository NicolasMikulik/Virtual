#!/bin/bash
read -p "Please enter file path: " FILE
echo $FILE
directory="$(dirname $FILE)"
echo $status
if not [[ -d "$directory" ]]; then
	echo "$directory does not exist"
	exit 1
fi
if [[ -f "$FILE" ]]; then
	echo "$FILE exists"
	exit 1
fi
touch $FILE
chmod 646 $FILE

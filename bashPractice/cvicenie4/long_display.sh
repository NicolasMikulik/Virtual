#!/usr/bin/env bash

#set -x
set -o errexit
user=$USER
pgroup=0
primary_gid=0

if [ $# -eq 0 ] ; then
	echo "No options or arguments provided"
	exit 1
fi

print_groups(){
	echo "test4"
	grep "$1" /etc/group | cut -d ":" -f 1
}
print_primary(){
	echo "test5"
	primary_gid=$(grep "$1" /etc/passwd | cut -d ":" -f 4)
	grep -w "${primary_gid}" /etc/group | cut -d ":" -f 1
}
while :; do
	case "$1" in
		-h)
			echo "Usage: $0 -h [ -u user ] [ -g ]"
			exit 0
			;;
		--help)
			echo "Usage: $0 -h --help [ -u|--user user ] [ -g|--group ]"
			echo "-u chooses the entered user to show their groups"
			echo "-g shows only primary group"
			exit 0
			;;
		-g|--group)
			echo "test"
			pgroup=1
			shift
			#group_id=`grep "^$(whoami)" /etc/passwd | cut -d ":" -f 4`
			#group_name=`grep "$group_id" /etc/group | cut -d ":" -f 1`
			;;	
		-u|--user)	
			if [ "$2" ]; then
				user=$2
				shift
			else
				echo "ERROR: \"-u\" requires a username"
			fi
			#grep "$user" /etc/group | cut -d: -f1
			;;
		--)
			shift
			break
			;;
		*) 		
			break
	esac
done
if [ ${pgroup} -eq 0 ] ; then
	print_groups "${user}"
	echo "test2"
else
	echo "tes3t"
	print_primary "${user}"
fi

exit 0

#!/usr/bin/env bash

#set -x
set -o errexit
user=$USER
pgroup=0
primary_gid=0

print_groups(){
	grep "$1" /etc/group | cut -d ":" -f 1
}
print_primary(){
	primary_gid=$(grep "$1" /etc/passwd | cut -d ":" -f 4)
	grep -w "${primary_gid}" /etc/group | cut -d ":" -f 1
}
while :; do
	case "$1" in
		-h)
			echo "Usage: $0 -h [ -g|--group ] [ -u|--user user ]"
			exit 0
			;;
		--help)
			echo "Usage: $0 -h --help [ -g|--group] [ -u|--user user ]"
			echo "-u or --user choose the entered user to show their groups. The user is set to the current user by default."
			echo "-g or --group show only primary group of user"
			exit 0
			;;
		-g|--group)
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
else
	print_primary "${user}"
fi

exit 0

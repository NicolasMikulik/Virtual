#!/usr/bin/env bash

#set -x
set -o errexit
user=$USER
all_groups=1
primary_gid=0

if [ $# -eq 0 ] ; then
	echo "No options or arguments provided"
	exit 1
fi

print_for_user(){
	grep "$1" /etc/group | cut -d ":" -f 1
}
print_primary(){
	primary_gid=$(grep "$1" /etc/passwd | cut -d ":" -f 3)
	grep -w "${primary_gid}" /etc/group | cut -d ":" -f 1
}
while getopts "hgu:" options; do
	case "${options}" in
		h)
			echo "Usage: $0 -h [ -u user ] [ -g ]"
			exit 0
			;;
		g)
			all_groups=0
			#group_id=`grep "^$(whoami)" /etc/passwd | cut -d ":" -f 4`
			#group_name=`grep "$group_id" /etc/group | cut -d ":" -f 1`
			;;	
		u)	
			user=${OPTARG}
			#grep "$user" /etc/group | cut -d: -f1
			;;
		*) 		
			echo "Usage: $0 -h [ -u user ] [ -g ]"
			;;
	esac
done
if [ ${all_groups} -eq 1 ] ; then
	print_for_user "${user}"
else
	print_primary "${user}"
fi

exit 0

#!/usr/bin/env bash

user=$USER
all_groups=1
primary_group_id=0
args=$(getopt -o u:gh --long help -- "$@")

[ $? -eq 0 ] || {
	echo "Incorrect options provided"
	exit 1
}

print_for_user(){
	grep "$1" /etc/group | cut -d ":" -f 1
}

print_primary_for_user(){
	primary_group_id=$(grep "$1" /etc/passwd | cut -d ":" -f 3)
	grep -w "${primary_group_id}" /etc/group | cut -d ":" -f 1
}

print_short_help(){
	echo "Usage: $0 [ -u USERNAME ] [ -g ]"
}

print_full_help(){
	print_short_help
	echo "-u takes usename, default is current user"
	echo "-g prints only primary group"
}

eval set -- "$args"

while true; do
	case "$1" in
		-g)
			echo "tes1t"
			all_groups=0
			;;
		-u)
			echo "tes2t"
			shift
			user=$1
			;;
		-h)
			echo "test3"
			print_short_help
			exit 0
			;;
		--help)	
			echo "tes4444t"
			print_full_help
			exit 0
			;;
		--)
			echo "test"
			shift
			break
			;;
	esac
	shift
done

if [ ${all_groups} -eq 1 ] ; then
	print_for_user "${user}"
else
	print_primary_for_user "${user}"
fi

exit 0

#!/usr/bin/env bash

#set -x
set -o errexit
while getopts "hgu:" options; do
	case "${options}" in
		h)
			echo "Usage: $0 -h [ -u user ] -g"
			;;
		g)
			group_id=`grep "^$(whoami)" /etc/passwd | cut -d ":" -f 4`
			echo "Default group ID:  "$group_id""
			group_name=`grep "$group_id" /etc/group | cut -d ":" -f 1`
			echo "Default group name: "$group_name""
			;;	
		u)	
			USER=${OPTARG}
			echo "Display groups of user $USER"

			grep "$USER" /etc/group | cut -d: -f1
			;;
	esac
done

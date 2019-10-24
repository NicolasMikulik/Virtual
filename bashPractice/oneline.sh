#!/bin/bash
cd /etc/
for i in $(ls); do
	Date=$(stat -c "%y" $i)
	changeDate=${Date:0:10}
	if [[ "$changeDate" != "2019-10-10" ||  "$changeDate" != "2019-10-11" ||  "$changeDate" != "2019-10-09" ]]; then
		head $i --lines=5
	fi
	#echo $changeDate;
done

#!/usr/bin/env bash
args=("$@")
elements=${#args[@]}

for (( i=0;i<$elements;i++ )); do
	echo ${args[${i}]}
done

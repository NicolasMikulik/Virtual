#!/bin/bash
for i in $(find /etc/ -mtime +2 -type f 2>error.log); do head -5 -v $i | grep "a"; done
#number of matching lines: for i in $(find -mtime +2 -type f 2>error.log); do grep -c 5 "a" $i 2>error.log; done
#for i in $(find /etc/ -mtime +2 -type f 2>error.log); do grep -m 5 "a" $i | head -5 -v; done    


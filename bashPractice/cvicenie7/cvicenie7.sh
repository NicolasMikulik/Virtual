#!/bin/bash
lines=$(awk 'END{print NR}' ./access.log)
mobiles=0
mobiles=$(awk '/Mobile/{mobiles++}; END{print mobiles+0}' ./access.log)
#echo "$mobiles"
printf "The file ./access.log contains "$lines" entries, "$mobiles" of which are built by mobile devices. Percentage " 
echo "scale=4 ; $mobiles / $lines * 100" | bc

total=$(awk '{sum+=$10}; END{print sum/1024/1024}' ./access.log)
totalbytes=$(awk '{for(i=1;i<=NF;i++){if($i ~ /HTTP\/1\./){totalbytes+= $(i+1)}}} END{print totalbytes}' access.log)
mobbytes=$(awk '{for(i=1;i<=NF;i++){if($i ~ /HTTP\/1\./){n=$(i+2)} if($i ~ /Mobile/){sum+=n}}} END{print sum/1024/1024}' ./access.log)

printf "Total number of transferred bytes "$total"MB, "$mobbytes"MB of which build up by mobile devices. Percentage "
echo "scale=4; $mobbytes / $total * 100" | bc
printf "\n10 most present IP addresses are\n:"
awk '{print $1}' ./access.log | sort | uniq -c | sort -rn | head -10 | awk 'BEGIn { print "10 most present IP addresses: \n"} {print $2, "occured", $1, "times"}'
printf "\nDNS entries for the most present IP addresses are:\n"
awk '{print $1}' ./access.log | sort | uniq -c | sort -rn | head -10 | awk '{print $2}' | nslookup
# tail access.log | awk '{print $1}' | nslookup
# awk '{for(i=1;i<=NF;i++){if($i ~ /HTTP\/1\./){if($(i+1) ~ /404/){found++}}}};END{print found}' access.log (result 213)
echo "URL with most requests ending with ERROR 404"
awk '{for(i=1;i<=NF;i++){if($i ~ /HTTP\/1\./){if($(i+1) ~ /404/){print $7}}}}' access.log | sort | uniq -c | sort -rn | head -1 | awk '{print $2}'

printf "\nHistogram of request arrival times (one \"*\" represents 10 entries)\n"
awk -F ":" '{print $2}' ./access.log | awk 'BEGIN{delta=1} 
{
	place = int($0 / delta)
	hist[place]++;
	entries = (entries > place ? entries : place)
}
END{
	for(place = 0; place<=entries; place++){
		end = begin + delta
		if(end > 23)
			end = 0
		if(begin < 10 && end < 10){
			printf "cas 0%d:00-0%d:59 %d", begin, end, hist[place]
		}
		if(begin < 10 && end == 10){	
			printf "cas 0%d:00-%d:59 %d", begin, end, hist[place]
		}
		if(begin >= 10 && end != 0){	
			printf "cas %d:00-%d:59 %d", begin, end, hist[place]
		}
		if(begin >10 && end == 0)
			printf "cas %d:00-0%d:59 %d", begin, end, hist[place]
		for(i = 1; i<=hist[place]/10; i++){
			printf "*"
		}
		printf "\n"
		sum+=hist[place]
		begin = end
	}
}'

#!usr/bin/env bash
printf "Change only in third line\n"
sed '3s/Zuzka/Lucka/g' list.txt #change only on third line
printf "\nChange only in the second sentence of third line.\n"
sed 's/Zuzka, ja Ta milujem/Lucka, ja Ta milujem/' list.txt
printf "\nUppercase\n"
sed 's/Zuzka/ZUZKA/g' list.txt
printf "\nDelete empty lines\n"
sed '/^$/d' list.txt
printf "\nReplace mozno with nemozno\n"
sed 's/^mozno/nemozno/' list.txt
printf "\nReplace iloveyou with ihateyou\n"
sed 's/\/usr\/bin\/iloveyou/\/sbin\/ihateyou/' list.txt
printf "\nRemove even numbered lines\n"
sed '0~2d' list.txt
printf "\nDisplay only poem with line numbers\n"
sed -n '/ozno/{=;p}' list.txt | sed '{N; s/\n/ /}'
# sed -n 'n;p' list.txt # odd numbered lines
# sed -n 'p;n' list.txt # even numbered lines
# sed -n '1,10p' list.txt # simulate head
# sed -n '/mozno/p' list.txt # simulate grep


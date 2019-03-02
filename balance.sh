#!/usr/bin/env bash
clear
echo "-----------------------------"
echo "          mybtc  v1.0        "
echo "-----------------------------"
price=$(curl -s http://api.coindesk.com/v1/bpi/currentprice.json | python -c "import json, sys; print(json.load(sys.stdin)['bpi']['USD']['rate'])")
echo "current price in US$: "$price"$"
array=( 3P3QsMVK89JBNqZQv5zMAKG8FK3kJM4rjt 
	3NCsQ4CruQq1LLiZzNwT3nS49oZePkHXQM
	1F1tAaz5x1HUXrCNLbtMDqcw6o5GNn4xqX
	198aMn6ZYAczwrE5NvNTUMyJ5qkfy4g3Hi )
count=0

output ()
{
for i in ${array[@]}; do
	((count++))
	n=$(wget -qO- blockchain.info/rawaddr/$i 2>&1 | grep -Po '"final_balance":\K[0-9]+' | awk '{s=$1/100000000} END {printf "%0.8f", s}')
        echo $count " | "$i " | " $n " btc"
	#echo $(($n*$price))
done
}
echo "-----------------------------------------------------------------"
output
echo "-----------------------------------------------------------------"
echo "number for the qr code?"
read code

if [ $code -eq 0 ]
then
  	echo "exiting....."
	exit
else
  	echo "generating qr code for the address: "${array[code-1]}
	qrencode -o ${array[code-1]}.png $i
	eog ${array[code-1]}.png
	rm ${array[code-1]}.png
fi

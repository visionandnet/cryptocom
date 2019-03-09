#!/bin/bash
clear
echo "-----------------------------"
echo "       cryptocom  v1.0       "
echo "-----------------------------"
dollar_price_bitcoin=$(curl -s https://api.coindesk.com/v1/bpi/currentprice/usd.json | grep -o 'rate":"[^"]*' | cut -d\" -f3)
echo "current price in US$: "$dollar_price_bitcoin"$"

curl -s https://www.finanzen.net/devisen/binance-coin-us-dollar-kurs > tmp_file
cat tmp_file | grep "class=\"col-xs-5 col-sm-4 text-sm-right text-nowrap\"" | cut -d'>' -f4 | cut -d'<' -f1


dollar_price_binance=$(curl -s 'https://api.binance.com/api/v3/ticker/price?symbol=ETHBTC' | jq -r .price)
echo "current price in US$: "$dollar_price_binance" BTC"

array=( 1JDW13kBD6sDZ1j3eL8na47G6WSbtESjWT
	1Hgsu5qKCYdUFAwv4aJwUqbD4iPY7Sz7or
	1HZCfNuYcePyYXmpyz4GivWcVVpAkuMiqw
	16f9S3Szbc7WCGnornud1EBnrSsAPN9kgd
	15JhaoooettTaXwTaMyCb2mebR95SeAYyo
	1F8e2Wk5DLVg2wyKmYahANTA29XDjQdf1L
	18AtrF9zeCFiUJHVMZK8NhqbfqwTMqVGNf
	1ARA1R6VoAgndZRrUtGB6NqxJ6D1fo5dWF
	1143UC7XCBMKsDCLx85jqzbbnjv3c117SU
	136yTrJ1KpGNQVpN2RmpKNFwLRyEmmxxCN
	15nFv6sL4WrHExmMeWEfHCymJydYvTXiEt
	1LdpGGpFgWkGVyzsfPXLh5PPY1Z3EFSkQ9
	1NL2ktTbkpGvGRQzqbsnjGDHM9PqU5pCAD
	16TFcq9q2aWkvKAPRsrKK9mMbLVNVjHa9b
	12HyW5Sa6gD3AbapUZcpkNaSN4r42eJSyK
	18gZ9zKQuSRgCgaqZ2v9DgGuQ78GRy2rLQ
	1CbsLtxps8BTHmmd2YTWkNKnVwseBGykC7
	19RfAvi76Nn5vWKcn9fbY1UNefmAuawv92
	1PeSekrZvdWWSVgfrKQoUFjQWYxWcnjVzb
	1F3raoU2CJm4KpHSV2seeUG1WRjY8yeTu8
	1GMmjhv2qaaLYa9Sx2Ne7sKPTo6HLD5YLm)


#balance=0

count=0
#code = 0
output ()
{
for i in ${array[@]}; do
	((count++))
	n=$(wget -qO- blockchain.info/rawaddr/$i 2>&1 | grep -Po '"final_balance":\K[0-9]+' | awk '{s=$1/100000000} END {printf "%0.8f", s}')
	echo $count " | "$i " | " $n " btc | "
done
}

echo "-----------------------------------------------------------------"
output
echo "-----------------------------------------------------------------"
echo $x
echo "number for the qr code?"
read code

if [ $code -eq 0 ]
then
        echo "exiting....."
        exit
else
        echo "generating qr code for the address: "${array[code-1]}
        #qrencode -o $i.png $i}
	qrencode -o ${array[code-1]}.png ${array[code-1]}}
        eog ${array[code-1]}.png
        rm ${array[code-1]}.png
fi

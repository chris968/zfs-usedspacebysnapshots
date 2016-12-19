#!/bin/bash

if [[ -z ${1+x} ]]; then
	echo "Please give the zfs volume/dataset as argument !"
	exit 1
fi

if [[ -z ${2+x} ]]; then
	echo "Please specify if you wan't a summary of all snapshots size or per volume/dataset and her children details"
	echo 'Specify option as "summary" or "details"'
	exit 1
fi
path=$1
if [[ "$2" == "summary" ]]; then
	sumSpace=0
	for i in $(zfs get -r -t filesystem -H -o value -p usedbysnapshots $1); do
		sumSpace=$((sumSpace+$i))  
	done
sumSpace=$((sumSpace/1000000000))
echo $sumSpace "GB are currently used by snapshots on this volume/dataset and her children"
else
	zfs get -r -t filesystem -H -o name,value usedbysnapshots $1
fi

exit 0

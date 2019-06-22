#!/bin/bash
while [ '$1' != '' ]; do
	case $1 in
		-f | --file-name )	shift
					fname=$1
					;;
		-a | --add )		shift
					echo "$1" >> $fname
					exit
					;;
		-d | --delete )		shift
					sed -i "s/${1}//g" $fname ; sed -i '/^$/d' $fname 
					exit
					;;
		-w | --where-is )	shift
					cat $fname | grep "$1"
					exit
					;;
	esac
	shift
done

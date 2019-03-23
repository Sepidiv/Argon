#!/bin/bash
# Argon, 3rd try
arHelp="Usage:\n-o\t--output\t\t\t declare output file name\n-a\t--action {inject,remove,add}\t set the action\n-h\t--help\t\t\t\t show this page and exit\n"

findPlace () {
	lineNumber="$(cat $fileName | grep $1 --line-number | sed 's/ *:.*//')"
	echo $(cat $fileName | head -n $lineNumber | sed 's/ //g' | grep --basic-regexp '^(\|^)' | sed 's/(//g') | sed 's/ /\n/g' > tmp
	sed -i "$(($(cat tmp | grep ')' --line-number | sed 's/ *:.*//') - 1))d" tmp
	sed -i 's/)//g' tmp
	sed -i '/^$/d' tmp
	echo "$(echo $(cat tmp) | sed 's/ /=>/g')=>$1"
	rm tmp
	exit
}

addSub () { #TODO complete this part. adding a sub to a class/subclass
}
while [ '$1' != '' ] ; do
	case $1 in
		-f | --file-name )		shift
					fileName=$1
					;;
		-a | --action )		shift
					action=$1
					;;
		-p | --place )		shift
					xDim=$1
					shift
					yDim=$1
					;;
		-w | --find-place )	shift
					findPlace $1
					;;
		-h | --help )		echo -ne $arHelp
					exit
					;;
	esac
	shift
done

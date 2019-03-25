#!/bin/bash
# Argon, 3rd try
arHelp="Usage:\n-f\t--file-name\t\t\t declare output file name\n-p\t--place\t\t\t\t set addres of item, used for item injection\n-h\t--help\t\t\t\t show this page and exit\n"

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

addClass () { #TODO complete this part. add class to main db. wont't be that hard
	exit
}

addItem () { #TODO complete this part. add an item to a sub. //class must not contain any item, but it wont be an exception here.
	exit
}

addSub () { #TODO complete this part. adding a sub to a class/subclass

	exit
}
while [ '$1' != '' ] ; do
	case $1 in
		-f | --file-name )	shift
					fileName=$1
					;;
		-p | --place )		shift
					itemAddres=$1
					;;
		-a | --add ) 		shift
					case $1 in
						sub )		shift
								addSub $1
								;;
						class )		shift
								addClass $1
								;;
						item )		shift
								addItem $1
								;;
					esac	
		-w | --find-place )	shift
					findPlace $1
					;;
		-h | --help )		echo -ne $arHelp
					exit
					;;
	esac
	shift
done

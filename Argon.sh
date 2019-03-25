#!/bin/bash
# Argon, 3rd try

phrase() {
	indentCount=$(echo "$1" | sed 's/.[=>]/\n/g' | grep --count '>')
}
findPlace () {
	lineNumber="$(cat $fileName | grep $1 --line-number | sed 's/ *:.*//')"
	echo $(cat $fileName | head -n $lineNumber | sed 's/\t//g' | grep --basic-regexp '^(\|^)' | sed 's/(//g') | sed 's/ /\n/g' > tmp
	sed -i "$(($(cat tmp | grep ')' --line-number | sed 's/ *:.*//') - 1))d" tmp
	sed -i 's/)//g' tmp
	sed -i '/^$/d' tmp
	echo "$(echo $(cat tmp) | sed 's/ /=>/g')=>$1"
	rm tmp
	exit
}

addClass () {
	echo -ne "($1\n)\n" >> "$fileName"
	exit
}

addItem () { #TODO complete this part. add an item to a sub. //class must not contain any item, but it wont be an exception here.
	phrase $theAddres
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
					theAddres=$1
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
					;;	
		-w | --find-place )	shift
					findPlace $1
					;;
		-h | --help )		cat help
					exit
					;;
	esac
	shift
done

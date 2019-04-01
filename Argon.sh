#!/bin/bash
# Argon, 3rd try
# this code is self Documented!
phrase() { # almost #DONE
	lastPart=$(echo $1 | sed 's/=>/\n/g' | tail -n 1)
	indentCount=$(cat $fileName | grep $lastPart | sed 's/\t/\n/g' | wc -l)
	echo $1 | sed 's/=>/\n/g' > ptmp
	sed -i '$d' ptmp
	arrOfOthers=$(cat ptmp)
	rm ptmp
}
findPlace () { #DONE
	lineNumber="$(cat $fileName | grep $1 --line-number | sed 's/ *:.*//')"
	arrOth=$(echo $(cat $fileName | head -n $lineNumber | sed 's/\t//g') | sed 's/ (.*)\|\[.*\]//g' | sed 's/ /\n/g'| sed "/(\|\[/! s/.*//g" | sed '/^$/d')
	echo $(echo "$arrOth $1") | sed 's/\n/ /g' |sed 's/(\|\[//g' | sed "s/ /=>/g" 
	exit
}
addClass () { #DONE
	echo -ne "[$1\n]\n" >> "$fileName"
	exit
}
addItem () { #DONE //class must not contain any item directly, but it won't be an exception here.
	phrase $theAddres
	if [ $(for i in $arrOfOthers; do grep $fileName -e $i ; done | wc -l) = $(echo $arrOfOthers | sed 's/ /\n/g' | wc -l) ]; then
		echo -n "\\" > itmp
		echo "$(for i in $arrOfOthers; do echo -n "\t"; done)$1" >> itmp;
		lineNumber=$(($(cat $fileName | grep -e $(echo $arrOfOthers | tr " " "\n" | tail -n 1) --line-number | sed 's/ *:.*//') + 1))
		sed -i "${lineNumber}i$(cat itmp)" $fileName
		rm itmp
	else
		echo "noo"
	fi
	exit
}
addSub () { #DONE
	phrase $theAddres
	if [ $(for i in $arrOfOthers; do grep $fileName -e $i ; done | wc -l) = $(echo $arrOfOthers | sed 's/ /\n/g' | wc -l) ]; then
		echo -n "\\" > itmp
		echo -n "$(for i in $arrOfOthers; do echo -n "\t"; done)\($1" >> itmp;
		echo -n '\n' >> itmp;
		echo -n "$(for i in $arrOfOthers; do echo -n "\t"; done)\)" >> itmp;
		lineNumber=$(($(cat $fileName | grep -e $(echo $arrOfOthers | tr " " "\n" | tail -n 1) --line-number | sed 's/ *:.*//') + 1))
		sed -i "${lineNumber}i$(cat itmp)" $fileName
		rm itmp
	else
		echo "noo"
	fi
	exit
	exit
}
removeClass () { #DONE
	 sed -i "/^\[$1/,/^\]/d" $fileName
	 exit
}
removeSub () { #DONE
	for i in $(seq 1 $(grep "($1" "$fileName" | awk '{print gsub(/\t/,"")}')); do
		indCount="${indCount}\t";
	done
	sed -i "/^${indCount}($1/,/^${indCount})/d" $fileName
	exit
}
removeItem () { #DONE
	 sed -i "/$1/d" $fileName
	 exit
}
if [ "$1" = '' ]; then
	echo "try using -h or --help"
	exit
fi

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
		-r | --remove )		shift
							case $1 in
								sub )		shift
											removeSub $1
											;;
								class )		shift
											removeClass $1
											;;
								item )		shift
											removeItem $1
											;;
							esac
							;;
		-h | --help )				$(cat ~/.SepiDiv)help
							exit
							;;
	esac
	shift
done

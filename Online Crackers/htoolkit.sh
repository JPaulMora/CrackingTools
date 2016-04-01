#Send request:

function RequestHash {
	URL='http://hashtoolkit.com/reverse-hash?hash='
	HASH="$1"
	PAYLOAD="$URL$HASH"
	echo $PAYLOAD
#	LINE=146
#	OUTP=$(curl $PAYLOAD | sed -n "${LINE}{p;q;}" | cut -d '>' -f2 | cut -d '<' -f1)
	A=$(curl $PAYLOAD)
	OUTP=$(echo $A  | grep '<span title="decrypted md5 hash">' | cut -d '>' -f2 | cut -d '<' -f1)
	if [ ! -z "$OUTP" ] && [ ${#HASH} == 32 ]
	then
		echo '$dynamic_0$'$HASH:$OUTP >> hos.pot
		echo $OUTP
	fi
}

function SearchHash {
	FOUND=0
	if [ -s "$(pwd)/hos.pot" ] # IF POT FILE EXISTS..
	then
		END=$(grep : hos.pot -c)
		#echo $END
		for (( l=1; l<=$END; l++ ))   # FOR ITEM IN POT FILE
		do
		HASH=$(sed -n "${l}{p;q;}" hos.pot | cut -d : -f1 | cut -d '$' -f3)
			if [ "$HASH" == "$1" ]     # IF HASH IS EQUAL TO FOUND, EXIT
				then
				FOUND=1
				sed -n "${l}{p;q;}" hos.pot | cut -d : -f2
				break
			fi # ELSE WE HAVENT FOUND IT, GOTO NEXT LINE
		done
		if [ "$FOUND" == 0 ]
			then
			RequestHash $1
		fi
	else
		RequestHash $1
	fi
}
if [[ -z $1 ]]
then
	echo Missing arguments
	exit 0
else
	SearchHash $1
fi



function RequestHash {
	sleep 2
	URL="http://md5.gromweb.com/query/"
	HASH="$1"
	PAYLOAD="$URL$HASH"
	ERR="You made too many queries. Please wait 5 minutes before running a new request."
	TO=0
	#Send request:
	OUTP=$(curl $PAYLOAD)
	if [ "$OUTP" == "$ERR" ]
		then
		TO=1
		echo Waiting..
		sleep 301
		break
	fi
	if [ ! -z "$OUTP" ] && [ $TO == 0 ]
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

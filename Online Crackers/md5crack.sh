

function RequestHash {
	API="" #Your API key here
	GOOD="6"
	URL="http://api.md5crack.com/crack/$API/"
	HASH="$1"
	PAYLOAD="$URL$HASH"
	sleep 2
	#Send request:
	OUTP=$(curl $PAYLOAD)
	CODE=$(echo $OUTP | cut -d : -f5 | sed 's/}//')
	RES=$(echo $OUTP | cut -d : -f2 |  cut -d \" -f2)

	if [ "$CODE" -eq 3 ]
	then
		echo "Quota done"
	fi
	if [ "$CODE" -eq "$GOOD" ] && [ $RES != "parsed" ]
	then
		echo '$dynamic_0$'$HASH:$RES >> hos.pot
		echo $RES
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

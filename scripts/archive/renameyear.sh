#!/bin/bash

pwd

read -p "Licence number?" licenceno
cd /Users/cynthiiee/Dropbox/FCC/Microfiche/Batch_$batchno/$licenceno

function renameyearecho {
#	mt=00
	case $2 in
		"JAN"* | 1 | 01 ) mt=01;;
		"FEB"* | 2 | 02 ) mt=02;;
		"MAR"* | 3 | 03 ) mt=03;;
		"APR"* | 4 | 04 ) mt=04;;
		"MAY"* | 5 | 05 ) mt=05;;
		"JUN"* | 6 | 06 ) mt=06;;
		"JUL"* | 7 | 07 ) mt=07;;		
		"AUG"* | 8 | 08 ) mt=08;;		
		"SEP"* | 9 | 09 ) mt=09;;		
		"OCT"* | 10 ) mt=10 ;;		
		"NOV"* | 11 ) mt=11;;		
		"DEC"* | 12 ) mt=12;;	 	
	esac
	
# 	case $3 in
# 		[0-9] ) y=$3;;
# 		"T" ) 
# 		read -p "year (---y)?" y;
# 		mt=$mt-AMENDMENT
# 		;;
# 	esac
	
	case $3 in
		[0-9] ) 
			y=$3;;
		"T" ) 
			y=$4;
			mt=$mt-AMENDMENT;;
	esac	
	
	echo mv $2*$3 $1-199$y-$mt

}
	
function renamefolmthyr {
#	mt=00
	case $2 in
		"JAN"* | 1 | 01 ) mt=01;;
		"FEB"* | 2 | 02 ) mt=02;;
		"MAR"* | 3 | 03 ) mt=03;;
		"APR"* | 4 | 04 ) mt=04;;
		"MAY"* | 5 | 05 ) mt=05;;
		"JUN"* | 6 | 06 ) mt=06;;
		"JUL"* | 7 | 07 ) mt=07;;		
		"AUG"* | 8 | 08 ) mt=08;;		
		"SEP"* | 9 | 09 ) mt=09;;		
		"OCT"* | 10 ) mt=10 ;;		
		"NOV"* | 11 ) mt=11;;		
		"DEC"* | 12 ) mt=12;;		
	esac
	
	case $4 in
		"AT" ) 
			endfolname='NT';
			mt=$mt-AMENDMENT;;
		* ) 
			endfolname=$3;;
	esac	
	
	mv $2*$endfolname $1-199$3-$mt
	
}

echo 'renamefolmthyr($licenceno,$mth(mmm),$year(---y),$(AT))'


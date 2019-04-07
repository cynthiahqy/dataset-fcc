#!/bin/bash
# 
# Structure of file
#
# -re loads re-org functions
#   - mvlater(folder)
#   - mvfol(licence,MMM,yyyy):mv to $mwork
#   - Lmvfol():loops current folder
#   - mvv(folder, target):mv with log to $sesslog
#   - Lnumber(folder): renumber all ([1-9]) to (0[1-]) in given folder & sub folders using find

# 1. Set locations
# This includes FCC, microfiche, scripts, docs, xls, progress

# using the relative path (in the same folder) using the dot (.) operator
. ./fcc-locations.sh

# 2. Load functions and scripts
#   - scripts contain prompts (``startSess, imgpro, dataE, endSess, mvlater)
#   - functions set global variables, run loops, and group commands
#        entryO(yyyy,mm,licence)
#        [*.jpg].nameorder.sh
#        [*.jpg].grapcrop()
#        unsplit(img1,img2)
#        [*.jpg].finalrename()
#        checkD()
#        [*.jpg].Lfindrepjpg(find,rep)
#        ocr(img,doctype)
#        entryC()

# Load functions and script paths

# Begin session

### Timestamp session
while true; 
do
    read -p "Date stamp session? " yn
    case $yn in
        [Yy]* ) echo >> $progress;
                echo "START $(date)" >> $progress; 
		break;;
        [Nn]* ) break;;
        * ) echo $pleaseyn;;
    esac
done

### read last position
while true;
do
    read -p "read last position? " yn
    case $yn in
	    [Yy]* ) tail $progress; break;;
	    [Nn]* ) break;;
	    *     ) echo $pleaseyn;;
    esac
done 

#`` startSess="$scripts/sessionStart.sh"
#`` . $startSess

### Open excel files in spreadsheets/
while true; 
do
    read -p "Open Excel files? " yn
    case $yn in
        [Yy]* ) for f in $xls/*.xls*;
                  do
                      open "$f";
                  done 
                break;;
        [Nn]* ) break;;
        *     ) echo $pleaseyn;;
    esac
done

# sorting, moving

## Moving folders btwn Microfiche

function cdl {
     lic=$(ls -1 | head -1)
     cd $lic
     pwd
     ls -1
}

#function Lwhitespace {
#	for f in *; do mv "$f" ${f//\ /-}; done
#}

function cdrm {
     local cwd=$(pwd)
     cd .. && rmdir $cwd
     lic=''
}


# function mvv
function mvv { 
mv -v "$1" $2 >> $clean;
	tail -1 $clean;
}

function mvlater { 
     mv -v "$1" $mlater/$2 >> $clean;
     tail -n 1 $clean;
     local issue;
     read -p "What's wrong with this folder? " issue;
     echo "$(tail -n 1 $clean): $issue" >> $laterlog;
     tail -n 1 $laterlog;
}


# function mvfol () renamed to mvwork
function mvwork {
     local lic=$1
     local mt='xx'
	case $2 in
		"JAN"* | 1 | 01 ) mt='01';;
		"FEB"* | 2 | 02 ) mt='02';;
		"MAR"* | 3 | 03 ) mt='03';;
		"APR"* | 4 | 04 ) mt='04';;
		"MAY"* | 5 | 05 ) mt='05';;
		"JUN"* | 6 | 06 ) mt='06';;
		"JUL"* | 7 | 07 ) mt='07';;		
		"AUG"* | 8 | 08 ) mt='08';;		
		"SEP"* | 9 | 09 ) mt='09';;		
		"OCT"* | 10     ) mt='10';;		
		"NOV"* | 11     ) mt='11';;		
		"DEC"* | 12     ) mt='12';;		
	esac
     local year=$3
     local folder="$2*$year"

     mv -v $(pwd)/$folder $mwork/$year-$mt-$lic-00 >> $clean
     tail -n 1 $clean
}

# function Lmvfol renamed to Lmvwork
function Lmvwork { 
    if [ ${#lic} != 7 ]
    then
	    echo 'Change lic=(7 characters)!'
    else 
     for f in *;
     do
          mvwork $lic $f;
     done
    fi
}

# file-name processing, remove whitespace, renumbering

### renumber $mwork
#`` nameorder="$scripts/renumberfol.sh"

function Rwhitespace { 
echo "for d in *; do cd $mwork/$d; echo $(pwd); rename -v "s/ *//g" *.jpg; done" 
}

function Lnumber {
    for f in $(find $1 -name "*([1-9]).jpg");  
    do
	    mv -v $f ${f//\(/\(0} >> $clean;
            tail -1 $clean;
    done
}

function switchFolderNames {
     if [ ${#1} != 18 ]
     then
	     echo "Folder name: $1 longer than 18 characters"
     else 
	     folName=$1 
	     callSign=${folName##*-} 
	     folNo=${folName%-*}
	     folDate=${folNo%-*}
	     folNote=${folNo##*-}
	     newFolName=${folDate}-${callSign}-${folNote}
	     mv -v $folName $newFolName >> $clean;
	     tail -n 1 $clean;
     fi
}

function renameK1 {
    local fol=$1
    for img in $(find $fol -name "*.jpg");
    do
        mv -v $img $fol/$fol-0${img##*-} >> $clean;
        tail -n 1 $clean;
    done
} 

function TrenameK2 {
    local fol=$1
    for img in $(find $fol -name "*.jpg");
    do
        local imgNo=${img##*-}
        if [ ${#imgNo} -eq 6 ]
        then
            echo $fol/$fol-0${img##*-}
        #else
         #   echo $img $fol/$fol-${img##*-}
        fi
    done
}

function renameK2 {
    local fol=$1
    for img in $(find $fol -name "*.jpg");
    do
        local imgNo=${img##*-}
        if [ ${#imgNo} -eq 6 ]
        then
            mv -v $img $fol/$fol-0${img##*-} >> $clean;
            tail -n 1 $clean;
        fi
    done
}

function renameK3 {
    renameK2 $1
}
## Initial imageProcessing
#``imgpro="$scripts/imageProcessing.sh"

function graycrop {
	convert -colorspace Gray -crop 50%x100% +repage "$1" "$1";
	rm -v "$1" >> $clean;
	tail -1 $clean;
}

function Lfnlname {
     local i=1
     local fol=$1
     for f in "$fol"/*.jpg;
     do
	  if [ $i -lt 10 ]
	  then
      		mv -v "$f" "$fol/${fol##*/}-00$i.jpg" >> $clean;
	  elif [ $i -lt 100 ]
	  then 
		mv -v "$f" "$fol/${fol##*/}-0$i.jpg" >> $clean;
	  else
      		mv -v "$f" "$fol/${fol##*/}-$i.jpg" >> $clean;
     	  fi
	  tail -1 $clean
          let i=i+1
     done
}

## imageCorrections
function cdi {
	fol=$(ls -1|head -1);
	cd $fol;
	echo "CHECKSPLIT: $(pwd)" >> $clean;
	open *.jpg;
	echo "rmi(imgno,[0/1]), unsplit(imgno.), mvv(mistake,correction), Lfnlname(), cdmvi()";
}

function rmi {
	rm -v $(find $(pwd) -name "*($1)-$2.jpg") >> $clean;
	tail -1 $clean
}

function unsplit {
local img0=$(ls *\($1\)-0.jpg);
local img1=$(ls *\($1\)-1.jpg);
	convert $img0 $img1 +append ${img0/-0/};
	rm -v $img0 $img1;
	echo "unsplit ${img0/-0/}" >> $clean;
	tail -1 $clean;
}

function cdmvi {
        cd ..;
	mv -v $(pwd)/$fol $menter/ >> $clean;  
	tail -1 $clean;  
	fol='';
}

# enterData and entryClose

## entryOpen

function cde {
	fol=$(ls -1|head -1);
	cd $fol;
	open *.jpg;
	echo $fol;
	ls -1
	echo "imgmetadata.xls, licenseEvents.xls, cdmve()" 
}

function rme {
	rm -v $(find $(pwd) -name "*$1.jpg") >> $clean;
	tail -1 $clean
}

function mkdirM {
    mkdir -v $1 >> $clean;
    tail -1 $clean
}

function cdmve {
        cd ..;
	mv -v $(pwd)/$fol $mdone/ >> $clean;
	tail -1 $clean;
	fol='';
}

function ocr {
     tesseract "$1" "${1/.jpg/-$2}";
     vim "{1/.jpg/-$2}.txt"
}

#`` dataE="$scripts/dataEntry.sh"



## sessionEnd

# endSess="$scripts/sessionEnd.sh"

# graycrop ()  {      convert -colorspace Gray -crop 50%x100% +repage  ;     rm -v  >> ; }
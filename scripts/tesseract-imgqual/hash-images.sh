#!/bin/bash

# Set Locations

if [ -z $FCC ]
then
    . ~/Dropbox/UoM/FCC/Working/scripts/cynthia/fcc-locations.sh
else
    echo "locations already set to $microfiche, $work"
fi

cksumtxt=$scripts/cynthia/img-management/make-hashtables/cksum
jpgs4hash=$scripts/cynthia/img-management/make-hashtables/find_jpg

# 1. Find Images

function listjpgs {
    local folder=$1
    local outjpglist="$jpgs4hash/${folder##*/}.txt"
    find -d $folder -name *.jpg | sort > $outjpglist
    jpglist=$outjpglist
}

# $1 is the path to folder e.g. /Volumes/Seagate/microfiche/FCC-backups/K2/K2-03-grayCrop

# 2. Calculate cksum CRC values

function cksumjpglist {
    local jpglist=$1
    local outcksum="$cksumtxt/cksum_${jpglist##*/}"
    cat $jpglist | xargs -I {} cksum {} > $outcksum
    echo "cksum CRC of jpgs listed in ${jpglist##*/} are listed in $outcksum"
}

## combine step 1 & 2
function mfiche2cksum {
    local folder=$1
    listjpgs $folder
    echo "jpgs in ${folder##*/} are listed in ${jpglist##*/}"
    cksumjpglist $jpglist
}

## loop mfiche for path list of folders
function folderlist2cksum {
    local folderlist=$1
    for folder in $(cat $folderlist | xargs);
        do echo $folder;
        mfiche2cksum $folder;
    done
}

## DRAFTS

K1to5='K1 K2 K3 K4 K5'

for K in $K1to5;
    do cd ${!K} #use indirect parameter expansion
    echo ${!K}
    done;




#!/bin/bash

echo '$targetpath/*.jpg'

read targetpath

#ls $targetpath/*.jpg

cp $targetpath $targetpath/copy

read -p "Press enter to continue"

function renamepart {
    for f in $targetpath/*.jpg; do mv "$f" "${f/$1/$2}"; done
}

renamepart '(' '(0'

renamepart '(01' '(1'

renamepart '(1)' '(01)'

renamepart '(02' '(2'

renamepart '(2)' '(02)'

renamepart ' ' ''

ls $targetpath/*.jpg

while true; do
    read -p "Is there a gap?" yn
    case $yn in
        [Yy]* ) renamepart ' ' ''; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
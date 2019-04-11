#!bin/bash
#
# graycrop()
# unsplit(img1,img2)
# renum()

while true; 
do
    read -p "split and grayscale all files in $(pwd)?" yn
    case $yn in
        [Yy]* ) graycrop | less; break;;
        [Nn]* ) break;;
        *     ) echo "Please enter yes or no.";;
    esac
done

open *.jpg;
echo "use unsplit(img1,img2) if necessary."

while true; 
do
    read -p "renumber all files in $(pwd) to $yyyy-$mm-$licence?" yn
    case $yn in
        [Yy]* ) renum | less; break;;
        [Nn]* ) break;;
        *     ) echo "Please enter yes or no.";;
    esac
done


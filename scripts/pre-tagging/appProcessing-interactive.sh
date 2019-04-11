#!/bin/bash

# set observation variables
read -p "Licence number?" licenceno
read -p "Year?" yyyy
read -p "Month?" mm

# grayscale & crop
mkdir original
for f in *.jpg; 
do
	convert -colorspace Gray -crop 50%x100% +repage "$f" "$f";
	mv -v "$f" original/;
done

# rename
i=1
for f in *.jpg;
do
if [[ $i -lt 10 ]]; then
	mv -v "$f" "$yyyy-$mm-$licenceno-0$i.jpg";
else
	mv -v "$f" "$yyyy-$mm-$licenceno-$i.jpg";
fi
	let i=i+1;
done

let i=1

# for f in *.jpg; do     mv -v "$f" "1991-09-KNKN933-$i.jpg";     let i=i+1; done; let i=1	

#!/bin/bash

dir=$1
dest=$2
toMoveList=$3

while read line; do
   find "$dir" -name "$line" -exec mv '{}' $dest \; #-print "%f\n"     
done < "$toMoveList" #> cpList

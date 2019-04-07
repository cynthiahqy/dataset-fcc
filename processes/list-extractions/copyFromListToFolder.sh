#!/bin/bash

dir=$1
dest=$2
toCopyList=$3

while read line; do
   find "$dir" -name "$line" -exec cp '{}' $dest \; #-print "%f\n"     
done < "$toCopyList" #> cpList


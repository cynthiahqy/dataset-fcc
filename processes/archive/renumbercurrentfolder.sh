#!/bin/bash

findreplacejpg '(' '(0'

for i in {1..6}; do

findreplacejpg "(0$i" "($i" &&

findreplacejpg "($i)" "(0$i)";

done

findreplacejpg ' ' ''


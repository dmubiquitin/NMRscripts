#!/bin/bash

# In the following, replace "seq $$ $$" by the number of measurements taken.
# Replace the sample name. 

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Extracting height
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cat 1.tab | awk ' NR >= 15 {print $10}' >> int.txt

for i in `seq 2 15`;

do

echo ... Extracting to $i ...

cat $i.tab | awk ' NR >= 15 {print $10}' >> $i.txt
paste int.txt $i.txt >> int-temp.txt
mv int-temp.txt int.txt
rm $i.txt

done

clear

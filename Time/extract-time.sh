#!/bin/bash

# This script will extract the measurement time of each (zg or multizg) NMR experiment
# and write these data to exptime.txt
# exptime.txt can then be viewed in excel to find [t] 

rm exptime.txt
rm starttime.txt

for ((i=11; i<31 ;i=i+1))
do
grep 1, ../$i/audita.txt >> ./sampletime.txt
grep nmr@ ../$i/scon2 >> ./first.txt
done
awk '{print $3}' sampletime.txt >> exptime.txt
awk '{print $3}' first.txt >> starttime.txt
rm sampletime.txt
rm first.txt

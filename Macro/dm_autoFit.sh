#!/bin/bash

# In the following, replace "seq $$ $$" by the number of measurements taken.
# Replace the sample name. 

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Calculating height and width
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


for i in `seq 1 15`;

do

echo ... Copying to $i ...

cp ./$i.ft2 ./test.ft2

autoFit.tcl

mv ./nlin.tab ./nlin/$i.tab

rm ./axt.tab
rm ./dif.ft1
rm ./test.ft2
rm ./sim.ft1
rm ./autoFit.com

done

clear

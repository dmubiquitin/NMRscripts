#!/bin/bash

# 
# Fill in number of measurements taken and the sample name.
#
# by do-eri-zou
# modified by morimoto



# In the following, replace "seq $$ $$" by the number of measurements taken.
# Replace the sample name. 

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Fitting with using NMRPipe
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


for i in `seq 0 3`;

do

rm test.ft2
rm test.tab

echo ... Copying to $i ...

cp ./FKBP12_$i.ft2 ./test.ft2
cp ./FKBP12.tab ./test.tab

echo ... Fitting of $i ...

autoFit.tcl

mv ./nlin.tab ./nlinFKBP12_$i.tab

rm test.ft2
rm test.tab
rm axt.tab
rm autoFit.com
rm dif.ft2
rm pk.tcl
rm sim.ft2

done

clear

#!/bin/bash
# In the following, replace "seq $$ $$" by the number of measurements taken.
# Replace the sample name. 

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Executing ft_r2.com
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


addNMR -in1 ./310.ft2 -in2 ./311.ft2 -out ./add.ft2

for i in `seq 312 330`;

do

echo ... Adding $i ...

addNMR -in1 ./$i.ft2 -in2 ./add.ft2 -out ./add.ft2

done

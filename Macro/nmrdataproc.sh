#!/bin/bash

# 
# Fill in number of measurements taken and the sample name.
#
# by do-eri-zou
# modified by morimoto



# In the following, replace "seq $$ $$" by the number of measurements taken.
# Replace the sample name. 

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Executing ft_r2.com
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


for i in `seq 0 3`;

do

echo ... Copying to $i ...

cp ../../Raw_New/UbssFKBP12/Rawdata/1010$i/ser ./ser

chmod u+rwx ./ft_r2.com

ft_r2.com

cp ./xy.nv ../spectrum/UbssFKBP12_$i.nv

rm ./xy.*
rm ./ser

done

clear

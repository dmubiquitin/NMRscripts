#!/bin/bash

# 
# Fill in number of measurements taken and the sample name.
#
# by do-eri-zou
# modified by morimoto



# In the following, replace "seq $$ $$" by the number of measurements taken. 

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Testing
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


for i in `seq 0`;

do

echo ... Copying to $i ...

cp ../../Raw_New/UbssFKBP12/Rawdata/1010$i/ser ./ser

ft_r2.com

done

clear

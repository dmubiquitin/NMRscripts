#!/bin/bash

# 
# Fill in number of measurements taken and the sample name.
#
# by do-eri-zou
# modified by morimoto



# In the following, replace "seq $$ $$" by the number of measurements taken.
# Replace the sample name. 

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Fitting with using NMRPipe: Non-Ubiquitylated
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


rm test.ft2
rm test.tab

echo ... Copying to ft2 and tab file ...

cp ./FKBP12.ft2 ./test.ft2
cp ./FKBP12.tab ./test.tab

echo ... Fitting ...

autoFit.tcl

mv ./nlin.tab ./nlin_FKBP12.tab

rm test.ft2
rm test.tab
rm axt.tab
rm autoFit.com
rm dif.ft2
rm pk.tcl
rm sim.ft2

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Fitting with using NMRPipe: Ubiquitylated
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


echo ... Copying to ft2 and tab file ...

cp ./UbssFKBP12.ft2 ./test.ft2
cp ./UbssFKBP12.tab ./test.tab

echo ... Fitting ...

autoFit.tcl

mv ./nlin.tab ./nlin_UbssFKBP12.tab

rm test.ft2
rm test.tab
rm axt.tab
rm autoFit.com
rm dif.ft2
rm pk.tcl
rm sim.ft2

clear

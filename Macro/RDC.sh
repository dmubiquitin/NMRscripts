#!/bin/csh

#Insert your sample name
setenv NAME 7

#Grep -Do NOT Change Below-
rm ./residue.txt
rm ./rdc.txt
rm ./error.txt
rm ./RRDC.txt
rm ./rdc_calc.txt
rm ./error_calc.txt
rm ./Measured.txt
rm ./Measured2.txt
rm ./RDC_${NAME}.txt
cat ./${NAME}.redcat | awk '{print $13}' >> ./residue.txt
cat ./${NAME}.redcat | awk '{print $7}' >> ./rdc.txt
cat ./${NAME}.redcat | awk '{print $9}' >> ./error.txt
cat ./${NAME}_calc.redcat | awk '{print $7}' >> ./rdc_calc.txt
cat ./${NAME}_calc.redcat | awk '{print $9}' >> ./error_calc.txt
paste ./Residue.txt ./RDC.txt >> ./RRDC.txt
paste ./RRDC.txt ./Error.txt >> ./Measured.txt
paste ./Measured.txt ./rdc_calc.txt >> ./Measured2.txt
paste ./Measured2.txt ./error_calc.txt >> ./RDC_${NAME}.txt
rm ./residue.txt
rm ./rdc.txt
rm ./error.txt
rm ./RRDC.txt
rm ./rdc_calc.txt
rm ./error_calc.txt
rm ./Measured.txt
rm ./Measured2.txt

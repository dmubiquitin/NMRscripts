#!/bin/csh

#Insert your sample name
setenv NAME FABP4

#Grep -Do NOT Change Below-
rm ./SET.txt
rm ./X2.txt
grep -e SET ./glove.out >> ./SET.txt
grep -e "	X2/DoF" ./glove.out >> ./X2.txt
cat ./SET.txt | awk '{print $2}' >> ./Residue.txt
cat ./X2.txt | awk '{print $2}' >> ./Delta.txt
paste ./Residue.txt ./Delta.txt >> ./X2_${NAME}.txt
rm ./SET.txt
rm ./X2.txt
rm ./Residue.txt
rm ./Delta.txt

#!/bin/csh

#Insert your sample name
setenv NAME FABP4

#Grep -Do NOT Change Below-
rm ./SET.txt
rm ./REX.txt
grep -e SET ./glove.out >> ./SET.txt
grep -e REX ./glove.out >> ./REX.txt
cat ./SET.txt | awk '{print $2}' >> ./Residue.txt
cat ./REX.txt | awk '{print $2}' >> ./Delta.txt
paste ./Residue.txt ./Delta.txt >> ./REX_${NAME}.txt
rm ./SET.txt
rm ./REX.txt
rm ./Residue.txt
rm ./Delta.txt

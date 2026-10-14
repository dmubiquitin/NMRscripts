#!/bin/csh

#Insert your sample name
setenv NAME FABP4

#Grep -Do NOT Change Below-
rm ./SET.txt
rm ./KEX.txt
grep -e SET ./glove.out >> ./SET.txt
grep -e KEX ./glove.out >> ./KEX.txt
cat ./SET.txt | awk '{print $2}' >> ./Residue.txt
cat ./KEX.txt | awk '{print $2}' >> ./Delta.txt
paste ./Residue.txt ./Delta.txt >> ./KEX_${NAME}.txt
rm ./SET.txt
rm ./KEX.txt
rm ./Residue.txt
rm ./Delta.txt

#!/bin/csh

#Insert your sample name
setenv NAME FABP4

#Grep -Do NOT Change Below-
rm ./SET.txt
rm ./PAPB.txt
grep -e SET ./glove.out >> ./SET.txt
grep -e PAPB ./glove.out >> ./PAPB.txt
cat ./SET.txt | awk '{print $2}' >> ./Residue.txt
cat ./PAPB.txt | awk '{print $2}' >> ./Delta.txt
paste ./Residue.txt ./Delta.txt >> ./PAPB_${NAME}.txt
rm ./SET.txt
rm ./PAPB.txt
rm ./Residue.txt
rm ./Delta.txt

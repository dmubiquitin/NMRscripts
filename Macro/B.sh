#!/bin/csh

#Insert your sample name
setenv NAME EXP3

#Grep -Do NOT Change Below-
rm ./SET.txt
rm ./B.txt
rm ./B_${NAME}.txt
grep -e SET ./glove.out >> ./SET.txt
grep -e 'B	' ./glove.out >> ./B.txt
cat ./SET.txt | awk '{print $2}' >> ./Residue.txt
cat ./B.txt | awk '{print $2}' >> ./Delta.txt
paste ./Residue.txt ./Delta.txt >> ./B_${NAME}.txt
rm ./SET.txt
rm ./B.txt
rm ./Residue.txt
rm ./Delta.txt

#!/bin/csh

#Insert your sample name
setenv NAME T2

#Grep -Do NOT Change Below-
rm ./SET.txt
rm ./B.txt
rm ./B_${NAME}.txt
rm ./B_error_${NAME}.txt
grep -e SET ./glove.out-monte-final.out >> ./SET.txt
grep -e 'B	' ./glove.out-monte-final.out >> ./B.txt
cat ./SET.txt | awk '{print $2}' >> ./Residue.txt
cat ./B.txt | awk '{print $2}' >> ./Delta1.txt
cat ./B.txt | awk '{print $3}' >> ./Delta2.txt
paste ./Residue.txt ./Delta1.txt >> ./B_${NAME}.txt
paste ./B_${NAME}.txt ./Delta2.txt >> ./B_error_${NAME}.txt
rm ./SET.txt
rm ./B.txt
rm ./Residue.txt
rm ./Delta1.txt
rm ./Delta2.txt

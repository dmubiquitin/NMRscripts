#!/bin/csh

#Insert your sample name
setenv NAME Asyn

#Grep -Do NOT Change Below-
rm ./SET.txt
rm ./l.txt
rm ./k.txt
rm ./Residue.txt
rm ./Delta?.txt
rm ./temp?.txt
grep -e SET ./glove.out.out >> ./SET.txt
grep -e 'LAMBDA	' ./glove.out.out >> ./l.txt
grep -e 'KAPPA	' ./glove.out.out >> ./k.txt
#grep -e 'LAMBDA	' ./glove.out-monte-final.out >> ./l.txt
#grep -e 'KAPPA	' ./glove.out-monte-final.out >> ./k.txt
cat ./SET.txt | awk '{print $2}' >> ./Residue.txt
cat ./l.txt | awk '{print $2}' >> ./Delta1.txt
cat ./l.txt | awk '{print $3}' >> ./Delta2.txt
cat ./k.txt | awk '{print $2}' >> ./Delta3.txt
cat ./k.txt | awk '{print $3}' >> ./Delta4.txt
paste ./Residue.txt ./Delta1.txt >> ./temp1.txt
paste ./temp1.txt ./Delta2.txt >> ./temp2.txt
paste ./temp2.txt ./Delta3.txt >> ./temp3.txt
paste ./temp3.txt ./Delta4.txt >> ./Lambda-Kappa.txt
rm ./SET.txt
rm ./l.txt
rm ./k.txt
rm ./Residue.txt
rm ./Delta?.txt
rm ./temp?.txt

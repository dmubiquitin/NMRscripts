#!/bin/bash
rm ./*_H.txt ./*_N.txt ./Residue?.txt ./H.txt ./N.txt

for i in 31
do
cat ./$i.txt | awk '{print $5}' >> ./ResidueH.txt
cat ./$i.txt | awk '{print $5}' >> ./ResidueN.txt
cat ./$i.txt | awk '{print $3}' >> ./H.txt
cat ./$i.txt | awk '{print $4}' >> ./N.txt
paste ./ResidueH.txt ./H.txt >> ./$((i+2))_H.txt
paste ./ResidueN.txt ./N.txt >> ./$((i+2))_N.txt
rm ./ResidueH.txt ./ResidueN.txt ./H.txt ./N.txt
done

for ((i=33; i<52 ;i=i+2))
do
cat ./$i.txt | awk '{print $3}' >> ./H.txt
cat ./$i.txt | awk '{print $4}' >> ./N.txt
paste ./$((i))_H.txt ./H.txt >> ./$((i+2))_H.txt
paste ./$((i))_N.txt ./N.txt >> ./$((i+2))_N.txt
rm ./H.txt ./N.txt ./$((i))_H.txt ./$((i))_N.txt
done
clear

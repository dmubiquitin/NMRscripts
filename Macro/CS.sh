#!/bin/bash
rm ./Residue.txt
rm ./Residue-H.txt
rm ./H.txt
rm ./N.txt
for ((i=61; i<82 ;i=i+2))
do
cat ./$i.txt | awk '{print $6}' >> ./Residue.txt
cat ./$i.txt | awk '{print $3}' >> ./H.txt
cat ./$i.txt | awk '{print $4}' >> ./N.txt
paste ./Residue.txt ./H.txt >> ./Residue-H.txt
paste ./Residue-H.txt ./N.txt >> ./CS_$i.txt
rm ./Residue.txt
rm ./Residue-H.txt
rm ./H.txt
rm ./N.txt
done

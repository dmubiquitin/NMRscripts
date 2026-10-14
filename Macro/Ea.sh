#!/bin/sh

#Grep 

#!!!!!!Change the following directory name !!!!!!

cd ./310K


#!!!!!!No need to change the following parameters !!!!!!
rm ../rawresidue.txt
rm ../raw.txt
rm ../Residue.txt
rm ../T1.txt
rm ../k.txt
rm ./Table.txt
grep SET ./Analysis/glove/glove.out >> ../rawresidue.txt
grep B ./Analysis/glove/glove.out >> ../raw.txt
cat ../rawresidue.txt | awk '{print $2}' >> ../Residue.txt
cat ../raw.txt | awk 'NR >= 2 {print $2, $3}' >> ../k.txt
paste ../Residue.txt ../k.txt >> ./Table.txt
rm ../rawresidue.txt
rm ../raw.txt
rm ../Residue.txt
rm ../k.txt

#!/bin/sh

#Grep 

#!!!!!!Change the following directory name !!!!!!

cd ./UbssFABP4


#!!!!!!No need to change the following parameters !!!!!!
rm ../rawresidue1.txt
rm ../rawresidue2.txt
rm ../rawt1.txt
rm ../rawt2.txt
rm ../Residue1.txt
rm ../Residue2.txt
rm ../T1.txt
rm ../T2.txt
rm ../1.txt
rm ../2.txt
rm ./Relaxation.txt
grep SET ./T1/glove/glove.out >> ../rawresidue1.txt
grep SET ./T2/glove/glove.out >> ../rawresidue2.txt
grep B ./T1/glove/glove.out >> ../rawt1.txt
grep B ./T2/glove/glove.out >> ../rawt2.txt
cat ../rawresidue1.txt | awk '{print $2}' >> ../Residue1.txt
cat ../rawresidue2.txt | awk '{print $2}' >> ../Residue2.txt
cat ../rawt1.txt | awk 'NR >= 2 {print $2, $3}' >> ../T1.txt
cat ../rawt2.txt | awk 'NR >= 2 {print $2, $3}' >> ../T2.txt
paste ../Residue1.txt ../T1.txt >> ../1.txt
paste ../Residue2.txt ../T2.txt >> ../2.txt
paste ../1.txt ../2.txt >> ./Relaxation.txt
rm ../rawresidue1.txt
rm ../rawresidue2.txt
rm ../rawt1.txt
rm ../rawt2.txt
rm ../Residue1.txt
rm ../Residue2.txt
rm ../T1.txt
rm ../T2.txt
rm ../1.txt
rm ../2.txt

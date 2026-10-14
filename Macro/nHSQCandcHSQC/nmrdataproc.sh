#!/bin/bash
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Fourier Transformation
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


for ((i=11; i<31 ;i=i+2))
do
echo ... Processing nHSQC ...
cp ../$i/ser ./ser
chmod u+rwx ./nHSQC.com
nHSQC.com
mv ./xy.nv ./spect/$i.nv
rm ./xy.*
rm ./ser
done

for ((i=12; i<32 ;i=i+2))
do
echo ... Processing cHSQC ...
cp ../$i/ser ./ser
chmod u+rwx ./cHSQC.com
cHSQC.com
mv ./xy.nv ./spect/$i.nv
rm ./xy.*
rm ./ser
done

clear

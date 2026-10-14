#!/bin/bash
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Executing ft.com
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


for ((i=12; i<49 ;i=i+2))
do

echo ... Copying to $i ...

cp ../$i/ser ./ser

chmod u+rwx ./ft.com

ft.com

mv ./xy.nv ./spect/$i.nv

rm ./xy.*
rm ./ser

done

clear

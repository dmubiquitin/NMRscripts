#!/bin/bash

mkdir sum
mkdir sum4
mkdir sum8

for ((i=1; i<166 ;i=i+2));
do

echo ... Adding $i + $i+1...

addNMR -in1 ./spect/$i.ft2 -in2 ./spect/$((i+1)).ft2 -out ./sum/fid_add_$i.ft2

done

for ((i=1; i<162 ;i=i+4));
do

echo ... Adding $i + $i+1 + $i+2 + $i+3 ...

addNMR -in1 ./sum/fid_add_$i.ft2 -in2 ./sum/fid_add_$((i+2)).ft2 -out ./sum4/fid_add_$i.ft2

done

for ((i=1; i<158 ;i=i+8));
do

echo ... Adding $i + $i+1 + $i+2 + $i+3 + $i+4 + $i+5 + $i+6 + $i+7...

addNMR -in1 ./sum4/fid_add_$i.ft2 -in2 ./sum4/fid_add_$((i+4)).ft2 -out ./sum8/fid_add_$i.ft2

done

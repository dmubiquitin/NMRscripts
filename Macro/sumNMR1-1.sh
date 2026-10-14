#!/bin/bash

for ((i=10; i<41 ;i=i+2));

do

echo ... Adding $i ...

addNMR -in1 ./$i.ft2 -in2 ./$((i+1)).ft2 -out ./sum/add_$i.ft2
pipe2xyz -nv -in ./sum/add_$i.ft2 -out ./sum/add_$i.nv -ov
#rm add_$i.ft2

done

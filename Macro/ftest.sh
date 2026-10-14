#!/bin/csh

#F-test
#Chekck the file name below

cp ~/Google\ ドライブ/NMRprocessing/aru_ftest.py ./
chmod +x ./aru_ftest.py
./aru_ftest.py glove_const.out glove_rich.out 0.999999 > ftest_0.999999.txt
rm ./aru_ftest.py

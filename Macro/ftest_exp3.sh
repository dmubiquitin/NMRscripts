#!/bin/csh

#F-test
#Chekck the file name below

cp ~/GoogleDrive/NMRprocessing/aru_ftest.py ./
chmod +x ./aru_ftest.py
./aru_ftest.py glove_const.out glove_exp3.out 0.99999 > ftest_0.99999.txt
rm ./aru_ftest.py

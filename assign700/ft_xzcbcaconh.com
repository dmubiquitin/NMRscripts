#!/bin/csh

setenv NAME cbcaconh

$NMRTXT/ext.xz.com fid/cbcaconh%03d.fid fid/${NAME}_1xz.fid
#$NMRTXT/ext.xz.com fid/cbcaconh%03d.fid fid/${NAME}_1xz.fid 2

nmrPipe -in fid/${NAME}_1xz.fid			\
| nmrPipe -fn SOL				\
| nmrPipe -fn SP -c 0.5 -off 0.35 -end 0.95	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 -76 -p1 -7 -di		\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -fn EXT -x1 6.3ppm -xn 10.5ppm -sw	\
| nmrPipe -fn TP				\
| nmrPipe -fn LP -f -auto			\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 1 -pow 2 	\
| nmrPipe -fn FT -alt -verb			\
| nmrPipe -fn PS -p0 -4 -p1 30 -di		\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -fn TP				\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -out xz.ft2 -ov

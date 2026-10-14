#!/bin/csh

setenv NAME cnoesy-aliased

nmrPipe -in fid/${NAME}001.fid			\
| nmrPipe -fn SP -c 0.5 -off 0.35 -end 0.95	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 -108 -p1 -14 -di		\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -fn EXT -x1 -0.2ppm -xn 6.0ppm -sw	\
| nmrPipe -fn TP				\
| nmrPipe -fn LP -f -auto			\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 1 -pow 2	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 -90 -p1 0 -di		\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -fn TP				\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -out xy.ft2 -ov

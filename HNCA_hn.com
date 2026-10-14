#!/bin/csh

bruk2pipe -in ./ser \
  -bad 0.0 -aswap -DMX -decim 5712 -dspfvs 20 -grpdly 67.9851226806641  \
  -xN               768  -yN               128  \
  -xT               349  -yT                64  \
  -xMODE            DQD  -yMODE  States-TPPI  \
  -xSW         3501.401  -ySW          709.522  \
  -xOBS         700.182  -yOBS          70.951  \
  -xCAR             3.2  -yCAR              39 \
  -xLAB              HN  -yLAB             15N  \
  -ndim               2  -aq2D          States  \
  -out ./test.fid -verb -ov
  
nmrPipe -in test.fid					\
| nmrPipe -fn SOL					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 0.98 -pow 1	\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT					\
| nmrPipe -fn PS -p0 122 -p1 0 -di			\
| nmrPipe -fn TP					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 0.98 -pow 1		\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT -alt					\
| nmrPipe -fn PS -p0 0 -p1 0 -di			\
| nmrPipe -fn POLY -auto -ord 1				\
| nmrPipe -fn TP					\
| nmrPipe -fn POLY -auto -ord 1				\
#| nmrPipe -fn EXT -x1 6ppm -xn 10.5ppm -sw		\
| nmrPipe -out test.ft2 -ov

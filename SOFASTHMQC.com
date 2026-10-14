#!/bin/csh

bruk2pipe -in ./ser \
  -bad 0.0 -noaswap -DMX -decim 32 -dspfvs 12 -grpdly -1  \
  -xN               512  -yN               128  \
  -xT               256  -yT                64  \
  -xMODE            DQD  -yMODE        Complex  \
  -xSW         4807.692  -ySW         1824.485  \
  -xOBS         600.135  -yOBS          60.818  \
  -xCAR           9.000  -yCAR         119.500  \
  -xLAB              HN  -yLAB             15N  \
  -ndim               2  -aq2D          States  \
  -out ./test.fid -verb -ov

nmrPipe -in test.fid					\
#| nmrPipe -fn SOL					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 0.98 -pow 1	\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT					\
| nmrPipe -fn PS -p0 215 -p1 0 -di			\
| nmrPipe -fn TP					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 0.98 -pow 1		\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT -alt					\
| nmrPipe -fn PS -p0 0 -p1 0 -di			\
| nmrPipe -fn POLY -auto -ord 1				\
| nmrPipe -fn TP					\
| nmrPipe -fn POLY -auto -ord 1				\
#| nmrPipe -fn EXT -x1 6ppm -xn 10.5ppm -sw		\
| nmrPipe -out xy.ft2 -ov

#pipe2xyz -nv -in xy.ft2 -out xy.nv -ov

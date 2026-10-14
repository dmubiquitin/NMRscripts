#!/bin/csh

bruk2pipe -in ./ser \
  -bad 0.0 -aswap -DMX -decim 2856 -dspfvs 20 -grpdly 67.9860382080078  \
  -xN              2048  -yN               256  \
  -xT              1024  -yT               128  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  \
  -xSW         7002.801  -ySW         1631.854  \
  -xOBS         700.183  -yOBS          70.957  \
  -xCAR           4.700  -yCAR         118.500  \
  -xLAB              HN  -yLAB             15N  \
  -ndim               2  -aq2D          States  \
  -out ./test.fid -verb -ov

nmrPipe -in test.fid					\
| nmrPipe -fn POLY					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 0.98 -pow 1	\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT					\
| nmrPipe -fn PS -p0 -45 -p1 0 -di			\
| nmrPipe -fn TP					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 0.98 -pow 1		\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT					\
| nmrPipe -fn PS -p0 -90 -p1 0 -di			\
| nmrPipe -fn POLY -auto -ord 1				\
| nmrPipe -fn TP					\
| nmrPipe -fn POLY -auto -ord 1				\
| nmrPipe -fn EXT -x1 6ppm -xn 11ppm -sw		\
| nmrPipe -out test.ft2 -ov

#pipe2xyz -nv -in test.ft2 -out test.nv -ov

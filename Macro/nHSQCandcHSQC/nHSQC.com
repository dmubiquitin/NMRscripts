#!/bin/csh

bruk2pipe -in ./ser \
  -bad 0.0 -ext -noaswap -AMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              1024  -yN                82  \
  -xT               512  -yT                41  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  \
  -xSW         7183.908  -ySW         1459.625  \
  -xOBS         600.133  -yOBS          60.818  \
  -xCAR           4.700  -yCAR         116.000  \
  -xLAB              HN  -yLAB             15N  \
  -ndim               2  -aq2D         Complex  \
  -out ./test.fid -verb -ov

nmrPipe -in test.fid					\
| nmrPipe -fn SOL					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 0.98 -pow 1	\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT					\
| nmrPipe -fn PS -p0 22 -p1 0 -di			\
| nmrPipe -fn TP					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 0.98 -pow 1		\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT					\
| nmrPipe -fn PS -p0 -90 -p1 0 -di			\
| nmrPipe -fn POLY -auto -ord 1				\
| nmrPipe -fn TP					\
| nmrPipe -fn POLY -auto -ord 1				\
| nmrPipe -fn EXT -x1 6ppm -xn 9ppm -sw		\
| nmrPipe -out test.ft2 -ov

pipe2xyz -nv -in test.ft2 -out xy.nv -ov
rm test.ft2
rm test.fid

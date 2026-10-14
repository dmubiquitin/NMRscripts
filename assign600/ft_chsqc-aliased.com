#!/bin/csh

setenv NAME chsqc-aliased

bruk2pipe -in ser \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              1024  -yN               128  \
  -xT               512  -yT                64  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  \
  -xSW         7183.908  -ySW         6337.136  \
  -xOBS         600.133  -yOBS         150.907  \
  -xCAR           4.778  -yCAR          27.746  \
  -xLAB              HC  -yLAB               C  \
  -ndim               2  -aq2D          States  \
  -out ${NAME}.fid -verb -ov

nmrPipe -in ${NAME}.fid				\
| nmrPipe -fn SP -c 0.5 -off 0.35 -end 0.95	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 78 -p1 -24 -di		\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -fn EXT -x1 0.0ppm -xn 6.0ppm -sw	\
| nmrPipe -fn TP				\
| nmrPipe -fn LP -auto				\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 1 -pow 2	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 62 -p1 35 -di   		\
| nmrPipe -fn POLY -auto -ord 0                 \
| nmrPipe -fn TP				\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -out ${NAME}.ft2 -ov

pipe2xyz -nv -in ${NAME}.ft2 -out ${NAME}.nv -ov

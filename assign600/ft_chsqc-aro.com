#!/bin/csh

setenv NAME chsqc-aro

bruk2pipe -in ser \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              1024  -yN                64  \
  -xT               512  -yT                32  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  \
  -xSW         7183.908  -ySW         6038.647  \
  -xOBS         600.133  -yOBS         150.922  \
  -xCAR           4.778  -yCAR         129.746  \
  -xLAB              HC  -yLAB               C  \
  -ndim               2  -aq2D          States  \
  -out ${NAME}.fid -verb -ov

nmrPipe -in ${NAME}.fid					\
| nmrPipe -fn SOL					\
| nmrPipe -fn SP -c 0.5 -off 0.35 -end 0.95 -pow 2	\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT -verb					\
| nmrPipe -fn PS -p0 -15 -p1 -17 -di			\
| nmrPipe -fn POLY -auto -ord 0				\
| nmrPipe -fn EXT -x1 6.2ppm -xn 8.7ppm -sw		\
| nmrPipe -fn TP					\
| nmrPipe -fn LP -auto					\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 1 -pow 2		\
| nmrPipe -fn ZF -auto					\
| nmrPipe -fn FT -verb					\
| nmrPipe -fn PS -p0 90 -p1 0 -di   			\
| nmrPipe -fn POLY -auto -ord 0                 	\
| nmrPipe -fn TP					\
| nmrPipe -fn POLY -auto -ord 0				\
| nmrPipe -out ${NAME}.ft2 -ov

pipe2xyz -nv -in ${NAME}.ft2 -out ${NAME}.nv -ov

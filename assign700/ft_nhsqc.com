#!/bin/csh

setenv NAME nhsqc

bruk2pipe -in ser \
  -bad 0.0 -aswap -DMX -decim 2376 -dspfvs 20 -grpdly 67.9872589111328  \
  -xN              1024  -yN               256  \
  -xT               512  -yT               128  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  \
  -xSW         8417.508  -ySW         1773.679  \
  -xOBS         700.183  -yOBS          70.957  \
  -xCAR           4.781  -yCAR         117.075  \
  -xLAB              HN  -yLAB               N  \
  -ndim               2  -aq2D          States  \
  -out ${NAME}.fid -verb -ov

nmrPipe -in ${NAME}.fid				\
| nmrPipe -fn SOL				\
| nmrPipe -fn SP -c 0.5 -off 0.35 -end 0.95	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 -173 -p1 -9 -di		\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -fn EXT -x1 6.3ppm -xn 10.5ppm -sw	\
| nmrPipe -fn TP				\
| nmrPipe -fn LP -auto				\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 1 -pow 1	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 90 -p1 0 -di   		\
| nmrPipe -fn POLY -auto -ord 0                 \
| nmrPipe -fn TP				\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -out ${NAME}.ft2 -ov

pipe2xyz -nv -in ${NAME}.ft2 -out ${NAME}.nv -ov

#pipe2ucsf ${NAME}.ft2 ${NAME}.ucsf

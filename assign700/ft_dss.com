#!/bin/csh

setenv NAME dss

bruk2pipe -in fid \
  -bad 0.0 -aswap -DMX -decim 2040 -dspfvs 20 -grpdly 67.9862060546875  \
  -xN              8192  \
  -xT              4096  \
  -xMODE            DQD  \
  -xSW         9803.922  \
  -xOBS         700.183  \
  -xCAR           4.781  \
  -xLAB              1H  \
  -ndim               1  \
  -out ${NAME}.fid -verb -ov


nmrPipe -in ${NAME}.fid				\
#| nmrPipe -fn SOL				\
| nmrPipe -fn EM -lb 5				\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 108 -p1 0 -di		\
| nmrPipe -fn EXT -x1 -1ppm -xn 1ppm -sw	\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -out ${NAME}.ft -ov

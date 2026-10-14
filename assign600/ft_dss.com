#!/bin/csh

setenv NAME dss

bruk2pipe -in fid \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              8192  \
  -xT              4096  \
  -xMODE            DQD  \
  -xSW         7183.908  \
  -xOBS         600.133  \
  -xCAR           4.778  \
  -xLAB              1H  \
  -ndim               1  \
  -out ${NAME}.fid -verb -ov


nmrPipe -in ${NAME}.fid			\
#| nmrPipe -fn SOL			\
| nmrPipe -fn ZF -auto			\
| nmrPipe -fn FT -verb			\
| nmrPipe -fn PS -p0 -110 -p1 0 -di	\
| nmrPipe -fn POLY -auto -ord 0		\
| nmrPipe -out ${NAME}.ft -ov

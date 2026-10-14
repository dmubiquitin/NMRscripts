#!/bin/csh

bruk2pipe -in ./fid \
  -bad 0.0 -noaswap -DMX -decim 16 -dspfvs 12 -grpdly -1  \
  -xN              5120  \
  -xT              2500  \
  -xMODE            DQD  \
  -xSW         9615.385  \
  -xOBS         600.132  \
  -xCAR           3.600  \
  -xLAB              1H  \
  -ndim               1  \
  -out ./test.fid -verb -ov
  
nmrPipe -in test.fid \
| nmrPipe  -fn SP -off 0.5 -end 1.00 -pow 1 -c 1.0    \
| nmrPipe  -fn ZF -auto                               \
| nmrPipe  -fn FT -auto                               \
| nmrPipe  -fn PS -p0 -51.00 -p1 0.00 -di -verb         \
| nmrPipe -fn EXT -x1 -1ppm -xn 3ppm -sw                                    \
   -ov -out xy.ft2

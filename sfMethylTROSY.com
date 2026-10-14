#!/bin/csh

bruk2pipe -in ./ser \
  -bad 0.0 -aswap -DMX -decim 2800 -dspfvs 20 -grpdly 67.9857177734375  \
  -xN               768  -yN               128  \
  -xT               360  -yT                64  \
  -xMODE            DQD  -yMODE    States-TPPI  \
  -xSW         7142.857  -ySW         3521.127  \
  -xOBS         700.183  -yOBS         176.068  \
  -xCAR           4.659  -yCAR          45.623  \
  -xLAB              1H  -yLAB             13C  \
  -ndim               2  -aq2D          States  \
  -out ./test.fid -verb -ov

nmrPipe -in test.fid \
| nmrPipe  -fn SOL                                    \
| nmrPipe  -fn SP -off 0.5 -end 0.98 -pow 1 -c 0.5    \
| nmrPipe  -fn ZF -auto                               \
| nmrPipe  -fn FT                                     \
| nmrPipe  -fn PS -p0 50  -p1 0.0 -di                 \
| nmrPipe  -fn EXT -right -sw -verb                    \
| nmrPipe  -fn TP                                     \
| nmrPipe  -fn SP -off 0.5 -end 0.98 -pow 1 -c 0.5    \
| nmrPipe  -fn ZF -auto                               \
| nmrPipe  -fn FT                                     \
| nmrPipe  -fn PS -p0 0 -p1 0 -di                \
  -verb -ov -out test.ft2
rm ./test.fid

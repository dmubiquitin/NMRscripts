#!/bin/csh

bruk2pipe -in ./ser \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              1024  -zN               256  -yN                19  \
  -xT               512  -zT               128  -yT                19  \
  -xMODE            DQD  -zMODE  Echo-AntiEcho  -yMODE           Real  \
  -xSW         6944.444  -zSW         2006.823  -ySW           19.000  \
  -xOBS         600.133  -zOBS          60.818  -yOBS           1.000  \
  -xCAR           4.700  -zCAR         119.000  -yCAR           0.000  \
  -xLAB              HN  -zLAB             15N  -yLAB              ID  \
  -ndim               3  -aq2D          States                         \
| nmrPipe -fn TP \
| nmrPipe -fn ZTP \
| nmrPipe -fn TP -hyper \
| pipe2xyz -out ./fid/%d.fid -verb -ov


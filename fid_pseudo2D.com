#!/bin/csh

bruk2pipe -in ./ser \
  -bad 0.0 -aswap -DMX -decim 2080 -dspfvs 20 -grpdly 67.9842071533203  \
  -xN              1024  -yN              2675  \
  -xT               512  -yT              2675  \
  -xMODE            DQD  -yMODE           Real  \
  -xSW         9615.385  -ySW         2675.000  \
  -xOBS         600.033  -yOBS           1.000  \
  -xCAR           4.700  -yCAR           0.000  \
  -xLAB              1H  -yLAB              ID  \
  -ndim               2  -aq2D          States  \
  -out ./test.fid -verb -ov
split2D.com ./test.fid

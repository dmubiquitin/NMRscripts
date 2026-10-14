#!/bin/csh

setenv NAME cnoesy-aliased

bruk2pipe -in ser \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              1024  -yN                64  -zN               128  \
  -xT               512  -yT                32  -zT                64  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  -zMODE        Complex  \
  -xSW         7183.908  -ySW         6337.136  -zSW         7183.908  \
  -xOBS         600.133  -yOBS         150.907  -zOBS         600.133  \
  -xCAR           4.778  -yCAR          27.746  -zCAR           4.778  \
  -xLAB              HC  -yLAB               C  -zLAB               H  \
  -ndim               3  -aq2D          States                         \
  -out fid/${NAME}%03d.fid -verb -ov

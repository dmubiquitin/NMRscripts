#!/bin/csh

setenv NAME hnco

bruk2pipe -in ser \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              1024  -yN                48  -zN                48  \
  -xT               512  -yT                24  -zT                24  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  -zMODE        Complex  \
  -xSW         7183.908  -ySW         1702.997  -zSW         1358.327  \
  -xOBS         600.133  -yOBS          60.818  -zOBS         150.929  \
  -xCAR           4.778  -yCAR         119.101  -zCAR         174.746  \
  -xLAB              HN  -yLAB               N  -zLAB               C  \
  -ndim               3  -aq2D          States                         \
  -out fid/${NAME}%03d.fid -verb -ov

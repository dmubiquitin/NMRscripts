#!/bin/csh

setenv NAME nnoesy

bruk2pipe -in ser \
  -bad 0.0 -aswap -DMX -decim 2376 -dspfvs 20 -grpdly 67.9872589111328  \
  -xN              1024  -yN                48  -zN               128  \
  -xT               512  -yT                24  -zT                64  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  -zMODE        Complex  \
  -xSW         8417.508  -ySW         1773.679  -zSW         8417.508  \
  -xOBS         700.183  -yOBS          70.957  -zOBS         700.183  \
  -xCAR           4.781  -yCAR         117.097  -zCAR           4.781  \
  -xLAB              HN  -yLAB               N  -zLAB               H  \
  -ndim               3  -aq2D          States                         \
  -out fid/${NAME}%03d.fid -verb -ov

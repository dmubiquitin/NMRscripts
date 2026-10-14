#!/bin/csh

setenv NAME cnoesy-aliased

bruk2pipe -in ser \
  -bad 0.0 -aswap -DMX -decim 2376 -dspfvs 20 -grpdly 67.9872589111328  \
  -xN              1024  -yN                64  -zN               128  \
  -xT               512  -yT                32  -zT                64  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  -zMODE        Complex  \
  -xSW         8417.508  -ySW         7396.450  -zSW         8417.508  \
  -xOBS         700.183  -yOBS         176.065  -zOBS         700.183  \
  -xCAR           4.781  -yCAR          27.745  -zCAR           4.781  \
  -xLAB              HC  -yLAB               C  -zLAB              1H  \
  -ndim               3  -aq2D          States                         \
  -out fid/${NAME}%03d.fid -verb -ov

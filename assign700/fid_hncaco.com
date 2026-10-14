#!/bin/csh

setenv NAME hncaco

bruk2pipe -in ser \
  -bad 0.0 -aswap -DMX -decim 2376 -dspfvs 20 -grpdly 67.9872589111328  \
  -xN              1024  -yN                48  -zN                48  \
  -xT               512  -yT                24  -zT                24  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  -zMODE        Complex  \
  -xSW         8417.508  -ySW         1773.679  -zSW         1761.184  \
  -xOBS         700.183  -yOBS          70.957  -zOBS         176.091  \
  -xCAR           4.781  -yCAR         117.097  -zCAR         177.246  \
  -xLAB              HN  -yLAB               N  -zLAB               C  \
  -ndim               3  -aq2D          States                         \
  -out fid/${NAME}%03d.fid -verb -ov

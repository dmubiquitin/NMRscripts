#!/bin/csh

setenv NAME hcch-tocsy

bruk2pipe -in ser \
  -bad 0.0 -aswap -DMX -decim 2376 -dspfvs 20 -grpdly 67.9872589111328  \
  -xN              1024  -yN                64  -zN                80  \
  -xT               512  -yT                32  -zT                40  \
  -xMODE            DQD  -yMODE        Complex  -zMODE        Complex  \
  -xSW         8417.508  -ySW         4901.961  -zSW        12315.271  \
  -xOBS         700.183  -yOBS         700.183  -zOBS         176.067  \
  -xCAR           4.781  -yCAR           3.031  -zCAR          40.745  \
  -xLAB              HC  -yLAB               H  -zLAB               C  \
  -ndim               3  -aq2D          States                         \
  -out fid/${NAME}%03d.fid -verb -ov

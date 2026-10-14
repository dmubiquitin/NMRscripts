#!/bin/csh

setenv NAME hcch-cosy

bruk2pipe -in ser \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              1024  -yN                64  -zN                80  \
  -xT               512  -yT                32  -zT                40  \
  -xMODE            DQD  -yMODE        Complex  -zMODE        Complex  \
  -xSW         7183.908  -ySW         4201.681  -zSW        10559.662  \
  -xOBS         600.133  -yOBS         600.133  -zOBS         150.909  \
  -xCAR           4.778  -yCAR           3.028  -zCAR          40.746  \
  -xLAB              HC  -yLAB               H  -zLAB               C  \
  -ndim               3  -aq2D          States                         \
  -out fid/${NAME}%03d.fid -verb -ov

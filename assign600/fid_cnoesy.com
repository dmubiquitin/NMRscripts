#!/bin/csh

setenv NAME cnoesy

bruk2pipe -in ser \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              1024  -yN                80  -zN               128  \
  -xT               512  -yT                40  -zT                64  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  -zMODE        Complex  \
  -xSW         7183.908  -ySW        10559.662  -zSW         7183.908  \
  -xOBS         600.133  -yOBS         150.909  -zOBS         600.133  \
  -xCAR           4.778  -yCAR          40.746  -zCAR           4.778  \
  -xLAB              HC  -yLAB               C  -zLAB              1H  \
  -ndim               3  -aq2D          States                         \
  -out fid/${NAME}%03d.fid -verb -ov

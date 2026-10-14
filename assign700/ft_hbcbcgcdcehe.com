#!/bin/csh

setenv NAME hbcbcgcdcehe

bruk2pipe -in ser \
  -bad 0.0 -aswap -DMX -decim 2376 -dspfvs 20 -grpdly 67.9872589111328  \
  -xN              1024  -yN                32  \
  -xT               512  -yT                16  \
  -xMODE            DQD  -yMODE        Complex  \
  -xSW         8417.508  -ySW         3521.127  \
  -xOBS         700.183  -yOBS         176.067  \
  -xCAR           4.781  -yCAR          39.745  \
  -xLAB              HC  -yLAB               C  \
  -ndim               2  -aq2D          States  \
  -out ${NAME}.fid -verb -ov

nmrPipe -in ${NAME}.fid				\
| nmrPipe -fn SOL				\
| nmrPipe -fn SP -c 0.5 -off 0.35 -end 0.95	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb				\
| nmrPipe -fn PS -p0 195 -p1 0 -di		\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -fn EXT -x1 6.4ppm -xn 7.8ppm -sw	\
| nmrPipe -fn TP				\
| nmrPipe -fn LP -auto				\
| nmrPipe -fn SP -c 0.5 -off 0.5 -end 1 -pow 2	\
| nmrPipe -fn ZF -auto				\
| nmrPipe -fn FT -verb -alt			\
| nmrPipe -fn PS -p0 0 -p1 0 -di   		\
| nmrPipe -fn POLY -auto -ord 0                 \
| nmrPipe -fn TP				\
| nmrPipe -fn POLY -auto -ord 0			\
| nmrPipe -out ${NAME}.ft2 -ov

pipe2xyz -nv -in ${NAME}.ft2 -out ${NAME}.nv -ov

#pipe2ucsf ${NAME}.ft2 ${NAME}.ucsf

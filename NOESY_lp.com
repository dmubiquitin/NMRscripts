#!/bin/csh

bruk2pipe -in ./ser \
  -bad 0.0 -aswap -DMX -decim 2856 -dspfvs 20 -grpdly 67.9860382080078  \
  -xN              2048  -yN                48  -zN               128  \
  -xT              1024  -yT                24  -zT                64  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  -zMODE    States-TPPI  \
  -xSW         7002.801  -ySW         1631.854  -zSW         7002.801  \
  -xOBS         700.183  -yOBS          70.957  -zOBS         700.183  \
  -xCAR           4.700  -yCAR         118.500  -zCAR           4.700  \
  -xLAB              HN  -yLAB             15N  -zLAB              1H  \
  -ndim               3  -aq2D          States                         \
  -out ./fid/test%03d.fid -verb -ov

#!/bin/csh

#
# 3D Processing with Linear Prediction in Y and Z Dimensions:
#   Process the Directly-detected X-Axis.
#   Process the Indirectly-detected Z-Axis.
#   Predict and Process the Indirectly-detected Y-Axis.
#   Inverse Process, Predict, and Re-Process the Z-Axis.
 
xyz2pipe -in fid/test%03d.fid -x  -verb             \
| nmrPipe  -fn SOL                                  \
| nmrPipe  -fn SP -off 0.5 -end 0.98 -pow 2 -c 0.5  \
| nmrPipe  -fn ZF -auto                             \
| nmrPipe  -fn FT                                   \
| nmrPipe  -fn PS -p0 30  -p1 0.0 -di               \
| nmrPipe -fn POLY -auto -ord 0                                      \
| nmrPipe  -fn EXT -left -sw                        \
| pipe2xyz -out lp/test%03d.ft3 -x

xyz2pipe -in lp/test%03d.ft3 -z -verb               \
| nmrPipe  -fn SP -off 0.5 -end 0.95 -pow 1 -c 0.5  \
| nmrPipe  -fn ZF -auto                             \
| nmrPipe  -fn FT                                   \
| nmrPipe  -fn PS -p0 0.0 -p1 0.0 -di               \
| pipe2xyz -out lp/test%03d.ft3 -z -inPlace

xyz2pipe -in lp/test%03d.ft3 -y -verb               \
| nmrPipe  -fn LP -fb -ord 10                       \
| nmrPipe  -fn SP -off 0.5 -end 0.98 -pow 1 -c 0.5  \
| nmrPipe  -fn ZF -auto                             \
| nmrPipe  -fn FT                                   \
| nmrPipe  -fn PS -p0 90 -p1 0 -di              \
| pipe2xyz -out lp/test%03d.ft3 -y -inPlace

xyz2pipe -in lp/test%03d.ft3 -z -verb               \
| nmrPipe  -fn HT  -auto                            \
| nmrPipe  -fn PS  -inv -hdr                        \
| nmrPipe  -fn FT  -inv                             \
| nmrPipe  -fn ZF  -inv                             \
| nmrPipe  -fn SP  -inv -hdr                        \
| nmrPipe  -fn LP  -fb                              \
| nmrPipe  -fn SP  -off 0.5 -end 0.98 -pow 1 -c 0.5 \
| nmrPipe  -fn ZF  -auto                            \
| nmrPipe  -fn FT  -alt                                 \
| nmrPipe  -fn PS  -hdr -di                         \
| pipe2xyz -out lp/test%03d.ft3 -z -inPlace

xyz2pipe -in lp/test%03d.ft3 -out xy.ft3
rm -r lp
#proj3D.tcl -in lp/test%03d.ft3

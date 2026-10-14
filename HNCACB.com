#!/bin/csh
bruk2pipe -in ./ser \
  -bad 0.0 -noaswap -DMX -decim 24 -dspfvs 12 -grpdly -1  \
  -xN              2048  -yN                64  -zN               128  \
  -xT              1024  -yT                32  -zT                64  \
  -xMODE            DQD  -yMODE  Echo-AntiEcho  -zMODE    States-TPPI  \
  -xSW         6613.757  -ySW         1216.350  -zSW        11318.141  \
  -xOBS         600.132  -yOBS          60.811  -zOBS         150.903  \
  -xCAR           3.614  -yCAR         113.037  -zCAR          40.682  \
  -xLAB              HN  -yLAB             15N  -zLAB             13C  \
  -ndim               3  -aq2D          States                         \
  -out ./fid/test%03d.fid -verb -ov

#   Process the Indirectly-detected Z-Axis.
#   Predict and Process the Indirectly-detected Y-Axis.
#   Inverse Process, Predict, and Re-Process the Z-Axis.
 
xyz2pipe -in fid/test%03d.fid -x  -verb             \
| nmrPipe  -fn SOL                                  \
| nmrPipe  -fn SP -off 0.5 -end 0.98 -pow 2 -c 0.5  \
| nmrPipe  -fn ZF -auto                             \
| nmrPipe  -fn FT                                   \
| nmrPipe  -fn PS -p0 157  -p1 0.0 -di               \
| nmrPipe  -fn EXT -left -x1 6ppm -xn 9ppm -sw       \
| pipe2xyz -out ft/test%03d.ft3 -x

xyz2pipe -in ft/test%03d.ft3 -z -verb               \
| nmrPipe  -fn SP -off 0.5 -end 0.95 -pow 1 -c 0.5  \
| nmrPipe  -fn ZF -auto                             \
| nmrPipe  -fn FT -alt  -neg                             \
| nmrPipe  -fn PS -p0 0.0 -p1 0.0 -di               \
| pipe2xyz -out ft/test%03d.ft3 -z -inPlace

xyz2pipe -in ft/test%03d.ft3 -y -verb               \
#| nmrPipe  -fn LP -fb -ord 10                       \
| nmrPipe  -fn SP -off 0.5 -end 0.98 -pow 1 -c 1.0  \
| nmrPipe  -fn ZF -auto                             \
| nmrPipe  -fn FT                                   \
| nmrPipe  -fn PS -p0 90 -p1 0 -di              \
| pipe2xyz -out ft/test%03d.ft3 -y -inPlace

xyz2pipe -in ft/test%03d.ft3 -z -verb               \
| nmrPipe  -fn HT  -auto                            \
| nmrPipe  -fn PS  -inv -hdr                        \
| nmrPipe  -fn FT  -inv                             \
| nmrPipe  -fn ZF  -inv                             \
| nmrPipe  -fn SP  -inv -hdr                        \
#| nmrPipe  -fn LP  -fb                              \
| nmrPipe  -fn SP  -off 0.5 -end 0.98 -pow 1 -c 0.5 \
| nmrPipe  -fn ZF  -auto                            \
| nmrPipe  -fn FT                                   \
| nmrPipe  -fn PS  -hdr -di                         \
| pipe2xyz -out ft/test%03d.ft3 -z -inPlace

xyz2pipe -in ft/test%03d.ft3 -out xy.ft3
proj3D.tcl -in ft/test%03d.ft3

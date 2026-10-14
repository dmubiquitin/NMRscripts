#!/bin/csh
rm -r ./fid
rm -r ./ft
rm ./*.dat
rm ./xy.ft3
mkdir ./fid
touch ./fid/test.fid
chmod +x ./fid/test.fid

# Convert data from Bruker format
# Paste the output of bruker and edit several parameters
bruk2pipe -in ./ser \
  -bad 0.0 -aswap -DMX -decim 2856 -dspfvs 20 -grpdly 67.9860382080078  \
  -xN              2048  -yN               612  -zN                 1  \
  -xT              1024  -yT                24  -zT                64  \
  -xMODE            DQD  -yMODE         Complex  -zMODE           Real \
  -xSW         7002.801  -ySW         1631.854  -zSW         7002.801  \
  -xOBS         700.183  -yOBS          70.957  -zOBS         700.183  \
  -xCAR           4.700  -yCAR         118.500  -zCAR           4.700  \
  -xLAB              HN  -yLAB             15N  -zLAB              1H  \
  -ndim               2  -aq2D          States  -nusDim             3  \
| nmrPipe -fn MAC -macro $NMRTXT/bruk_ranceN.M -noRd -noWr -var nShuf 1 \
  -out fid/test.fid -ov

nusExpand.tcl -in ./fid/test.fid -out ./fid/test%03d.fid -sample ./nuslist\

xyz2pipe -in fid/test%03d.fid -x -verb               \
| nmrPipe  -fn SOL                                    \
| nmrPipe  -fn SP -off 0.50 -end 0.98 -pow 1 -c 0.5   \
| nmrPipe  -fn ZF -size 2048                          \
| nmrPipe  -fn FT                                     \
| nmrPipe  -fn PS -p0 136 -p1 0 -di               \
| nmrPipe  -fn EXT -x1 9.6ppm -xn 6.0ppm -sw          \
| pipe2xyz  -out ft/test%03d.ft1 -x -ov

# Process Y (indirect) dimension
xyz2pipe -in ft/test%03d.ft1 -y -verb               \
| nmrPipe  -fn SP -off 0.50 -end 0.5 -pow 1 -c 0.5    \
| nmrPipe  -fn ZF -size 48                           \
| nmrPipe  -fn FT                                     \
| nmrPipe  -fn PS -p0 -90.0 -p1 0.0 -di                 \
| pipe2xyz -out ft/test%03d.ft2 -y -ov

# Process Z (indirect) dimension
xyz2pipe -in ft/test%03d.ft2 -z -verb               \
| nmrPipe  -fn SP -off 0.50 -end 0.5 -pow 1 -c 0.5    \
| nmrPipe  -fn ZF -size 128                           \
| nmrPipe  -fn FT -alt                                    \
| nmrPipe  -fn PS -p0 0.0 -p1 0.0 -di                 \
| pipewash -fn SCRUB -pattern ./nuslist  \
| pipe2xyz  -out ft/test%03d.ft3 -z -ov


xyz2pipe -in ft/test%03d.ft3 -out xy.ft3
proj3D.tcl -in ft/test%03d.ft3

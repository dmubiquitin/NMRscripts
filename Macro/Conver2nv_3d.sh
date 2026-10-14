#!/bin/csh -f

xyz2pipe -in ft/test%03d.dat -x \
|pipe2xyz -nv -out filename.nv

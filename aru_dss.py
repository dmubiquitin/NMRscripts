#!/usr/bin/python

# ______________________________________________________________________
#	2014/11/15 Arurun
# 	Chemical shift referencing using DSS
# ______________________________________________________________________
#	1. Record 1D spectrum of DSS in the same buffer (external)
#	   or the actual protein sample (internal) standard
#	   using 1D pulse with water suppression (e.g. p3919fpgp)
#	2. Process the 1D in NMR draw and note the frequency of 
#	   the DSS methyl resonance line (sharp peak around 0 ppm)
#	3. Run this script in the folder containing the nmr data
#	   (acqu files etc.). Plug in the DSS-methyl shift in ppm.
#	4. The script will give you the new, referenced spectral
#	   centers in ppm. Use these in your fid.com and you will
#	   obtain properly referenced spectra. 
#
#	Note: This script assumes 15N is on O3 and 13C is on O2.
# ______________________________________________________________________

import os.path
import sys
from decimal import *

getcontext().prec = 10


# ______________________________________________________________________
# Dimensionality and file check
# ______________________________________________________________________

dimensions = 0

if os.path.exists("./acqu") == True:
	dimensions += 1
else:
	print "NMR files not found!"
	print "Please make sure you are in the correct directory (containing acqu etc. files)."
	sys.exit()

if os.path.exists("./acqu2") == True:
	dimensions += 1

if os.path.exists("./acqu3") == True:
	dimensions += 1

print dimensions, "-dimensional experiment detected!"


# ______________________________________________________________________
# Extract parameters
# ______________________________________________________________________

acqu = open('acqu')

for line in acqu:
	if "SFO1" in line:
		aa = line.split()
	if "$O1" in line:
		ab = line.split()

acqu = open('acqu')
for line in acqu:
	if "SFO3" in line:
		ac = line.split()
	if "$O3" in line:
		ad = line.split()

acqu = open('acqu')
for line in acqu:
	if "SFO2" in line:
		ae = line.split()
	if "$O2" in line:
		af = line.split()



 
SFO1 = float(aa[1])
O1 = float(ab[1])

carrier = (((Decimal(SFO1) * Decimal(1E6)) - Decimal(O1)) / Decimal(1E6))

print "Extracting parameters........... "
print "SFO1 [MHz] ..................... ", SFO1 
print "O1 [Hz] ........................ ", O1
print "Carrier [MHz] .................. ", carrier


DSS_ppm = input('Chemical shift of DSS [ppm] ....  ')
DSS_zure_Hz = carrier * Decimal((DSS_ppm * 1E-6)) * Decimal(1E6)
DSS_shift_Hz = carrier + (DSS_zure_Hz * Decimal(1E-6))

print "DSS drift from 0.00 ppm [Hz] ... ", DSS_zure_Hz
print "Frequency of DSS at 0 ppm [Hz] . ", DSS_shift_Hz

print ""
print ""
print "Referencing..................... "
print "_________________________________"

conversion_factor_hydrogen = Decimal(1)
zero_frequency_hydrogen = DSS_shift_Hz * conversion_factor_hydrogen
center_hydrogen = ((Decimal(SFO1) - zero_frequency_hydrogen) / zero_frequency_hydrogen) * Decimal(1E6)

print "1H new center [ppm] ............ " , center_hydrogen


if dimensions > 1:
	SFO3 = float(ac[1])
	O3 = float(ad[1])
	conversion_factor_nitrogen = Decimal(0.101329118)

	zero_frequency_nitrogen = DSS_shift_Hz * conversion_factor_nitrogen
	center_nitrogen = ((Decimal(SFO3) - zero_frequency_nitrogen) / zero_frequency_nitrogen) * Decimal(1E6)
	print "15N new center [ppm] ........... " , center_nitrogen
	
	SFO2 = float(ae[1])
	O2 = float(af[1])
	
	conversion_factor_carbon = Decimal(0.251449530)

	zero_frequency_carbon = DSS_shift_Hz * conversion_factor_carbon
	center_carbon = ((Decimal(SFO2) - zero_frequency_carbon) / zero_frequency_carbon) * Decimal(1E6)
	print "13C new center [ppm] ........... " , center_carbon
	
	



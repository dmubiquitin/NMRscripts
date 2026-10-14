#!/usr/bin/python

# ______________________________________________________________
#	2015/02/25 Arurun
#
#	Script to convert the chemical shift table from Sagoshi
#	to a chemical shift input table for MARS

#	Specify filenames

import sys

if len(sys.argv) < 2:
	print "Usage: aru_sagoshi2mars.py [input file (sagoshi))] [output file (MARS)]"
	sys.exit(0)

files = []
files.append(sys.argv[1])
files.append(sys.argv[2])

print "Converting ..."
print "Input file:  \t\t", files[0]
print "Output file: \t\t", files[1]


# Open reference

# Skip over header of MAGRO table
# ## id Restp(i-1) Restp(i) Resno   HN     N    CO(i-1)  CO   CA(i-1)  CA  CB(i-1) CB  candidbak    candidfwd comm

r = open(files[0], 'r')		
SkipHeader = r.readline()	



# Read Chemical shifts

id = []
hn = []
n = []
co_previous = []
co_self = []
ca_previous = []
ca_self = []
cb_previous = []
cb_self = []

countpeaks  = 0						# debug

for line in r:
	if len(line) > 5:				# skip footer and wrong lines
		columns   = line.split()
    		current_id   		= columns[0]
    		current_hn   		= columns[4]
    		current_n    		= columns[5]
    		current_co_prev    	= columns[6]
    		current_co_self    	= columns[7]
    		current_ca_prev    	= columns[8]
    		current_ca_self    	= columns[9]
    		current_cb_prev    	= columns[10]
    		current_cb_self    	= columns[11]

		id.append(current_id)
		co_self.append(float("{0:.3f}".format(float(current_co_self))))
		hn.append(float("{0:.3f}".format(float(current_hn))))
		n.append(float("{0:.3f}".format(float(current_n))))
		co_previous.append(float("{0:.3f}".format(float(current_co_prev))))
		ca_previous.append(float("{0:.3f}".format(float(current_ca_prev))))
		ca_self.append(float("{0:.3f}".format(float(current_ca_self))))
		cb_previous.append(float("{0:.3f}".format(float(current_cb_prev))))
		cb_self.append(float("{0:.3f}".format(float(current_cb_self))))


		countpeaks += 1
r.close()


#debug

#print id
#print cb_self



# write header

f = open(files[1], 'w')		

#            H        N     CO-1       CO     CA-1       CA     CB-1       CB  

# write results
f.write("\t\tH \t\tN \t\tCO-1 \t\tCO \t\tCA-1 \t\tCA \t\tCB-1 \t\tCB\n")



for i in range(len(id)):
	#linestring = id[i] + "\t\t" + hn[i] + "\t\t" + n[i] + "\t\t" + co_previous[i] + "\t\t" + co_self[i] + "\t\t" + ca_previous[i] + "\t\t" + ca_self[i] + "\t\t" + cb_previous[i] + "\t\t" + cb_self[i] + "\n"
	linestring = id[i] + "\t\t" + str(hn[i]) + "\t\t" + str(n[i]) + "\t\t" + str(co_previous[i]) + "\t\t" + str(co_self[i]) + "\t\t" + str(ca_previous[i]) + "\t\t" + str(ca_self[i]) + "\t\t" + str(cb_previous[i]) + "\t\t" + str(cb_self[i]) + "\n"
	f.write(linestring)
f.close()



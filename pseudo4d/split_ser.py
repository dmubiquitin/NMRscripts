#!/usr/bin/python2.7
from __future__ import division
from sys import path, argv
path.append("/home1/rennella/erpy")
if 1/2!=0.5: print "According to Python, 1/2 makes "+str(1/2)+"! Be sure that the statement 'from __future__ import division' is included!"; quit()
if argv[1] in ['-h','-help','--h','--help']: 
  print "#################################################################################"
  print "# Home written python program to split a Bruker ser file in several subspectra. #"
  print "# It accepts up to 4D data, made by either in series or interleaved subspectra. #"
  print "# Usage: split_ser.py XXX , where XXX is the directory containing bruker data.  #"
  print "# 06.06.2014 Enrico                                                             #"
  print "#################################################################################"
  quit()

from erpy import readPAR, readPAR2, readPAR3, readPAR4
from numpy import fromfile, array, concatenate, hstack, zeros, sort
from glob import glob
from subprocess import call

if len(argv)!=2: print "Uncorrect usage. Type 'split_ser.py -help' for information."; quit()
ser=fromfile(argv[1]+'/ser','i4')
if glob(argv[1]+'/acqu4s')==[argv[1]+'/acqu4s']:
  resser=ser.reshape(int(readPAR4(argv[1],'TD')),int(readPAR3(argv[1],'TD')),int(readPAR2(argv[1],'TD')),int(len(ser)/(readPAR4(argv[1],'TD')*readPAR3(argv[1],'TD')*readPAR2(argv[1],'TD'))))
#  resser=resser[:,:,:,:readPAR(argv[1],'TD')]
elif glob(argv[1]+'/acqu3s')==[argv[1]+'/acqu3s']:
  resser=ser.reshape(int(readPAR3(argv[1],'TD')),int(readPAR2(argv[1],'TD')),int(len(ser)/(readPAR3(argv[1],'TD')*readPAR2(argv[1],'TD'))))
#  resser=resser[:,:,:readPAR(argv[1],'TD')]
elif glob(argv[1]+'/acqu2s')==[argv[1]+'/acqu2s']:
  resser=ser.reshape(int(readPAR2(argv[1],'TD')),int(len(ser)/readPAR2(argv[1],'TD')))
#  resser=resser[:,:readPAR(argv[1],'TD')]
else:
  print "Neither acqu2s, acqu3s or acqu4s were found. Program will be termined!"; quit()

oldshape=resser.shape

print "The input bruker data has dimensions:"
print str(tuple(['F1','F2','F3','F4'])[:len(oldshape)])
print oldshape
print "Enter now the desired dimensions of the subspectra in the same format as before (just change 1 dimension - not the direct one - and use exact dividers!!):"
newshape = eval(raw_input("desired shape : "))

if len(oldshape)!=len(newshape): print "The same number of dimensions should be used. Program will be termined!"; quit()

if (array(oldshape)%array(newshape)).sum()>0: print "You did not use exact dividers. Program will be termined!"; quit()

if oldshape[-1]!=newshape[-1]: print "It's not possible to change the direct dimension. Program will be termined!"; quit()

if len(array(range(len(oldshape)))[array(oldshape)!=array(newshape)])==0:
  print "No difference between the input and desired dimensions. Program will be termined!"; quit()
elif len(array(range(len(oldshape)))[array(oldshape)!=array(newshape)])>1:
  print "It is not possible to modify more than just 1 dimension. Program will be termined!"; quit()

print "Are the subspectra interleaved?"
intrlv_flg = str(raw_input("y or n : "))
if intrlv_flg=='n':
  if array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==0:
    newser=array([resser[newshape[0]*i:newshape[0]*(i+1)] for i in range(int((array(oldshape)/array(newshape))[0]))])
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==1:
    newser=array([resser[:,newshape[1]*i:newshape[1]*(i+1)] for i in range(int((array(oldshape)/array(newshape))[1]))])
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==2:
    newser=array([resser[:,:,newshape[2]*i:newshape[2]*(i+1)] for i in range(int((array(oldshape)/array(newshape))[2]))])
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==3:
    newser=array([resser[:,:,:,newshape[3]*i:newshape[3]*(i+1)] for i in range(int((array(oldshape)/array(newshape))[3]))])
  else:
    print "Program does not support 5D or higher. Program will be termined!"; quit()
else:
  print "Enter the number of consecute blocks that should enter in each interleaved subspectrum (e.g. 2 for quadrature detection in the inner loop)"
  Nblocks = int(eval(raw_input("number of consecutive blocks : ")))
  if array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==0:
    if newshape[0] % Nblocks > 0 : print "The number of blocks is not an exact dividers of the desired spectral dimension. Program will be termined!"; quit()
    newser=array([resser[array([hstack((array([0 for i in range(Nblocks*k)]),array([1 for i in range(Nblocks)]),array([0 for i in range(Nblocks*(int((array(oldshape)/array(newshape))[0])-k-1))]))) for j in range(int(newshape[0]/Nblocks))]).ravel()==1] for k in range(int((array(oldshape)/array(newshape))[0]))])
#    newser=array([resser[sort(hstack((array(range(2*i,resser.shape[0],2*int((array(oldshape)/array(newshape))[0]))),array(range(2*i+1,resser.shape[0],2*int((array(oldshape)/array(newshape))[0]))))))] for i in range(int((array(oldshape)/array(newshape))[0]))])
#    newser=array([resser[i::int((array(oldshape)/array(newshape))[0])] for i in range(int((array(oldshape)/array(newshape))[0]))])
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==1:
    if newshape[1] % Nblocks > 0 : print "The number of blocks is not an exact dividers of the desired spectral dimension. Program will be termined!"; quit()
    newser=array([resser[:,array([hstack((array([0 for i in range(Nblocks*k)]),array([1 for i in range(Nblocks)]),array([0 for i in range(Nblocks*(int((array(oldshape)/array(newshape))[1])-k-1))]))) for j in range(int(newshape[1]/Nblocks))]).ravel()==1] for k in range(int((array(oldshape)/array(newshape))[1]))])
#    newser=array([resser[:,sort(hstack((array(range(2*i,resser.shape[1],2*int((array(oldshape)/array(newshape))[1]))),array(range(2*i+1,resser.shape[1],2*int((array(oldshape)/array(newshape))[1]))))))] for i in range(int((array(oldshape)/array(newshape))[1]))])
#    newser=array([resser[:,i::int((array(oldshape)/array(newshape))[1])] for i in range(int((array(oldshape)/array(newshape))[1]))])
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==2:
    if newshape[2] % Nblocks > 0 : print "The number of blocks is not an exact dividers of the desired spectral dimension. Program will be termined!"; quit()
    newser=array([resser[:,:,array([hstack((array([0 for i in range(Nblocks*k)]),array([1 for i in range(Nblocks)]),array([0 for i in range(Nblocks*(int((array(oldshape)/array(newshape))[2])-k-1))]))) for j in range(int(newshape[2]/Nblocks))]).ravel()==1] for k in range(int((array(oldshape)/array(newshape))[2]))])
#    newser=array([resser[:,:,sort(hstack((array(range(2*i,resser.shape[2],2*int((array(oldshape)/array(newshape))[2]))),array(range(2*i+1,resser.shape[2],2*int((array(oldshape)/array(newshape))[2]))))))] for i in range(int((array(oldshape)/array(newshape))[2]))])
#    newser=array([resser[:,:,i::int((array(oldshape)/array(newshape))[2])] for i in range(int((array(oldshape)/array(newshape))[2]))])
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==3:
    if newshape[3] % Nblocks > 0 : print "The number of blocks is not an exact dividers of the desired spectral dimension. Program will be termined!"; quit()
    newser=array([resser[:,:,:,array([hstack((array([0 for i in range(Nblocks*k)]),array([1 for i in range(Nblocks)]),array([0 for i in range(Nblocks*(int((array(oldshape)/array(newshape))[3])-k-1))]))) for j in range(int(newshape[3]/Nblocks))]).ravel()==1] for k in range(int((array(oldshape)/array(newshape))[3]))])
#    newser=array([resser[:,:,:,sort(hstack((array(range(2*i,resser.shape[3],2*int((array(oldshape)/array(newshape))[3]))),array(range(2*i+1,resser.shape[3],2*int((array(oldshape)/array(newshape))[3]))))))] for i in range(int((array(oldshape)/array(newshape))[3]))])
#    newser=array([resser[:,:,:,i::int((array(oldshape)/array(newshape))[3])] for i in range(int((array(oldshape)/array(newshape))[3]))])
  else:
    print "Program does not support 5D or higher. Program will be termined!"; quit()
#newser=concatenate((newser,zeros(hstack((newser.shape[:-1],int(2.**array(range(30))[2.**array(range(30))>=newser.shape[-1]][0]-newser.shape[-1]))))),axis=-1)
for root in range(1000,10000,10):
  print "Trying to save splitted experiments in directories "+str([str(root+i) for i in range(newser.shape[0])])
  flg=0
  for i in range(newser.shape[0]):
    if glob(str(root+i))==[str(root+i)]: 
      print "The directory "+str(root+i)+" already exists. Overwrite it?"
      answer = str(raw_input(" y or n : "))
      if answer!='y': flg=1; break
  if flg==0: break
fileT=[]
for i in range(newser.shape[0]):
  if glob(str(root+i))==[str(root+i)]: call(['rm','-r',str(root+i)])
  call(['cp','-r',argv[1],str(root+i)])
  if array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==len(oldshape)-1:
    with open(str(root+i)+'/acqus','r') as file:
      data=file.readlines()
    data[array(range(len(data)))[array(data)=='##$TD= '+str(int(readPAR(argv[1],'TD')))+'\n'][0]]='##$TD= '+str(newshape[len(oldshape)-1])+'\n'
    with open(str(root+i)+'/acqus','w') as file:
      file.writelines(data)
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==len(oldshape)-2:
    with open(str(root+i)+'/acqu2s','r') as file:
      data=file.readlines()
    data[array(range(len(data)))[array(data)=='##$TD= '+str(oldshape[len(oldshape)-2])+'\n'][0]]='##$TD= '+str(newshape[len(oldshape)-2])+'\n'
    with open(str(root+i)+'/acqu2s','w') as file:
      file.writelines(data)
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==len(oldshape)-3:
    with open(str(root+i)+'/acqu3s','r') as file:
      data=file.readlines()
    data[array(range(len(data)))[array(data)=='##$TD= '+str(oldshape[len(oldshape)-3])+'\n'][0]]='##$TD= '+str(newshape[len(oldshape)-3])+'\n'
    with open(str(root+i)+'/acqu3s','w') as file:
      file.writelines(data)
  elif array(range(len(oldshape)))[array(oldshape)!=array(newshape)][0]==len(oldshape)-4:
    with open(str(root+i)+'/acqu4s','r') as file:
      data=file.readlines()
    data[array(range(len(data)))[array(data)=='##$TD= '+str(oldshape[len(oldshape)-4])+'\n'][0]]='##$TD= '+str(newshape[len(oldshape)-4])+'\n'
    with open(str(root+i)+'/acqu4s','w') as file:
      file.writelines(data)
  else:
    print "Program does not support 5D or higher. Program will be termined!"; quit()
  newser[i].tofile(str(root+i)+'/ser')
  fileT.append(str(root+i)+'/ser')
print "Saved n."+str(newser.shape[0])+" splitted ser files with names: "+str(fileT)


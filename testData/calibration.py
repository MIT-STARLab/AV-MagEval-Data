# -*- coding: utf-8 -*-
"""
Created on Mon Mar 15 22:51:09 2021

@author: nickb
"""

import numpy as np
import pickle
import itertools
from scipy.optimize import least_squares
from scipy.spatial.transform import Rotation
from numpy.linalg import norm
import matplotlib.pyplot as plt



class Magnetometer():
    #Holds a calibration state
    def __init__(self):
        self.S=np.identity(3) #Sensitivity matrix
        #self.KS=np.zeros((3,3)) #Sensitivity matrix temperature dependence
        self.O=np.zeros((3)) #Offset vector
        #self.KO=np.array([0,0,0]) #Offset vector temperature dependence
        
    def get_coeffs(self):
        #np.concatenate([i.flatten() for i in [self.S,self.KS,self.O,self.KO]])
        return np.concatenate([i.flatten() for i in [self.S,self.O]])
        
    def update_from_coeffs(self,coeffs):
        self.S=np.reshape(coeffs[0:9],(3,3))
        self.O=coeffs[9:12]
        # self.KS=np.reshape(coeffs[9:18],(3,3))
        # self.O=coeffs[18:21]
        # self.KO=coeffs[21:24]
        
    def print(self):
        print("Sensitivity Matrix:")
        print(self.S)
        print("Offset Vector:")
        print(self.O)

class Calibrate():
    #Measurements are row vectors
    def __init__(self):
        self.cal=Magnetometer()
        self.result=[None,None,None]

    def residual_axis(self,coeffs,mydata,refdata,axis):
        self.cal.S[axis,:]=coeffs[0:3]
        self.cal.O[axis]=coeffs[3]
        res=abs(self.apply(mydata) - refdata)[:,axis]
        return res
        
    def calibrate_axis(self,mydata,refdata,axis):
        assert mydata.shape==refdata.shape
        assert mydata.shape[0]>mydata.shape[1]
        
        x0=np.concatenate([i.flatten() for i in [self.cal.S[axis,:],self.cal.O[axis]]])
        lsq_res = least_squares(self.residual_axis, x0, args=(mydata, refdata, axis))
        self.result[axis]=lsq_res
        print("Axis ",axis," cost is ",lsq_res.cost)
        return lsq_res
    
    def calibrate(self,mydata,refdata):
        for i in range(3):
            self.calibrate_axis(mydata,refdata,i)
                  
    def apply(self,data):
        """Apply calibration to get actual B from measured B"""
        result=[]
        for Bm in data: #Result is size (3,)
            #Ba = """np.matmul((self.S+self.KS*t),Bm) + """(self.O + self.KO*t)# - np.matmul(self.D,i)
            Ba=np.matmul((self.cal.S),Bm)+(self.cal.O)
            result.append(Ba)
        return np.array(result)
    
    def print(self):
        self.cal.print()
        

    
data=np.loadtxt("data/data1.csv",skiprows=1,delimiter=',')
# data2=np.loadtxt("data6.csv",skiprows=1,delimiter=',')
# data3=np.loadtxt("data7.csv",skiprows=1,delimiter=',')
# data4=np.loadtxt("data8.csv",skiprows=1,delimiter=',')
#data=np.concatenate((data1,data2,data3,data4))

test_mes=data[:,1:4]
ref_mes=data[:,7:10]

mycal=Calibrate()

mycal.calibrate(test_mes,ref_mes)

mycal.print()

cal_mes=mycal.apply(test_mes)

def plot3(data,style):
    mydat=np.transpose(data)
    colors = ['r','g','b']
    axes=["X","Y","Z"]
    for (col,dat,axis) in zip(colors,mydat,axes):
        plt.plot(dat,color=col,label=axis,linestyle=style)

plot3(ref_mes,"--")
plt.legend()
plot3(test_mes,":")
plot3(cal_mes,"solid")

diff=cal_mes-ref_mes
plt.figure(2)

plot3(diff,"solid")

dv=norm(diff,axis=1)
print("RMS Vector Residual is ",np.sqrt(np.mean(dv**2)))
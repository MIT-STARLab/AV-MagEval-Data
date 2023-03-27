# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np
import matplotlib.pyplot as plt


mydat=np.loadtxt(open("data/data2.csv", "rb"), delimiter=",", skiprows=1)

relt=mydat[:,0]-mydat[0,0]

plt.plot(relt,mydat[:,1],label="Test X")
plt.plot(relt,mydat[:,2],label="Test Y")
plt.plot(relt,mydat[:,3],label="Test Z")
plt.legend()
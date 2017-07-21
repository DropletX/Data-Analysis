# data.py
import numpy as np
import numpy.random as rnd

rnd.seed(2342)
X1 = 2.0*rnd.rand(100,1)
X2 = 2.0*rnd.rand(100,1)
y = 4.0 + 3.0*X1 + X2 + rnd.randn(100,1)

with open("data.dat","w") as f:
    for i in range(len(X1)):
        f.write("%f\t%f\t%f\n"%(X1[i],X2[i],y[i]))

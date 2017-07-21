# normal_equation.py
import numpy as np
import numpy.linalg as linalg

# Load data
data = np.loadtxt(fname="data.dat",dtype=np.float32)
# Create X_0 term
X0 = np.array([[1.0 for _ in range(len(data))]])
X1 = np.array([[ele[0] for ele in data]])
X2 = np.array([[ele[1] for ele in data]])
X = np.concatenate((X0,X1,X2),axis=0).T
y = np.array([[ele[2] for ele in data]]).T
theta = np.matmul(linalg.inv(np.matmul(X.T,X)),np.matmul(X.T,y))
print(theta)

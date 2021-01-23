from tosol import tosol
import numpy as np
from kaucherpy import Kaucher
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

A = [[Kaucher(4, 6), Kaucher(5, 7)],
     [Kaucher(2, 4), Kaucher(1, 3)],
     [Kaucher(6, 8), Kaucher(3, 5)]]

b = [[Kaucher(2, 4.4)], [Kaucher(1, 2.7)], [Kaucher(3.4, 5.6)]]

infA = np.array([[3, 6], [2, 1], [5, 4]])
supA = np.array([[8, 9], [4, 5], [9, 7]])
infb = np.array([[1.5], [0.8], [3]])
supb = np.array([[5], [3], [6]])

x = np.arange(-2, 2, 0.05)
y = np.arange(-2, 2, 0.05)

dim = x.shape[0]

X, Y = np.meshgrid(x, y)
z = np.zeros((dim, dim))
for i in range(dim):
    for j in range(dim):
        arg = np.array([[x[i]], [y[j]]])
        z[i, j] = tosol(arg, infA, supA, infb, supb)

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(X, Y, z)
ax.set_xlabel('x_1')
ax.set_ylabel('x_2')
ax.set_zlabel('x_3')
plt.savefig('tol.png', format='png')
plt.show()

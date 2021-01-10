from tosol import tosol
import numpy as np
from kaucherpy import Kaucher
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

A = [[Kaucher(4, 6), Kaucher(5, 7)],
     [Kaucher(2, 4), Kaucher(1, 3)],
     [Kaucher(6, 8), Kaucher(3, 5)]]

b = [[Kaucher(2, 4.4)], [Kaucher(1, 2.7)], [Kaucher(3.4, 5.6)]]

infA = np.array([[4, 5], [2, 1], [6, 3]])
supA = np.array([[6, 7], [4, 3], [8, 5]])
infb = np.array([[2], [1], [3.4]])
supb = np.array([[4.4], [2.7], [5.6]])

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
ax.plot_surface(X, Y, z, cmap='viridis')
ax.set_xlabel('x_1')
ax.set_ylabel('x_2')
ax.set_zlabel('Tol(x_1, x_2)')
plt.savefig('tol.png', format='png')
plt.show()

import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt
from tolsolvty import tolsolvty

A = np.loadtxt("a.txt")
inf_b = np.loadtxt("b_inf.txt").reshape(3, 1)
sup_b = np.loadtxt("b_sup.txt").reshape(3, 1)
[tolmax, argmax, envs, ccode] = tolsolvty(A, A, inf_b, sup_b)

print(f"tolmax: {tolmax[0]}")
oldtolmax = tolmax[0]

diag_rad_b = np.diag(np.squeeze(np.asarray(0.5 * (sup_b - inf_b))))

C = np.block([[-A, -diag_rad_b],
              [A, -diag_rad_b]])
print("C:\n", C)

mid_b = 0.5 * (inf_b + sup_b)
r = np.concatenate([-mid_b, mid_b])
print("r:\n", r)

pos_sign = (0, +np.inf)
any_sign = (-np.inf, +np.inf)
str_sign = (0, -tolmax[0])


x = []
y = []
for i in range(10):
    res = opt.linprog([0, 0, 0, 1, 1, 1],
                          A_ub=C,
                          b_ub=r,
                          bounds=[any_sign, (i,i+1), any_sign,
                                  pos_sign, pos_sign, pos_sign],
                          method='interior-point')
    u = res.x
    x.append(u[1])
    y.append(u[2])

print(f"x: {x}")
print(f"y: {y}")
plt.plot(x, y)
plt.xlabel('u2')
plt.ylabel('u3')
plt.title('u3(u2)')
plt.grid()
plt.show()

import numpy as np
import scipy.optimize as opt
from tolsolvty import tolsolvty

A = np.loadtxt("A.txt")
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

res = opt.linprog([0, 0, 0, 1, 1, 1],
                      A_ub=C,
                      b_ub=r,
                      bounds=[any_sign, any_sign, any_sign,
                              pos_sign, pos_sign, pos_sign],
                      method='interior-point')
print('res = ', res.x)
print('status: ', res.status)

#inf_b -= np.asarray([-tolmax[0]] * 3).reshape(3, 1)#res.x[-3:].reshape(3, 1)
#sup_b += np.asarray([-tolmax[0]] * 3).reshape(3, 1)#res.x[-3:].reshape(3, 1)
#[tolmax, argmax, _, __] = tolsolvty(A, A, inf_b, sup_b)
#
#print("max Tol = ", tolmax, "argmax = ", argmax)
#
#print(np.matmul(A, argmax) - inf_b, sup_b - np.matmul(A, argmax))
#
#xx = np.concatenate((argmax,
#                     np.asarray(
#                         [-oldtolmax / diag_rad_b[0, 0], -oldtolmax / diag_rad_b[1, 1], -oldtolmax / diag_rad_b[2, 2]]).
#                     reshape(3, 1)), axis=0)
#print("Cx - r = ", np.matmul(C, xx) - r)
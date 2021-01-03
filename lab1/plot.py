### plot of eps(n) 
import numpy as np

n = [2,3,4,5,6,7,8,9,10,11]
eps = [1, 0.594, 0.419, 0.323, 0.262, 0.213, 0.182, 0.144, 0.124, 0.110]

import matplotlib.pyplot as plt
fig, ax = plt.subplots()
ax.plot(n, eps, color="red", label="eps(n)")
ax.set_xlabel("n")
ax.set_ylabel("eps")
plt.show()
from tolsolvty import tolsolvty
import numpy as np

A = np.array([
    [1.5, 2, 3],
    [2, 2, 3],
    [1, 0, 0]
])

b_inf = np.array([[1.5], [6], [-0.5]])
b_sup = np.array([[2.2], [7.3], [1]])

def main():
    tolmax, argmax, envs, ccode = tolsolvty(A, A, b_inf, b_sup)
    print(f"Tolmax: {tolmax}")

if __name__ == '__main__':
    main()

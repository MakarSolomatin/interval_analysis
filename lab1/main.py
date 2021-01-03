import numpy as np


def mid(n, eps):
    A = np.identity(n)
    value = eps / 2
    for i in range(1, n):
        for j in range(i, n):
            A[i, j] = A[j, i] = value

def rad(n, eps):
    A = np.zeros((n, n))
    value = eps / 2
    for i in range(1, n):
        for j in range(i, n):
            A[i, j] = A[j, i] = value


def ro(mid, rad):
    inv = np.linalg.inv(mid)
    inv_det = np.linalg.det(inv)
    m = rad * inv_det
    w, v = np.linalg.eig(m)
    return max([abs(e) for e in w])


def task1(n, precision):
    delta = 100
    left = 0
    right = eps = 500
    while True:
        center = (right - left) / 2
        if (right - left < precision):
            return center

        if (ro(mid(n, center), rad(n, center)) < 1):
            left = center
        else:
            right = center

def main():
    result = task1(10, 0.1)
    print(result)


if __name__ == '__main__':
    main()

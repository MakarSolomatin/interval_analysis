from interval import Interval
from functools import reduce
from functions import rastrygin, rosenbrok, simple, matyas
import operator

def globopt(f, X: [Interval], eps: float) -> float:
    Y = X
    y = f(*Y).l
    L = [(Y, y)]

    while f(*Y).len >= eps:
        print(f"y: {y}")
        volume = reduce(lambda acc, x: acc * x.len, Y, 1)
        print(f"Y: {Y[0]}, {Y[1]}")
        print("volume: " + str(volume))

        lengths = [x.len for x in Y]
        l, _ = max(enumerate(lengths), key=operator.itemgetter(1))

        Y1 = list(Y)
        Y1[l] = Interval(Y[l].l, Y[l].mid)
        v1 = f(*Y1).l
        print(f"v1: {v1}")

        Y2 = list(Y)
        Y2[l] = Interval(Y[l].mid, Y[l].r)
        v2 = f(*Y2).l
        print(f"v2: {v2}")

        i = L.index((Y, y))
        del L[i]

        if v1 < v2:
            L.append((Y1, v1))
            L.append((Y2, v2))
        else:
            L.append((Y2, v2))
            L.append((Y1, v1))
        
        Y, y = L[-1]
        print("--")
    return Y, y 

def main():
    Y, y = globopt(rosenbrok, [Interval(-30, 30), Interval(-30, 30)], 0.01)
    print([str(w) for w in Y])
    print(y)

if __name__ == '__main__':
    main()

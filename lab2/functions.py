from math import cos, pi, floor
from interval import Interval

def cosi(x):
    if isinstance(x, Interval):
        if x.length() > 2 * pi:
            return Interval(-1, 1)
        
        n = floor(x.l / 2 / pi)
        y = x - n * 2 * pi
        
        if y.l <= pi:
            if y.r <= pi:
                return Interval(cos(y.r), cos(y.l))
            else:
                return Interval(-1, max(cos(y.r), cos(y.l)))
        else:
            return Interval(cos(y.l), cos(y.r))
    return cos(x)


def simple(x, y): 
    return x * x + y * y


def rastrygin(x, y):
    return x * x + y * y - cosi(x * 18) - cosi(y * 18)


def rosenbrok(x, y):
    return (x * x - y) * (x * x - y) * 100 - (x - 1) * (x - 1)


def matyas(x, y):
    return (x * x + y * y) * 0.26 - x * y * 0.48

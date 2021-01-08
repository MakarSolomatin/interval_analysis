class Interval:
    def __init__(self, left=0, right=1):
        self.l = left
        self.r = right
        self.mid = (left + right) / 2
        self.len = right - left


    def __str__(self):
        return f"[{self.l}, {self.r}]"


    def __add__(self, other):
        if isinstance(other, Interval):
            return Interval(self.l + other.l, self.r + other.r)
        return Interval(self.l + other, self.r + other)


    def __sub__(self, other):
        if isinstance(other, Interval):
            return Interval(self.l - other.r, self.r - other.l)
        return Interval(self.l - other, self.r - other)


    def __mul__(self, other):
        if isinstance(other, Interval):
            l = [self.l * other.l, self.r * other.l, self.l * other.r, self.r * other.r]
            return Interval(min(l), max(l))
        return Interval(self.l * other, self.r * other)


    def __contains(self, item):
        return self.l <= item <= self.r


    def __truediv__(self, other):
        if isinstance(other, Interval):
            if 0 in other:
                raise ZeroDivisionError
            return self * Interval(1 / other.r, 1 / other.l)
        if other == 0:
            raise ZeroDivisionError
        return Interval(self.l / other, self.r / other)

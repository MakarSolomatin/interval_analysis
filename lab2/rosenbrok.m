function Y = rosenbrok(X)
  Y = 100 * (X(2) - X(1) .^ 2) .^ 2 + (X(1) - 1) .^ 2
endfunction
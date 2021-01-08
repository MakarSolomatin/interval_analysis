function Y = rastrigin(X)
  Y = X(1) .^ 2 + X(2) .^ 2 - cos(18 * X(1)) - cos(18 * X(2));
endfunction
f = @(x)  - (x^2 + x)*cos(x);
options = optimoptions('ga', 'PlotFcn', 'gaplotbestf')
[x, fval, exitflag, output] = ga(f, 1, [],[],[],[], -10, 10, [], options) 
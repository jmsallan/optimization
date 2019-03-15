nonlcon = @rosenbrock_constraints;
fun = @rosenbrock;
A = [1, 1];
b = 2;
options = optimoptions('ga', 'PlotFcn', 'gaplotbestf')
[x, fval, exitflag, output] = ga(fun, 2, A, b, [], [], [], [], nonlcon, options)

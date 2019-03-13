lb = [0; 0];
ub = [1; 13];
nonlcon = @cam_constraints;
fun = @cam_function;
options = optimoptions('ga', 'ConstraintTolerance', 1e-6, 'PlotFcn', 'gaplotbestf')
[x, fval, exitflag, output] = ga(fun, 2, [],[],[],[], lb, ub, nonlcon, options)
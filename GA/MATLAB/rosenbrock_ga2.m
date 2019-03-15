rng(1);
nonlcon = @rosenbrock_constraints2;
fun = @rosenbrock;
%options = optimoptions('ga', 'PlotFcn', 'gaplotbestf')
hybridopts = optimoptions('fmincon','Display','iter','Algorithm','interior-point');
options = optimoptions('ga', 'MaxGenerations', 1500, 'MaxStallGenerations', 300,  'PlotFcn', 'gaplotbestf', 'HybridFcn',{@fmincon,hybridopts})
[x, fval, exitflag, output] = ga(fun, 2, [], [], [], [], [], [], nonlcon, options)

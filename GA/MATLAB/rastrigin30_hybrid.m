rng default;
fun = @rastriginsfcn;
n = 30;
hybridopts = optimoptions('fminunc','Display','iter','Algorithm','quasi-newton');
options = optimoptions('ga', 'MaxGenerations', 1500, 'MaxStallGenerations', 300,  'PlotFcn', 'gaplotbestf', 'HybridFcn',{@fminunc,hybridopts})
[x,fval,exitflag] = ga(fun, n, [],[],[],[],[],[],[], options)

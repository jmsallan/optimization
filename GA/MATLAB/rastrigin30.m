rng default;
options = optimoptions('ga', 'MaxGenerations', 1500, 'MaxStallGenerations', 300,  'PlotFcn', 'gaplotbestf')
[x,fval,exitflag] = ga(@rastriginsfcn, 30, [],[],[],[],[],[],[], options)

options = optimoptions('ga', 'MaxGenerations', 1000, 'MaxStallGenerations', 300,  'PlotFcn', 'gaplotbestf')
[x,fval,exitflag] = ga(@rastriginsfcn, 2, [],[],[],[],[],[],[], options)
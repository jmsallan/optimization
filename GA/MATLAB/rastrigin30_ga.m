rng default;
%options = optimoptions('ga', 'MaxGenerations', 1500, 'MaxStallGenerations', 300,  'PlotFcn', 'gaplotbestf')
hybridopts = optimoptions('fminunc','Display','iter','Algorithm','quasi-newton');
options = optimoptions('ga', 'MaxGenerations', 1500, 'MaxStallGenerations', 300,  'PlotFcn', 'gaplotbestf', 'HybridFcn',{@fminunc,hybridopts})
[x,fval,exitflag] = ga(@rastriginsfcn, 30, [],[],[],[],[],[],[], options)

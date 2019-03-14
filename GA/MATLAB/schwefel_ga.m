f = @schwefel;
rng default;
n = 30;
% pmut = 0.1;
popsize = 80*n;
%lbound = zeros(1,n) - 500;
%ubound = zeros(1,n) + 500;
lbound = zeros(n,1) - 500;
ubound = zeros(n,1) + 500;
% options = optimoptions('ga', 'PlotFcn', 'gaplotbestf')
options = optimoptions('ga', 'PopulationSize', popsize, 'PlotFcn', 'gaplotbestf')
% options = optimoptions('ga', 'Populationsize', popsize, 'MutationFcn', {@mutationuniform, pmut}, 'PlotFcn', 'gaplotbestf')
[x, fval, exitflag, output] = ga(f,n,[],[],[],[],lbound,ubound,[], options)



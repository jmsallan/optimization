options = optimoptions('ga', 'PlotFcn', 'gaplotbestf')
[x, fval, exitflag, output] = ga(@cosfunction, 1, [],[],[],[], -10, 10, [], options) 
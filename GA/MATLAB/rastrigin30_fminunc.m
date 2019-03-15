rng default;
func = @rastriginsfcn;
fminuncoptions = optimoptions('fminunc', 'Display', 'iter', 'Algorithm', 'quasi-newton')
[x, fval] = fminunc(func, zeros(30,1), fminuncoptions)
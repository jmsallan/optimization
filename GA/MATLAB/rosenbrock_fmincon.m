rng default;
nonlcon= @rosenbrock_constraints2;
fminconoptions = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point')
[x, fval] = fmincon(@rosenbrock, [0, 0], [], [], [], [], [], [], nonlcon, fminconoptions)
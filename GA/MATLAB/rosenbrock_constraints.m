function [c, ceq] = rosenbrock_constraints(x)
c = (x(1)-1)^3 - x(2) + 1;
ceq = [];
end
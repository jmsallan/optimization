function [c, ceq]=cam_constraints (x)
c(1) = x(1)*x(2) + x(1) - x(2) + 1.5; 
c(2) = 10 - x(1)*x(2); 
ceq = [];
end
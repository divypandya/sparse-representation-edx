function x = lp(A, b, tol)
% LP Solve Basis Pursuit via linear programing
%
% Solves the following problem:
%   min_x || x ||_1 s.t. b = Ax
%
% The solution is returned in the vector x.


% Set the options to be used by the linprog solver
options = optimoptions('linprog','Algorithm','dual-simplex',...
    'Display','none','OptimalityTolerance',tol);

% TODO: Use Matlab's linprog function to solve the BP problem
% Write your code here... x = ????;

nrows = size(A,1);
ncols = size(A,2);

% f = [zeros(ncols, 1); ones(ncols, 1)];
% Ale = [eye(ncols,ncols), -eye(ncols,ncols); -eye(ncols,ncols), -eye(ncols,ncols)];
% ble = zeros(2 * ncols, 1);
% Aeq = [A, zeros(nrows, ncols)];
% beq = b;
% sol = linprog(f, Ale, ble, Aeq, beq, [], [], options);
% x = sol(1:ncols);

% splitting X into the positive and negative entries x=u-v, u,v>=0
f = ones(2 * ncols, 1);
Aeq = [A, -A];
beq = b;
lb = zeros(2 * ncols, 1);
%ub = inf([2 * ncols, 1]);
sol = linprog(f, [], [], Aeq, beq, lb, [], options);
x = sol(1:ncols) - sol(ncols+1:2*ncols);

end

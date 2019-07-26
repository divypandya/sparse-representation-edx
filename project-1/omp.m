function x = omp(A, b, k)
% OMP Solve the P0 problem via OMP
%
% Solves the following problem:
%   min_x ||b - Ax||_2^2 s.t. ||x||_0 <= k
%
% The solution is returned in the vector x

% Initialize the vector x
x = zeros(size(A,2),1);

% TODO: Implement the OMP algorithm
% Write you code here... x = ????;
r = b;
supp = [];
for s = 1 : k
    [~, idx] = max(abs(A' * r));
    supp = [supp idx];
    As = A(:, supp);
    x(supp) = pinv(As) * b;
    r = b - A*x;
end
end


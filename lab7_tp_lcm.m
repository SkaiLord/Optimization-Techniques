%% Transportation Problem using least cost matrix

format short;
clc
clear all
Cost=[11 20 7 8; 21 16 10 12; 8 12 18 9];
A=[50 40 70];
B=[30 25 35 40];

if sum(A) == sum(B)
    fprintf('Given transportation problem is balanced\n')
else
    fprintf('Given transportation problem is unbalanced\n')
    if sum(A) < sum(B)
        Cost(end+1, :) = zeros(1, size(B,2));
        A(end+1) = sum(B) - sum(A);
    elseif sum(B) < sum(A)
        Cost(:, end+1) = zeros(1,size(A, 2));
        B(end+1) = sum(A) - sum(B);
    end
end

Icost = Cost
X = zeros(size(Cost));
[m, n] = size(Cost);
BFS = m + n - 1;

for i=1:m
    for j=1:n
        cs = min(Cost(:));
        [RowIndex, ColIndex] = find(cs == Cost);
        x11 = min(A(RowIndex), B(ColIndex));
        [value, Index] = max(x11);
        ii = RowIndex(Index);
        jj = ColIndex(Index);
        y11 = min(A(ii), B(jj));
        X(ii, jj) = y11;
        A(ii) = A(ii) - y11;
        B(jj) = B(jj) - y11;
        Cost(ii, jj) = Inf;
    end
end

fprintf('Initial BFS\n');
IBFS = array2table(X);
disp(IBFS);

TotalBFS = length(nonzeros(X));
if TotalBFS == BFS
    fprintf('Initial BFS is non degenerate\n')
else
    fprintf('Initial BFS is degenerate\n')
end

InitialCost = sum(sum(Icost .* X))
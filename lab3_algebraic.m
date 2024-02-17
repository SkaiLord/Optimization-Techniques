clc;
clear all;
format short;

%% Input Parameters
A=[3 -1 1 1 0 0;-1 2 0 0 1 0; -4 3 8 0 0 1];   %% Constraint Values
b=[7; 6 ;10];               %% RHS of constraint
C=[-1 3 -3 0 0 0];                 %% Cost of LPP

%% No.of constraints and variables
[m,n] = size(A);        %% No.of constraints, vars (2, 4)

%% Compute nCm BFS
nv = nchoosek(n,m);     %% Total basic solns
t = nchoosek(1:n,m);    %% Pairs of basic solns

%% Construct Basic Soln
soln = [];
if n>=m
    for i=1:nv
        y=zeros(n,1);
        x=A(:,t(i,:))\b;    %% inv(A)*b or A\b==A^-1*b
        if all(x>=0 & x~=inf & x~=-inf) %%check for feasibility
            y(t(i,:)) = x;
            soln = [soln y];
        end
    end
else
    error('Equations is large than variables')
end

%% Objective Function
Z=C*soln;

%% Finding optimal value
[Zmax, Zind] = max(Z);
BFS = soln(:,Zind);

%% Print all solutions
optval = [BFS' Zmax];
OPTIMAL_BFS = array2table(optval);
OPTIMAL_BFS.Properties.VariableNames(1:size(OPTIMAL_BFS,2)) = {'x_1','x_2','x_3','s_1','s_2','s_3','Value_of_Z'}


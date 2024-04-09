format short;
clc;
clear all;

%% Input Parameters
Variables = {'x_1','x_2','x_3','s_1','s_2','A_1','A_2','Soln'};
OVariables = {'x_1','x_2','x_3','s_1','s_2','Soln'};
OrigC = [-7.5 3 0 0 0 -1 -1 0];         % Maximizing Function
Info=[3 -1 -1 -1 0 1 0 3;
      1 -1 1 0 -1 0 1 2];               % Constraint Values
b=[3; 2];                               % RHS of constraint
BV = [6 7];

%% Phase 1
Cost = [0 0 0 0 0 -1 -1 0];
A = Info;
StartBV = find(Cost<0);                 % Get artificial variables

% Compute values of table
ZjCj = Cost(BV)*A - Cost;
InitialTable = array2table([ZjCj;A]);
InitialTable.Properties.VariableNames(1:size(A,2)) = Variables

fprintf('\n===== PHASE 1 =====\n\n');
[BFS, A] = simp(A, BV, Cost, Variables);

%% Phase 2
fprintf('\n===== PHASE 2 =====\n\n');
A(:, StartBV) = [];     % Remove artificial variable column
OrigC(:,StartBV) = [];  % Remove artificial variable cost
[OptBFS, OptA] = simp(A, BFS, OrigC, OVariables);

%% Final Optimal BFS
FINAL_BFS = zeros(1,size(A,2));
FINAL_BFS(OptBFS) = OptA(:,end);
FINAL_BFS(end) = sum(FINAL_BFS.*OrigC);

OPTIMAL_BFS = array2table(FINAL_BFS);
OPTIMAL_BFS.Properties.VariableNames(1:size(OPTIMAL_BFS,2)) = OVariables
clc;
clear all;

%% Input Parameters
Variables = {'x_1','x_2','s_1','s_2','A_1','A_2','Soln'};
M=10000;
Cost = [-3 -5 0 0 -M -M 0];    % cost function
A = [1 3 -1 0 1 0 3;
     1 1 0 -1 0 1 2];        % Constraints
s = eye(size(A,1));

%% Finding Starting BFS
BV=[];
for i=1:size(s,2)
    for j=1:size(A,2)
        if A(:,j)==s(:,i)
            BV = [BV j];
        end
    end
end

%% Compute values of table
B = A(:,BV);
A = inv(B)*A;
ZjCj = Cost(BV)*A - Cost;

%% Printing Table
ZCj = [ZjCj;A];
SimpTable = array2table(ZCj);
SimpTable.Properties.VariableNames(1:size(ZCj,2)) = Variables

%% Simplex Loop
RUN = true;
while RUN
    ZC = ZjCj(:,1:end-1);
    if any(ZC<0)
        fprintf('Current BFS is NOT OPTIMAL \n');
        %% Finding entering variable
        [EntVal, pvt_col] = min(ZC);
        fprintf('Entering column = %d \n',pvt_col);
        
        %% Finding leaving variable
        sol = A(:,end);
        Column = A(:,pvt_col);
        if all(Column)<=0
            fprintf('Solution is Unbounded');
        else
            for i=1:size(Column,1)
                if Column(i)>0
                    ratio(i) = sol(i)./Column(i);
                else
                    ratio(i)=inf;
                end
             end

            [minR, pvt_row] = min(ratio);
            fprintf('Leaving row = %d \n',pvt_row);
            
            %% Update BV
            BV(pvt_row) = pvt_col;
            
            %% Update Table for next generation
            B = A(:,BV);
            A = B\A;
            ZjCj = Cost(BV)*A - Cost;
            
            %% Printing Table
            ZCj = [ZjCj;A];
            SimpTable = array2table(ZCj);
            SimpTable.Properties.VariableNames(1:size(ZCj,2)) = Variables
        end
    else
        RUN = false;
        fprintf ('Current BFS OPTIMAL \n')
    end
end

%% Final Optimal BFS
FINAL_BFS = zeros(1,size(A,2));
FINAL_BFS(BV) = A(:,end);
FINAL_BFS(end) = sum(FINAL_BFS.*Cost);

OPTIMAL_BFS = array2table(FINAL_BFS);
OPTIMAL_BFS.Properties.VariableNames(1:size(OPTIMAL_BFS,2)) = Variables
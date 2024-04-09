function[BFS, A] = simp(A,BV,Cost,Variables)

ZjCj = Cost(BV)*A - Cost;
% Simplex Start
RUN = true;
while RUN
    ZC = ZjCj(:,1:end-1);
    if any(ZC<0)
        fprintf('Current BFS is NOT OPTIMAL \n');
        % Finding entering variable
        [EntVal, pvt_col] = min(ZC);
        fprintf('Entering column = %d \n',pvt_col);
        
        % Finding leaving variable
        sol = A(:,end);
        Column = A(:,pvt_col);
        if Column<=0
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
            
            % Update BV
            BV(pvt_row) = pvt_col;
            
            % Update Table for next generation
            B = A(:,BV);
            A = B\A;
            ZjCj = Cost(BV)*A - Cost;
            
            % Printing Table
            ZCj = [ZjCj;A];
            SimpTable = array2table(ZCj);
            SimpTable.Properties.VariableNames(1:size(ZCj,2)) = Variables

            BFS(BV) = A(:,end);
        end
    else
        RUN = false;
        fprintf ('Current BFS OPTIMAL \n')
        fprintf('Phase ends\n')
        BFS=BV;
    end
end
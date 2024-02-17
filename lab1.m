f=[1 -2];
A=[1 1;-1 1];
b=[2 1];
Aeq=[];
beq=[];
lb=[0 0];
[x,fval]=linprog(f,A,b,Aeq,beq,lb)
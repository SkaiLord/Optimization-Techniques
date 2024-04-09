clc;
clear all;

%% Input
C=[3,5];
A=[1 2; 1 1; 0 1];
b=[2000;1500;600];

%% Plot graph
y1=0:1:max(b);
x21 = (b(1)-A(1,1).*y1)./A(1,2);
x22 = (b(2)-A(2,1).*y1)./A(2,2);
x23= (b(3)-A(3,1).*y1)./A(3,2);

x21 = max(0,x21);
x22 = max(0,x22);
x23 = max(0,x23);

plot(y1,x21,'r',y1,x22,'g',y1,x23,'b')
xlabel('x1');
ylabel('x2');
legend('x1+2x2=2000','x1+x2=1500','x2=600')
title('x1 v/s x2')

%% Corner Points
cx1 = find(y1==0);
c1 = find(x21==0);
Line1 = [y1(:,[c1 cx1]); x21(:,[c1 cx1])]';

c2 = find(x22==0);
Line2 = [y1(:,[c2 cx1]); x22(:,[c2 cx1])]';

c3 = find(x23==0);
Line3 = [y1(:,[c3 cx1]); x23(:,[c3 cx1])]';

corpt = unique([Line1;Line2;Line3],'rows'); %corner pts

%% Point Of Intersection
HG = [0; 0];
for i=1:size(A,1)
    hg1=A(i,:);
    b1=b(i,:);
    for j=i+1:size(A,1)
        hg2=A(j,:);
        b2=b(j,:);
        Aa = [hg1;hg2];
        Bb = [b1;b2];
        Xx = Aa\Bb;
        HG = [HG Xx];
    end
end
pt=HG';

%% Write all corner points
allpt = [pt;corpt];
points = unique(allpt,'rows');

%% Find feasible region
PT = constraint(points);
PT = unique(PT, 'rows');

%% Compute objective function
for i=1:size(PT,1)
    Fx(i,:) = sum(PT(i,:).*C);
end

Vert_Fns = [PT Fx];

%% Find Optimal One
[fxval, indfx] = max(Fx);
optval = Vert_Fns(indfx,:);
OPTIMAL_BFS = array2table(optval)
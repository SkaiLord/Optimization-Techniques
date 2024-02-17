function hh = constraint(X)
%% 1st Constraint
x1 = X(:,1);
x2 = X(:,2);
cons1 = x1+2.*x2-2000; % < sign
h1=find(cons1>0);
X(h1,:)=[];

%% 2nd Constraint
x1 = X(:,1);
x2 = X(:,2);
cons2 = x1+x2-1500; % < sign
h2=find(cons2>0);
X(h2,:)=[];

%% 3rd Constraint
x1 = X(:,1);
x2 = X(:,2);
cons3 = x2-600; % < sign
h3=find(cons3>0);
X(h3,:)=[];

hh=X;
end
clc;
clear;

f = @(x, y) 3*x*x - 4*x*y + 2*y*y+ 4*x + 6;
grad = @(x, y) [6*x - 4*y + 4, -4*x + 4*y];
Variables = {'Iteration','x','y','f(x,y)'};

xi = 0;
yi = 0;

dummyArray=[1,xi,yi,f(xi,yi)];

iteration = 1;
while iteration < 5
    %fprintf('Iteration %d\n',iteration);
    iteration = iteration + 1;
    
    d = -grad(xi, yi);
    disp(d);
        
    calculate_alpha = @(alpha) f(xi + alpha * d(1), yi + alpha* d(2));
    alpha = fminbnd(calculate_alpha, 0, 100);
    
    disp(alpha);

    %disp('x_initial');
    %disp(xi);
    %disp('y_initial');
    %disp(yi);
    
    x_next = xi + alpha * d(1);
    y_next = yi + alpha * d(2);
    
    %disp('Initial');
    %disp(f(xi, yi));
    %disp('Next');
    %disp(f(x_next, y_next));
    
    %disp('x_next');
    %disp(x_next);
    %disp('y_next');
    %disp(y_next);
    
    xi = x_next;
    yi = y_next;
    dummyArray=[dummyArray;iteration,xi,yi,f(xi,yi)];

end

table = array2table(dummyArray);
table.Properties.VariableNames(1:size(dummyArray,2)) = Variables
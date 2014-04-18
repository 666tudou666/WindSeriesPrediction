function Matrix_Regression = make_regression_matrix(X, N, ahead)
%X: vector
%N: number of col
%ahead: No time ahead
%%make the regression matrix of N col and length(X)-N+1 row
%output: predict/label  t t-1 t-2 ... 1(oldest)
%attention that in the prev. setting, there are only N-1 feature in this
%formular

Size = length(X);

%store matrix regression +1 for target
Y = zeros(Size- ahead -N+1, N+1);


for i=N:-1:1
    Col = X(i:Size- ahead - N +i);
    
    Y(:,2 +N-i) = Col; %start from 2nd col
    
end

%first col
Y(:, 1)         = X( N+ ahead: Size);

Matrix_Regression = Y;
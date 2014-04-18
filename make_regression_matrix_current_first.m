function Matrix_Reg  = make_regression_matrix_current_first( X, N, ahead)
%%%this function arrange the data in series X to the regerssion mat,
%%%similar to make_regression_matrix
% X: time series: order ???

Size = length(X);

%store matrix regression +1 for target
Y = zeros(Size- ahead -N+1, N+1);

for i=1: N %1st target 2nd end: input
    col     = X( i + ahead : end -N +i);                       
    Y(:, i+1) = col;
end

%target
Y(:, 1)     = X(1: end - N -ahead +1);

Matrix_Reg  = Y;
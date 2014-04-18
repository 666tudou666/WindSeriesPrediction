function rmse = ar_test_func_1_series(y, d, p,  sav)
%this function compute the error of auto regression
%input:
%y: whole time series
%d: test series
%p: order, start from 1
%sav: saved file
%Output:
%rmse: root means square error of prediction


%load ('C:/Users/dlmg4/Dropbox/data/windmill/wind data/data_processed');

% d = 2000;

train = y(1:end-d);
%X :test
X = y(end-d+1:end);

%%clear 


%%number of point to regress is from 1 to 19
rmse =[];
for N= p+1%2:10
    N
    [coef, var] = arburg(train,N-1);
    
    %prepare tap delay in Y
    Size = length(X);
    %XN = X(:,ones(N,1));
    Y = zeros(Size-N, N);
    for i=N:-1:1
         Col = X(i:end);
         Col = Col(1:Size-N);
         Y(:,1+N-i) = Col;
    end
    
 
    %Y_N = Y*coef+sqrt(var)*randn(Size-N,1);
    Y_N = Y*coef';
    rmse1 = sqrt(mse(Y_N));
    rmse = [rmse rmse1];
end
save(sprintf('%s',sav),'rmse','-ascii')
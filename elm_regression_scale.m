function output = elm_regression_scale(train_series, test_series, NoHidden, N, Max, ahead, varargin)
%
%train_series: cell containing time series
%test_series: vector
%NoHidden: [1 10 11:20]
%N: number of samples used in regression
%Max: max speed for scale
%ahead: number of time a head for forecast
%varargin: save data file
%varargin(1): Error 
%varagrin(2): Regression


%%%group them into train_series
%%%buil a large matrix 
%%then split to train and test

%%%form regression matrix for train
%%this Matrix Regression is row-wise due to the old thinking

NoSeries = length(train_series);

%join to one big feature matrix only
train_series{NoSeries} = [train_series{NoSeries} ; test_series];

L = length( train_series{1} );
train = zeros( (L- ahead -N+1)*NoSeries , N+ 1);

for i=1:NoSeries
   
   X = train_series{i} /Max /N; %scale right here; %scale smaller so that the feature mapping is small
   
   %make it a matrix of regression (tapped delay)
   Matrix_Regression = make_regression_matrix(X, N, ahead);
   
    train ( (L- ahead -N+1)*(i-1)+1 : (L- ahead -N+1)*i, :) = Matrix_Regression;
end

%%%scale the matrix feature, not the label
%train(:,2:end) = scalemat(train(:,2:end));
   
%%%%split to test and train
d = length(test_series);
system('cat /proc/meminfo')

test = train(end-d+1:end,: )';
train(end-d+1:end, :) = [];
train = train';
%train = train(1:end-d, :)';

%test_series = test(:, 1) *Max *N;
% % save( 'train24', 'train')
% % save( 'test24', 'test')

%%%%Run ELM

for i=NoHidden
    fid = fopen( sprintf( '%s ahead %d', varargin{1}, ahead ), 'a');
    size( train)
    [TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy, Y2, TY2] =...
        ELM_largedata_withoutput_label_feature1(train(1, :), train(2:end,:),  test(1,:), test(2:end,:), 0, i, 'sig');
    
    %write to file
    fprintf( fid, '%d %d %4.2f %4.2f %2.6f %2.6f \n', N, i, TrainingTime, TestingTime, TrainingAccuracy *N* Max, TestingAccuracy *N* Max);
    fclose (fid);

% % % % % % range = [1:100];
% % % % % % 
% % % % % % 
% % % % % % %%%plot the result
% % % % % % figure; hold on
% % % % % % plot(TY2(range),'r');
% % % % % % plot(test_series(range),'b');


%save the data
s = sprintf('%s NoF = %d NoH = %d ahead %d regression.mat', varargin{2}, N, i, ahead); 
TY2 = TY2 *N* Max;
save(s, 'TY2', 'test_series');

output = 1.1;
end
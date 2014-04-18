%This is the main file

%Input: group, local, dataseries

%number of features, number of Hidden

%Form the ELM format and save, it will be a lot if i choose different numbe
%rof features

%Run ELM for various noF and NoHidden, local and group

%save the predictions into file

%ko can viet lai nhieu, chi can copy paste, + optimize some previous code
%to automat the process and more generalize

clear 
load('~/Dropbox/data/windmill/wind data/data_resampled.mat')
%load('C:/Users/dlmg4/Dropbox/data/windmill/wind data/data_resampled.mat')

addpath('../')

%ahead prediction
sample = 1;
group = [1 2 3 4 6 8 9 10 14];
%group = [1:12 14 15];
%group = [1 2 3 5];
%group = [];
local = 13;

%%%for simple test
d = 200; %number of forecast to make 
L = length(C1{local}(:,3));

train_series = cell(1,length(group)+1); %group + part of local

for i=1: length(group)
   train_series{i} = C1{group(i)}(1:sample: end,3); 
end

train = C1{local}(1:sample:L,3);

train_series{end} = train(1:end-d);

test_series = train(end-d+1:end);

clear C1 %free some memory


ahead = 24/sample;
%N-1 is number of past samples ->N start from 2
N = [48] ;
%Max for normalize
Max = 60;
%No
NoHidden = [200]% 1000];

for i=1:length(N)
    temp= elm_regression_scale_longterm1(train_series, test_series, NoHidden, N(i), Max, ahead, 'group_value','group_result');
    %output = [output ;temp];
end


%%%%For cheking the result
figure; hold on
load 'group_result NoF = 48 NoH = 100 regression'
plot( TY2(1: d))
plot( test_series (1 :d) ,'r')
legend('Predict', 'True')
ylabel('speed')
xlabel('Time step')

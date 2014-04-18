%ar_srcrpt test
clear 
%load('~/Dropbox/data/windmill/wind data/data_resampled.mat')
load('C:/Users/dlmg4/Dropbox/data/windmill/wind data/data_resampled.mat')

addpath('../')

%ahead prediction

group = [1 2 3 4 6 8 9 10 14];
%group = [1:12 14 15];
%group = [1 2 3 5];
group = [];
local = 13;

save_file = 'ar_100k4000_100_2000';

%%%for simple test
d = 4000; %number of forecast to make 
L = 100000; %length(C1{local}(:,3));
sample  =1 ;
train = C1{local}(1:sample:L,3);

p = [100: 100: 2000];

%p = 1: 20;
rsme = ar_test_func_1_series( train, d, p,  save_file);
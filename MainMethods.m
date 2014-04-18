%%%Parameters
% Methods: ELM, bp, rbf, anfis, ar
% NoH = 10, 100
% NoS = 1...19
% err: MSE, RMSE

%%%further
% time: winter, spring, summer, and fall
%%% Work with local first
% 1-3: winter, 4-6: spring; 7-9: summer; 10-12: winter

%%%further
% Time: 1 3 5 10 20
% ELM, NoH =100, NoS = 6?
% Local and Group

%%%%%%%%Get the data
%load('~/Dropbox/data/windmill/wind data/data_resampled.mat')
%load('C:/Users/Dale/Dropbox/data/windmill/wind data/data_resampled.mat')
load('C:/Users/dlmg4/Dropbox/data/windmill/wind data/data_resampled.mat')
sample = 1;
%group = [1 2 3 4 6 8 9 10 14];
group = [];
local = 13;

d = 2000; %number of forecast to make 
L = 200000%length(C1{local}(:,3)); %300000%
%%%Get the data to from the season
%Winter, nam nhuan?
nYears          = 35;
season          = 1;
scale           = 60; %maximum wind speed
data = getWorkingData( C1{local}(:,3) /scale, nYears, season);

nSamples = 1:9;
nH          = [10, 100];
%depend on the method, we organize data accordingly

%bp
tic
[Rmse, Mae]         = bpPredict( data, nSamples, nH)
toc
save( ['bplm' num2str(nYears)], 'Rmse', 'Mae')

tic
[rmseRBF, maeRBF]   = rbfPredict( data, nSamples, nH)
save( ['rbf' num2str(nYears)], 'rmseRBF', 'maeRBF')
toc


tic
[anfisRmse, anfisMae] = anfisPredict( data, nSamples, nH)
save( ['anfis' num2str(nYears)], 'anfisRmse', 'anfisMae')
toc


tic
addpath('../')
[elmRmse, elmMae] = elmPredict( data, nSamples, nH, [num2str( nYears) 'elm' num2str(season)]);       
toc
%{
net = timedelaynet([1:NoDelay], 10);
net.trainParam.epochs = 100;
net.divideFcn = '';
ft_net = train(net, p, t, Pi);
%}

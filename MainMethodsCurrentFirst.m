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
load('~/Dropbox/data/windmill/wind data/data_resampled.mat')
%load('C:/Users/Dale/Dropbox/data/windmill/wind data/data_resampled.mat')
%load('C:/Users/dlmg4/Dropbox/data/windmill/wind data/data_resampled.mat')
sample = 1;
%group = [1 2 3 4 6 8 9 10 14];
%group = [];
local = 13;

%d = 2000; %number of forecast to make 
%L = 200000%length(C1{local}(:,3)); %300000%
%%%Get the data to from the season
%Winter, nam nhuan?
nYears          = 35;
season          = 3;
scale           = 60; %maximum wind speed
data = getWorkingDataCurrentFirst( C1{local}(:,3) /scale, nYears, season);

nSamples = 200;%[23 100 200 300 400];
nH          = 200;[100 200 300 400 ];
%depend on the method, we organize data accordingly


%bp
% % % tic
% % % [Rmse, Mae]         = bpPredictcurrentfirst( data, nSamples, nH) ;%need to run one more time
% % % t = toc;
% % % fid     = fopen('bpPredict.txt','a+'); %write the time
% % % fprintf( fid, '%4.2f\n', t);
% % % fclose( fid)
% % % save( ['bplm' num2str(nYears)], 'Rmse', 'Mae')
% % % 
% % % tic
% % % [rmseRBF, maeRBF]   = rbfPredictcurrentfirst( data, nSamples, nH)
% % % save( ['rbf' num2str(nYears)], 'rmseRBF', 'maeRBF')
% % % t = toc;
% % % fid     = fopen('rbfPredict.txt','a+'); %write the time
% % % fprintf( fid, '%4.2f\n', t);
% % % fclose( fid);
% % % 
% % % 
% % % 
% % % 
% % % tic
% % % [anfisRmse, anfisMae] = anfisPredictcurrentfirst( data, nSamples, nH)
% % % t = toc;
% % % fid     = fopen('anfisPredict.txt','a+'); %write the time
% % % fprintf(fid, '%4.2f\n', t);
% % % fclose( fid);
% % % save( ['anfis' num2str(nYears)], 'anfisRmse', 'anfisMae')
% % % 


% % % tic
% % % addpath('../')
% % % [elmRmse, elmMae] = elmPredictcurrentfirst( data, nSamples, nH, [num2str( nYears) 'elm' num2str(season)]);       
% % % t = toc
% % % fid     = fopen('elmPredict.txt','a+'); %write the time
% % % fprintf(fid, '%4.2f\n', t/10); %10 elm
% % % fclose (fid);
%{
net = timedelaynet([1:NoDelay], 10);
net.trainParam.epochs = 100;
net.divideFcn = '';
ft_net = train(net, p, t, Pi);
%}


% % % %%%group
group = [1 4 8 9 10];
%group = [];
local = 13;
% % % 
% % % %d = 2000; %number of forecast to make 
% % % %L = 200000%length(C1{local}(:,3)); %300000%
% % % %%%Get the data to from the season
% % % %Winter, nam nhuan?
data = getWorkingDataGroup( C1, local, group, scale, nYears, season);

tic
addpath('../') 
[elmRmse, elmMae] = elmPredictcurrentfirst( data, nSamples, nH, [num2str( nYears) 'elmGroup3Multi' num2str(season)]);       
t = toc
fid     = fopen('elmPredict.txt','a+'); %write the time
fprintf(fid, '%4.2f\n', t/10); %10 elm
fclose (fid);
save( ['elm' num2str(nYears)], 'elmRmse', 'elmRmse')


%%%%%%%%Get the data
%load('~/Dropbox/data/windmill/wind data/data_resampled.mat')
%load('C:/Users/Dale/Dropbox/data/windmill/wind data/data_resampled.mat')
load('C:/Users/dlmg4/Dropbox/data/windmill/wind data/data_resampled.mat')
sample = 1;
%group = [1 2 3 4 6 8 9 10 14];
%group = [];
local = 13;

%d = 2000; %number of forecast to make 
%L = 200000%length(C1{local}(:,3)); %300000%
%%%Get the data to from the season
%Winter, nam nhuan?
nYears          = [1 3 5 10 20 30 35];
season          = 1:4;
scale           = 60; %maximum wind speed

nSamples = 23;
nH          = [100];
%depend on the method, we organize data accordingly

addpath('../')
% % % % for i=1: length( season)
% % % %     for j=1: length( nYears)
% % % %     tic
% % % %     
% % % %     data = getWorkingDataCurrentFirst( C1{local}(:,3) /scale, nYears(j), season(i));
% % % % 
% % % %     [elmRmse, elmMae] = elmPredictcurrentfirst( data, nSamples, nH, [num2str( nYears(j)) 'elmSeason' num2str(season(i))]);       
% % % %     t = toc
% % % %     fid     = fopen('elmPredict.txt','a+'); %write the time
% % % %     fprintf(fid, '%4.2f\n', t/10); %10 elm
% % % %     fclose (fid);
% % % % 
% % % %     end
% % % % end

%%%group
%group = [1 2 3 4 6 8 9 10 14];
group = [1 4 8 9 10];
%group = [];
local = 13;

    
for i=1: length( season)
    for j=1: length( nYears)
    tic
    data = getWorkingDataGroup( C1, local, group, scale, nYears( j), season(i));
    [elmRmse, elmMae] = elmPredictcurrentfirst( data, nSamples, nH, [num2str( nYears( j)) 'elm3Group' num2str(season( i))]);       
    t = toc
    fid     = fopen('elmPredict.txt','a+'); %write the time
    fprintf(fid, '%4.2f\n', t/10); %10 elm
    fclose (fid);
    end
end
% % % save( ['elm' num2str(nYears)], 'elmRmse', 'elmRmse')
function data = getWorkingData( wholeData, nYears, season)
%wholeData: cell all years data
%n Years: number of years to get
%wich season: 1: spring 4: winter

%C1 is from 1,1,1975 to 7.31.2010

%is there anyway to test this function???

yearStart       = 1975;

data            = cell(1, nYears);

startHr       = 0;

dura            = 90;
%%%actualy it doesnt matter
% % seasonStart         = (season-1)* 90*24; %90 days a season
% % seasonEnd           = season* 90*24; 

seasonStart         = (season-1)* dura*24; %90 days a season
seasonEnd           = season* dura*24; 
        
for yr = 1: nYears       
        data{ yr} = ( wholeData( startHr+ seasonStart+1: startHr+ seasonEnd));
    if mod(yearStart+ yr,4) %normal year
        startHr = startHr+ 365* 24;
    else %leap year
        startHr = startHr+ 366*24;
    end
    
    %startyear
end
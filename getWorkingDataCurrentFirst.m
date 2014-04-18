function data = getWorkingDataCurrentFirst( wholedata, nYears, season)
%this function arrang data as tcurrent tcurrent-1, ..., 1
% and split out the season to year

%%%%truncate the time after 2010.1.1
% % % cutIndex        = 306816; %2010.1.1 index
% % % wholedata       = wholedata(cutIndex:-1:1);


yearStart       = 2009;
data            = cell(1, nYears);
hrInDay         = 24;
dayInYear       = 365;
dayInSeason            = 90;

% % % yearStart       = 2007;
% % % data            = cell(1, nYears);
% % % hrInDay         = 1;
% % % dayInYear       = 6;
% % % dayInSeason            = 3;

startHr         = 0; %kind of backward but must check it work

seasonStart     = (season -1)* dayInSeason* hrInDay;
seasonEnd       = season* dayInSeason* hrInDay;

for yr=1: nYears
   data{yr}     = wholedata( startHr+ seasonStart+1: startHr+ seasonEnd);
   
   if mod( yearStart - yr+1, 4) %normal year
       startHr  = startHr+ dayInYear* hrInDay;
   else
      startHr   = startHr+ (dayInYear+1) * hrInDay; 
   end
end
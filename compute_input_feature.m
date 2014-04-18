function feature = compute_input_feature(ts, overhead, ahead)
%the first overhead 200 is used to train, a little bit overhead but it is easier to
%remember
%INput
%ts: time series
% lag, overhead: number of past used in compute feature
% ahead: the number of steps far ahead to predict e.g. 24

% Output
% length of 29: 14 of level 0 
% 15 of level 1
%t = 1 2 3 ...100
%n = 1 2 .. 5 7 .. 65 97
%t-n = 0 0 ...  ...-8:8 -16:16

%%%%

overhead    = 200;
%work as in hongtan's thesis
n = [1 2 3 4 5 7 9 13 17 25 33 49 65 97]; %minus back to the past
m = [0 0 0 0 0 2 2 4  4   8  8 16 16  32];

%feature int
F = 29;
C = length(ts) - overhead - ahead +1; %113 = 97+32/2

feature = zeros(F,C);

ft0 = zeros(15,1);
ft1 = zeros(14,1);
%%%exponential moving average
ema = exmvav(ts);

for t= overhead:length(ts)- ahead %assum
    
    %feature level 0
    ft0(1) = log(ts(t) /ema(t));
    for index = 1:length(n)
       ft0(index+1) =  log( ts(t-n(index))/ema(t-n(index)) );
    end
    
    
    %feature 1
    for index = 1:length(m)
       %%%%compute BA(t-n)
       BA = 0;
       for k = -m(index)/2:1:m(index)/2
           BA = BA+ ts(t- n(index) + k);
       end
       BA = BA/(m(index)+1); 
       
       ft1(index) = (ts(t) - BA )/(ts(t) +BA);
    end

    feature(:,t- overhead+ 1) = [ft0;ft1];
end
end


function ema = exmvav(ts)
    ema = zeros*ts;
    ema(1) = ts(1);
    alpha = .01;
    for index = 2:length(ts)
       ema(index) = alpha*ts(index) +(1-alpha)*ema(index-1); 
    end
end
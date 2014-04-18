load mgdata.dat
time = mgdata(:, 1); x = mgdata(:, 2);
figure(1), plot(time, x);
title('Mackey-Glass Chaotic Time Series')
xlabel('Time (sec)')


for t=118:1117, 
Data(t-117,:)=[x(t-18) x(t-12) x(t-6) x(t) x(t+6)]; 
end
trnData=Data(1:500, :);
chkData=Data(501:end, :);

fismat = genfis1(trnData);

[fismat1,error1,ss,fismat2,error2] = ...
	  anfis(trnData,fismat,[],[],chkData);


  figure(5)
anfis_output = evalfis([trnData(:,1:4); chkData(:,1:4)], ...
    fismat2);
index = 125:1124;
subplot(211), plot(time(index), [x(index) anfis_output]);
xlabel('Time (sec)');
title('MG Time Series and ANFIS Prediction');
subplot(212), plot(time(index), x(index) - anfis_output);
xlabel('Time (sec)');
title('Prediction Errors');
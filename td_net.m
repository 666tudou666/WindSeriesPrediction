load ('C:/Users/dlmg4/Dropbox/data/windmill/wind data/data_resampled.mat')
%close all
%must be row like a sequential data
x = num2cell(C1{13}(:,3)');
% 


%x = laser_dataset;
NoT = floor(length(x)/10)*9;
NoTest = 100;

y = x(1:NoT);

NoDelay = 10;
net = timedelaynet([1:NoDelay],20);

net.trainFcn = 'traingd';
net.trainParam.epochs = 100;
net.divideFcn = '';
%net.trainParam.showWindow = false;
net.trainParam.showCommandLine = true;
net.trainParam.lr =.01;
net.trainParam.goal = 1e-5;

p = y(NoDelay+1:end);
t = y(NoDelay+1:end);
Pi = y(1:NoDelay);

ft_net = train(net, p, t, Pi);

test = x(NoT+1:NoT+ NoTest);
test_predict = ft_net(test, Pi);

test = cell2mat(test);
test_predict = cell2mat(test_predict);

figure;hold on
plot(test,':k','lineWidth', 2); hold on
plot(test_predict,'k','lineWidth', 2);
legend('True','Predicted');
xlabel('Time (hr)');
ylabel('Speed (m/s)')

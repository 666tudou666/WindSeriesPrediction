% % % d = 100
% % % load 'group_300_300_result1 NoF = 300 NoH = 300 ahead 4 regression'
% % % group4 = TY2;
% % % 
% % % load 'local_100_2000_result1 NoF = 300 NoH = 300 ahead 4 regression'
% % % local4 = TY2;
% % % 
% % % figure; hold on;
% % % 
% % % 
% % % load 'group_300_300_result1 NoF = 300 NoH = 300 ahead 1 regression'
% % % group1 = TY2;
% % % 
% % % load 'local_100_2000_result1 NoF = 300 NoH = 300 ahead 1 regression.mat'
% % % local1 = TY2;
% % % 
% % % 
% % % plot( test_series(1 : d)  ,'-k', 'lineWidth', 2)
% % % 
% % % plot( local4 (1 : d),'--k', 'lineWidth', 1);
% % % 
% % % plot( group4 (1 : d), ':k','lineWidth',1)
% % % 
% % % plot( local1 (1 : d), '--ok');
% % % plot( group1 (1 : d), ':sk');
% % % 
% % % legend('True value', 'Local Prediction 4 step', 'Cluster Prediction 4 step', 'Local Prediction 1 step', 'Cluster Prediction 1 step')
% % % ylabel('speed (m/s)')
% % % xlabel('Time step (hr)')


d = 2781: 2804;
load 'group_300_300_result1 NoF = 300 NoH = 300 ahead 4 regression'
group4 = TY2;

% load 'local_100_2000_result1 NoF = 300 NoH = 300 ahead 4 regression'
% local4 = TY2;

figure; hold on;

% load 'local_100_5_result1 NoF = 5 NoH = 100 ahead 1 regression.mat'
% local1 = TY2;

load 'group_100_5_result1 NoF = 5 NoH = 100 ahead 1 regression'
group1 = TY2;

plot( test_series(d)  ,'-k', 'lineWidth', 2)

% plot( local4 (d),'--k', 'lineWidth', 2);

plot( group4 (d), '--k','lineWidth',2)

% plot( local1 (d), '--ok');
plot( group1 (d), '--sk');

%legend('True value', 'Local Prediction 4 step', 'Cluster Prediction 4 step', 'Local Prediction 1 step', 'Cluster Prediction 1 step')
legend('True value', 'Cluster Prediction 4 step', 'Cluster Prediction 1 step')
ylabel('speed (m/s)')
xlabel('Time step (hr)')

set(gcf, 'PaperPositionMode', 'auto') 
set (gcf, 'PaperPosition', [0 0 6 3]); %figure doesn't move but the eps does
saveas( gcf, 'multiple.eps');
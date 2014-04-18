clear all
close all

load mgdata.dat
a = mgdata;
time = a(:, 1);
x_t = a(:,2);

plot(time, x_t);

trn_data = zeros(500, 5);
chk_data = zeros(500, 5);

% prepare training data
trn_data(:, 1) = x_t(101:600);
trn_data(:, 2) = x_t(107:606);
trn_data(:, 3) = x_t(113:612);
trn_data(:, 4) = x_t(119:618);
trn_data(:, 5) = x_t(125:624);

% prepare checking data
chk_data(:, 1) = x_t(601:1100);
chk_data(:, 2) = x_t(607:1106);
chk_data(:, 3) = x_t(613:1112);
chk_data(:, 4) = x_t(619:1118);
chk_data(:, 5) = x_t(625:1124);

fismat = genfis1(trn_data);

% The initial MFs for training are shown in the plots.
for input_index=1:4,
    subplot(2,2,input_index)
    [x,y]=plotmf(fismat,'input',input_index);
    plot(x,y)
    axis([-inf inf 0 1.2]);
    xlabel(['Input ' int2str(input_index)],'fontsize',10);
end

epoch_n = 100;
trnOpt(1) = epoch_n;
[trn_fismat,trn_error, step, chkFis, chk_error] = anfis(trn_data, fismat,trnOpt,[],chk_data)

% plot final MF's on x, y, z, u
for input_index=1:4,
    subplot(2,2,input_index)
    [x,y]=plotmf(trn_fismat,'input',input_index);
    plot(x,y)
    axis([-inf inf 0 1.2]);
    xlabel(['Input ' int2str(input_index)],'fontsize',10);
end


% error curves plot
close all;

plot([trn_error chk_error]);
hold on; plot([trn_error chk_error], 'o'); hold off;
xlabel('Epochs','fontsize',10);
ylabel('RMSE (Root Mean Squared Error)','fontsize',10);
title('Error Curves','fontsize',10);

figure
input = [trn_data(:, 1:4); chk_data(:, 1:4)];
anfis_output = evalfis(input, trn_fismat);
index = 125:1124;
plot(time(index), [x_t(index) anfis_output]);
xlabel('Time (sec)','fontsize',10);

figure;
diff = x_t(index)-anfis_output;
plot(time(index), diff);
xlabel('Time (sec)','fontsize',10);
title('ANFIS Prediction Errors','fontsize',10);


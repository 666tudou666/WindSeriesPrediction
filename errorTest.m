gr = test(:, 1);

p   = gr(1: end-1);
t   = gr(2: end);

r   = errperf( t, p, 'rmse')* 60;
mae = errperf( t, p, 'mae')* 60;
mape = errperf( t, p, 'mape');
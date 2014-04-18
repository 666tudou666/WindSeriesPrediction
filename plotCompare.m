figure ; hold on
load ('local_result1 NoF = 48 NoH = 1000 regression')
plot( TY2( 1: 2000), 'b')
plot( test_series (1: 2000), 'r');

load ('group_result1 NoF = 48 NoH = 1000 regression')
plot( TY2( 1: 2000), 'g')


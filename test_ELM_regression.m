close all
addpath( '../../elm')

traindata = load('randomTrain.txt');
testdata  = load('randomTest.txt');

[t1, t2, t3, t4, Y, ELMMatlabTest] = ELM_largedata_withoutput( traindata,...
                                        testdata, 0, 600, 'sig');


%test plot from ELM CUDA
L = 100; 
%plot Train difference
figure; hold on
plot( Y(1: L), '--r');
plot( traindata(1:L,1), '-g')


%ELMCUDATest = load('../../CUDA/Eclipse/ELM/ckc.TestLabelcomputed');
TargetTest = load( 'randomTest.txt');
TargetTest = TargetTest(:, 1);
figure; hold on
plot( ELMMatlabTest(1: L), '-b');
%plot( ELMCUDATest(1: L), '-r');
plot( TargetTest(1: L), '--g');

H   = load('ckc.H');

hh1  = inv( H'*H);

HTH = load('ckc.HTH');

HH1 = load('ckc.HH1');

norm(hh1 - HH1)
function [anfisRmse, anfisMae] = anfisPredict( data, nSamples, nH)

%%%anfis data is formated as:
%with N iput anfis: data has N+1 columm, with first N columns conatrain
%data for input and last column for target. so data is row wise
%cf: elm: col wise
%rbf: col wise
%regresion matrix: row wise but target is infront
%it seems need initialization

rbfRmse            = zeros( length( nSamples), length(  nH));
rbfMae             = rbfRmse;

for iSamples =1: length( nSamples)
    for iH=1: 1%length( nH) % hidden cnf no diff
        fprintf('working on %d %d \n', iSamples, iH);
        
        nYears          = length( data);

        %%%%making regression matrix
        train           = [];
        N               = nSamples(iSamples);
        ahead           = 1;
        for i=1: nYears
            X           = data{i}; %already scale at the getdata functin
            Matrix_Reg  = make_regression_matrix( X, N, ahead);
            train       = [train; Matrix_Reg];
        end

        %%%%divide to train data, train label and test data, test label
        nDataInYear     = length( data{end});
        nTrain          = nDataInYear*9/10;
        nTest           = nDataInYear - nTrain;

        %%%swap to anfis input format
        %firsttcol         = train(:, 1);
        %train(
        test            = train(end- nTest+ 1: end, :);
        train           = train(1: end- nTest, :);
        
        %%%create anfis init
        infis           = genfis1( [train(:, 2:end) train(:, 1) ]);%, 20, 'gbellmf');
        epoch           = 100;
        trnOpt(1)       = epoch;    
        [fis, error]    = anfis( [train(:, 2:end) train(:, 1) ], infis) ;
%         [trn_fismat,trn_error, step, chkFis, chk_error]          = ...
%         anfis( [train(:, 2:end) train(:, 1) ], infis, trnOpt, [], [test(:, 2:end) test(:, 1) ]);
    
        %a = evalfis( [train(:, 2:end); test(:, 2:end)],  chkFis);
        test_predict = evalfis( test(:, 2:end),  fis);
        
        %%compute error
        scale   = 60;
        anfisMae(iSamples, iH)   = scale* mae( test(:, 1) - test_predict);
        anfisRmse(iSamples, iH)  = scale* sqrt( mse( test(:, 1) - test_predict));
        
                
        fid     = fopen('anfisPredict.txt','a+');
        fprintf( fid, '%d %d %2.2f %2.2f\n', iSamples, iH,  anfisMae(iSamples, iH),  anfisRmse(iSamples, iH));
        fclose( fid);
        
        %%
    end
end


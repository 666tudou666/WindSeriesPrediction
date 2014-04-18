function [rbfRmse, rbfMae] = rbfPredictcurrentfirst( data, nSamples, nH)
%data: cell{ nYear}s

%%%the format of rbf funtion
% net = newrb( X, T) is exactly the format of ELM
% where input X is matrix which

%I don't remember exactly but it seems that make regression matrix to row
%format is prefered but then we need to tranpose before calling elm

rbfRmse            = zeros( length( nSamples), length(  nH));
rbfMae             = rbfRmse;
rbfMape                = rbfMae;

for iSamples =1: length( nSamples)
    for iH=1: length( nH) % hidden cnf
        fprintf('working on %d %d \n', iSamples, iH);
        
        nYears          = length( data);

        %%%%making regression matrix
        train           = [];
        N               = nSamples(iSamples);
        ahead           = 1;
        for i=1: nYears
            X           = data{i}; %already scale at the getdata functin
            Matrix_Reg  = make_regression_matrix_current_first( X, N, ahead);
            train       = [train; Matrix_Reg];
        end

        %%%%divide to train data, train label and test data, test label
        nDataInYear     = length( data{end});
        nTrain          = nDataInYear*8/10;
        nTest           = nDataInYear - nTrain;
        
        test            = train(1: nTest, :)';
        train           = train( nTest+1: end, :)';


        %%%call rbfnn
        goal            = .01;
        spread          = 1 % just a ballpark ??
        DF              = 25; %what is it?
        %net             = newrb( train(:,2: end), train(:,1), goal, spread, nH( iH), DF);
        net             = newrb( train(2: end,:), train(1,:), goal, spread, nH( iH), DF);
        
        %%%test error
        test_predict    = net( test(2:end, :));
        scale   = 60;
        rbfMae(iSamples, iH)   = scale* mae( test(1, :) - test_predict);
        rbfRmse(iSamples, iH)  = scale* sqrt( mse( test(1, :) - test_predict));
        rbfMape(iSamples, iH)  = errperf( test(1, :), test_predict, 'mape');

                
        fid     = fopen('rbfPredict.txt','a+');
        fprintf( fid, '%d %d %2.2f %2.2f %2.2f\n', nSamples(iSamples), nH( iH),...
            rbfMae(iSamples, iH), rbfRmse(iSamples, iH), rbfMape(iSamples, iH));

        fclose( fid);
        
    end
end
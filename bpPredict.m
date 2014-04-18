function [Rmse, Mae] = bpPredict( data, nSamples, nH)
% data: cell of n years
% nSamples: number of delay use as samples, vector
% nH: number of hidden neurals, vector

Rmse            = zeros( length( nSamples), length(  nH));
Mae             = Rmse;
Epoch           = 20;
%NSamples        = 9;

   for iSamples =1: length( nSamples) %input conf
       for iH=1: length( nH) % hidden cnf
        %%%%%create NN
        fprintf('working on %d %d \n', iSamples, iH);
        net = timedelaynet([1:nSamples( iSamples)], nH( iH));
        net.trainFcn    = 'traingd';

        net.trainParam.epochs = 100;
        net.divideFcn = '';
        net.trainParam.showCommandLine = true;

        %ft_net = train(net, p, t, Pi);
        
        for epoch =1: Epoch %number of training
           for iYear=1: length( data) -1 %number of year
               %%%prepare the input and target to train
                y       = num2cell( data{iYear}'); %must be in cell row so train fun can work
                p       = y( nSamples( iSamples)+ 1: end); %input
                t       = y( nSamples( iSamples)+ 1: end); %target
                Pi      = y( 1:nSamples( iSamples)); %initial
                net     = train(net, p, t, Pi);

           end
           
           %%%last year training
                nYears          = length( data);
                nDataInYear     = length( data{ end});
                nTrain          = nDataInYear*9/10;
                nTest           = nDataInYear - nTrain;
                y       = num2cell( data{nYears}(1: nTrain)'); %must be in cell row so train fun can work
                p       = y( nSamples( iSamples)+ 1: end); %input
                t       = y( nSamples( iSamples)+ 1: end); %target
                Pi      = y( 1:nSamples( iSamples)); %initial
                net     = train(net, p, t, Pi);
        end
        
        %%%testing of course last year
        test            = num2cell( data{ nYears}( nTrain+1: nTrain+ nTest)');
        Pi              = test( 1: nSamples( iSamples));
        test            = test( nSamples( iSamples) +1: end);
        test_predict    = net( test, Pi) ;
        
        %%%compute error
        test            = cell2mat(test);
        test_predict    = cell2mat( test_predict);
        
        scale   = 60;
        Mae(iSamples, iH)   = scale*mae( test - test_predict);
        Rmse(iSamples, iH)                = scale*sqrt( mse( test - test_predict));
        
        %%%write down the number
        
        fid     = fopen('bpPredict.txt','a+');
        fprintf( fid, '%d %d %2.2f %2.2f\n', nSamples( iSamples), nH( iH),  Mae(iSamples, iH),  Rmse(iSamples, iH));
        fclose( fid);
        
       end
   end

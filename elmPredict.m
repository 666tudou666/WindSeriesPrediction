function [elmRmse, elmMae] = elmPredict( data, nSamples, nH, varargin)      
%%%suppose it work wit 1 year only

scale           = 60;
elmRmse            = zeros( length( nSamples), length(  nH));
elmMae             = elmRmse;

for iSamples =1: length( nSamples)
        nYears          = length( data);

        L               = length( data{1} );
        %%%%making regression matrix
        %train           = [];
        N               = nSamples(iSamples);
        ahead           = 1;
        train           = zeros( (L- ahead -N+1)*nYears , N+ 1);
        for i=1: nYears
            X           = data{i}; %already scale at the getdata functin
            Matrix_Reg  = make_regression_matrix( X, N, ahead);
            train ( (L- ahead -N+1)*(i-1)+1 : (L- ahead -N+1)*i, :) = Matrix_Reg;
        end

        %%%%divide to train data, train label and test data, test label
        nDataInYear     = length( data{end});
        nTrain          = nDataInYear*8/10;
        nTest           = nDataInYear - nTrain;

        %firsttcol         = train(:, 1);
        %train(
        test            = train(end- nTest+ 1: end, :)';
        train           = train(1: end- nTest, :)';
        
        for iH=1: length( nH) % hidden cnf
            
            fprintf('working on %d %d \n', iSamples, iH);    
            %%%call elm for train
            fid             = fopen( varargin{1}, 'a'); %write intermed result
            [timeTr, timeTe, accTr, accTe, Y2, TY2] =...
                ELM_largedata_withoutput_label_feature1( train(1, :), train(2: end, :),...
                test(1, :), test(2: end, :), 0, nH( iH), 'sig');

            fprintf( fid, '%d %d %4.2f %4.2f %2.6f %2.6f \n', N, nH(iH), timeTr, timeTe, accTr *scale, accTe *scale);
            fclose (fid);

            %save regression data
            s = sprintf('%s nSample =%d nH = %d regression.mat', varargin{1}, nSamples(iSamples), nH( iH));
            save( s, 'TY2', 'test');

            elmMae(iSamples, iH)   = scale* mae( test(1, :) - TY2);
            elmRmse(iSamples, iH)  = scale* sqrt( mse( test(1, :) - TY2));


            fid     = fopen('elmPredict.txt','a+');
            fprintf( fid, '%d %d %2.4f %2.4f\n', iSamples, iH,  elmMae(iSamples, iH),  elmRmse(iSamples, iH));
            fclose(fid);
        end
end
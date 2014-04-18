function [elmRmse, elmMae] = elmPredictcurrentfirst( data, nSamples, nH, varargin)      
%%%suppose it work wit 1 year only

ahead           = 1;
scale           = 60;
elmRmse            = zeros( length( nSamples), length(  nH));
elmMae             = elmRmse;

for iSamples =1: length( nSamples)
        nYears          = length( data);

        L               = length( data{1} );
        %%%%making regression matrix
        %train           = [];
        N               = nSamples(iSamples);
        
        train           = zeros( (L- ahead -N+1)*nYears , N+ 1);
        for i=1: nYears
            X           = data{i}; %already scale at the getdata functin
            Matrix_Reg  = make_regression_matrix_current_first( X, N, ahead);
            train ( (L- ahead -N+1)*(i-1)+1 : (L- ahead -N+1)*i, :) = Matrix_Reg;
        end

        %%%%divide to train data, train label and test data, test label
        nDataInYear     = length( data{end});
        nTrain          = floor(nDataInYear*8/10);
        nTest           = nDataInYear - nTrain;

        %firsttcol         = train(:, 1);
        %train(
        test            = train(1: nTest, :)';
        train           = train( nTest+1: end, :)';
        
% %         test            = train(end- nTest+ 1: end, :)';
% %         train           = train(1: end- nTest, :)';
        
        for iH=1: length( nH) % hidden cnf
            
            fprintf('working on %d %d \n', iSamples, iH);    
            %%%call elm for train
            fid             = fopen( varargin{1}, 'a'); %write intermed result
            
            timeTr=0; timeTe=0; accTr=0; accTe=0; Y2=0; TY2=0* test(1, :);
            Mae      =0; Mape =0; %reviewr index
            for iE= 1: 10
                [timeTr, timeTe, accTr1, accTe1, Y21, TY21] =...
                    ELM_largedata_withoutput_label_feature1( train(1, :), train(2: end, :),...
                    test(1, :), test(2: end, :), 0, nH( iH), 'sig');
                accTr =  accTr+    (accTr1 - accTr)/iE;
                accTe =  accTe+    (accTe1 - accTe)/iE;
                TY2     = TY2+      (TY21 - TY2)/iE;
                Mae     = Mae+ (errperf( test(1, :), TY21, 'mae') - Mae)/iE;
                Mape     = Mape+ (errperf( test(1, :), TY21, 'mape') - Mape)/iE;
            end
            fprintf( fid, '%d %d %4.2f %4.2f %2.6f %2.6f %2.6f %2.6f\n', N, nH(iH), timeTr, timeTe, accTr *scale, accTe *scale,...
                        Mae* scale, Mape);
            fclose (fid);

            %save regression data
            s = sprintf('%s nSample =%d nH = %d regression.mat', varargin{1}, nSamples(iSamples), nH( iH));
            save( s, 'TY2', 'test');

            elmMae(iSamples, iH)   = scale* mae( test(1, :) - TY21);
            elmRmse(iSamples, iH)  = scale* sqrt( mse( test(1, :) - TY21));


            fid     = fopen('elmPredict.txt','a+');
            fprintf( fid, '%d %d %2.4f %2.4f\n', nSamples( iSamples), nH( iH),  elmMae(iSamples, iH),  elmRmse(iSamples, iH));
            fclose(fid);
        end
end
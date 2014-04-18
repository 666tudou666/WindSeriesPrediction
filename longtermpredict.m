function [pred, cf, error] = longtermpredict(test, F, ahead, NN)
%input:
%test: test data
%F: feature length
%ahead: ahead predict
%NN: Weight of ELM: NN.Wi, NN.Wo, NN.act

%plot, to be predicted
cf = test( F + ahead: end);
d = length( cf);

pred = zeros( d, 1);

for f= 1: d
   feature = test( f+ F-1: -1: f); 
    
   for t = 1: ahead
       % predict one step
       y(t) = computeNN( feature, NN) ;
       feature    = circshift( feature, 1);
       feature( 1) = y(t);
   end
   
   pred(f ) = y( ahead);
end

error = mse( pred, cf);
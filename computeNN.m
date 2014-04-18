function y = computeNN( F, NN)

Wo = NN.Wo ;
Wi = NN.Wi ;

h = Wi* [F ;1]; %bias
a = act( h, NN.act);
y = Wo* a;

end

function a = act( h, fun)

switch fun
case 'sig'
    a = 1./(1 +exp( -h));
end
end
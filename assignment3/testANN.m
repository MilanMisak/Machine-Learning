function [ predictions ] = testANN( net, examples )
%testANN Uses the given neural network to produce a vector of predicted
% labels for the given examples.
    [t] = sim(net, examples);
    predictions = NNout2labels(t);
end
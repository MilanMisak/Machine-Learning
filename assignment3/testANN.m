function [ predictions ] = testANN( net, examples )
%testANN Uses the given neural network to produce a vector of predicted
% labels for the given examples.
    if iscell(net)
        % Passed 6 1-output networks in
        ts = [];
        for i=1:size(net, 2)
            t = sim(net{i}, examples);
            ts = [ts;t];
        end
        predictions = NNout2labels(ts);
    else
        % Passed a 6-output network in
        [t] = sim(net, examples);
        predictions = NNout2labels(t);
    end
end
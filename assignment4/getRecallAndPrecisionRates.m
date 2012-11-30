function [ rates ] = getRecallAndPrecisionRates( confusionMatrix )
%GetRecallAndPrecisionRates Calculates recall and precision rates
% for classes in the given confusion matrix.

rates = zeros(size(confusionMatrix, 1), 2);

for i=1:size(confusionMatrix, 1)
    tp = confusionMatrix(i, i);
    fn = sum(confusionMatrix(i, :)) - tp;
    fp = sum(confusionMatrix(:, i)) - tp;
    
    % Recall rate in %
    if tp + fn > 0
        rates(i, 1) = (tp / (tp + fn)) * 100;
    else
        rates(i, 1) = 0;
    end
    
    % Precision rate in %
    if tp + fp > 0
        rates(i, 2) = (tp / (tp + fp)) * 100;
    else
        rates(i, 2) = 0;
    end
end
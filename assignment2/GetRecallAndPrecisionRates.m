function [ rates ] = GetRecallAndPrecisionRates( confusionMatrix )
%GetRecallAndPrecisionRates Calculates recall and precision rates
% for classes in the given confusion matrix.

rates = zeros(size(confusionMatrix, 1), 2);

for i=1:size(confusionMatrix, 1)
    tp = confusionMatrix(i, i);
    fn = sum(confusionMatrix(i, :)) - tp;
    fp = sum(confusionMatrix(:, i)) - tp;
    
    % Recall rate in %
    rates(i, 1) = (tp / (tp + fn)) * 100;
    
    % Precision rate in %
    rates(i, 2) = (tp / (tp + fp)) * 100;
end
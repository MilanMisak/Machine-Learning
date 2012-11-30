function [ f1Measures ] = getF1Measures( ratesMatrix )
%GetF1Measures Given recall and precision rates matrix returns a matrix
% of F1 measures.

f1Measures = zeros(size(ratesMatrix, 1), 1);

for i=1:size(ratesMatrix, 1)
    f1Measures(i) = (2 * ratesMatrix(i, 1) * ratesMatrix(i, 2)) / (ratesMatrix(i, 1) + ratesMatrix(i, 2));
    if isnan(f1Measures(i))
        f1Measures(i) = 0;
    end
end
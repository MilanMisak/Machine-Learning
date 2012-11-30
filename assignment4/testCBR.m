function [ predictions ] = testCBR( cbr, x2 )
%TESTCBR Summary of this function goes here
%   Detailed explanation goes here

predictions = 1:size(x2,1);

for j=1:size(x2, 1)
    newcase = MakeCase(x2(j,:), 0);
    solvedcase = reuse(retrieve(cbr, newcase), newcase);
    cbr = retain(cbr, solvedcase);

    predictions(j) = solvedcase.solution;
end


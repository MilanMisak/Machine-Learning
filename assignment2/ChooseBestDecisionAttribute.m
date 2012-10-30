function [ bestAttribute ] = ChooseBestDecisionAttribute( examples, attributes, binaryTargets )
%ChooseBestDecisionAttribute Chooses the best attribute based on
%information gain

bestAttribute = attributes(1)
highestInformationGain = -Inf;

for attribute=attributes
    p0 = 0;
    p1 = 0;
    n0 = 0;
    n1 = 0;
    
    % Calculate the number of positive and negative examples
    for i=1:size(examples, 1)
        exampleIsPositive = binaryTargets(i) == 1;
        if examples(i, attribute) == 0
            if exampleIsPositive
                p0 = p0 + 1;
            else
                n0 = n0 + 1;
            end
        else
            if exampleIsPositive
                p1 = p1 + 1;
            else
                n1 = n1 + 1;
            end
        end
    end
    
    fprintf(1, 'p0: %i, p1: %i, n0: %i, n1: %i\n', p0, p1, n0, n1);
    gain = I(p0 + p1, n0 + n1) - Remainder(p0, p1, n0, n1);
    
    % Update bestAttribute if suitable
    if gain > highestInformationGain
        bestAttribute = attribute;
        highestInformationGain = gain;
    end
end

function [ i ] = I( p, n )
%I Calculates I(p,n)
    all = p + n;
    i = - (p / all) * log2(p / all) - (n / all) * log2(n / all);

function [ remainder ] = Remainder( p0, p1, n0, n1 )
%Remainder Calculates remainder of an attribute
    all = p0 + p1 + n0 + n1;
    remainder = ((p0 + n0) / all) * I(p0, n0) + ((p1 + n1) / all) * I(p1, n1);
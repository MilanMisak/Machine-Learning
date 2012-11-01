function [ errorEstimate ] = CrossValidate( examples, labels )
%CrossValidate uses 10-fold validation to estimate the error rate of the 6
%trees created from training the examples

errorEstimate = 0;
first = 1;
last = 0;

targets = cell(6);
for i=1:6
    targets{i} = zeros(size(labels));
    for j=1:size(labels)
        targets{i}(j) = labels(j) == i;
    end
end

for i=1:10
    % first will mark the index of the start of the fold, and last the end
    first = last + 1;
    last = round(size(examples, 1) / i);
    foldSize = last - first;
    
    % split the examples from the fold
    newExamples = examples(~ismember(1:size(examples, 1), (first:last)), :);
    newTestSet = examples(ismember(1:size(examples, 1), [first:last]), :);
    
    % create the 6 trees for the fold, and classify the test set for each
    trees = cell(6);
    classifications = cell(6);
    correctClassifications = cell(6);
    for n=1:6
        examplesTargets = targets{n}(~ismember(1:size(targets{n}, 2), (first:last)), :);
        testSetTargets = targets{n}(ismember(1:size(targets{n}, 2), (first:last)), :);
        
        % train a tree on the examples
        trees{n} = DecisionTreeLearning(newExamples, attributes, examplesTargets);
        
        % classify the test set for the tree
        classifications{n} = treeMultiClassify(trees{n}, newTestSet);
        
        % compare to actual results
        for m=1:size(testSetTargets)
            if classifications{n}(m)==testSetTargets(m)
                correctClassifications(n) = correctClassifications(n) + 1;
            end
        end
        
        errorEstimate = errorEstimate + (1 - (correctClassifications(n) / size(classifications, 2)));
    end
end

errorEstimate = errorEstimate / 10;


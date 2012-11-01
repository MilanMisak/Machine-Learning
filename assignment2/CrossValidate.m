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
    
    % split the examples from the fold
    trainingSet = examples(~ismember(1:size(examples, 1), (first:last)), :);
    testSet = examples(ismember(1:size(examples, 1), (first:last)), :);
    testSetLabels = labels(ismember(1:size(labels, 1), (first:last)), :);
    
    % create the 6 trees for the fold, and classify the test set for each
    trees = cell(6);
    for n=1:6
        trainingSetTargets = targets{n}(~ismember(1:size(targets{n}, 1), (first:last)), :);
        
        % train a tree on the examples
        trees{n} = DecisionTreeLearning(trainingSet, 1:1:45, trainingSetTargets);
        trees{n}
    end
    trees

    x2.x = testSet;
    predictions = TestTrees(trees, x2)

    % compare to actual results
    correct = 0;
    for m=1:size(testSetLabels)
        if predictions.y(m) == testSetLabels(m)
            correct = correct + 1;
        end
    end
        
    errorEstimate = errorEstimate + (1 - (correct / size(classifications, 2)));
end

errorEstimate = errorEstimate / 10;


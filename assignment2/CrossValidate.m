function [ errorEstimate ] = CrossValidate( examples, labels )
%CrossValidate uses 10-fold validation to estimate the error rate of the 6
%trees created from training the examples

errorEstimate = 0;
first = 0;
last = 0;

targets = cell(6);
for i=1:6
    targets{i} = zeros(size(labels));
    for j=1:size(labels)
        targets{i}(j) = labels(j) == i;
    end
end

confusionMatrix = zeros(6);

for i=1:10
    % first will mark the index of the start of the fold, and last the end
    first = last + 1;
    last = round(size(examples, 1)*i / 10);
    
    % split the examples from the fold
    trainingSet = examples(~ismember(1:size(examples, 1), [first:last]), :);
    testSet = examples(ismember(1:size(examples, 1), [first:last]), :);
    testSetLabels = labels(ismember(1:size(labels, 1), [first:last]), :);
    
    % create the 6 trees for the fold, and classify the test set for each
    trees = cell(1, 6);
    for n=1:6
        trainingSetTargets = targets{n}(~ismember(1:size(targets{n}, 1), [first:last]), :);
        
        % train a tree on the examples
        trees{n} = DecisionTreeLearning(trainingSet, 1:1:45, trainingSetTargets);
    end

    x2.x = testSet;
    predictions = TestTrees(trees, x2);
    
    % compare to actual results and generate confusion matrix
    correct = 0;
    
    for m=1:size(testSetLabels)
        %fprintf('%i %i\n', predictions.y(m), testSetLabels(m));
        predictedLabel = predictions.y(m);
        actualLabel = testSetLabels(m);

        if predictedLabel == actualLabel
            correct = correct + 1;
        end
        
        confusionMatrix(actualLabel, predictedLabel) = confusionMatrix(actualLabel, predictedLabel) + 1;
    end
    
    errorEstimate = errorEstimate + (1 - (correct / size(testSetLabels, 1)));
end

confusionMatrix = confusionMatrix / 10;
confusionMatrix

recallAndPrecisionRates = GetRecallAndPrecisionRates(confusionMatrix)
GetF1Measures(recallAndPrecisionRates)

errorEstimate = errorEstimate / 10;


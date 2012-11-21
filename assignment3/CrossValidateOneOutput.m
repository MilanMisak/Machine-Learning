function [ classificationRate ] = CrossValidateOneOutput( examples, labels )
%CrossValidate uses 10-fold validation to estimate the error rate of the 6
% neural networks trained using the examples.

classificationRate = 0;
last = 0;

confusionMatrix = zeros(6);

networkLayerNodes = [20 11; 19 5; 12 11; 13 12; 13 5; 11 6];

for i=1:10
    % first will mark the index of the start of the fold, and last the end
    first = last + 1;
    last = round(size(examples, 2)*i / 10);

    % split the examples from the fold
    trainingInputs = examples(:, ~ismember(1:size(examples, 2), [first:last]));
    trainingTargets = labels(:, ~ismember(1:size(labels, 2), [first:last]));
    validationInputs = examples(:, ismember(1:size(examples, 2), [first:last]));
    validationTargets = labels(:, ismember(1:size(labels, 2), [first:last]));

    % create the 6 networks for the fold
    nets = cell(1, 6);

    for n=1:6
        trainingTargetsForEmotion = trainingTargets(n, :);
        
        nets{n} = trainNet(trainingInputs, trainingTargetsForEmotion, networkLayerNodes(n, :));
    end
    
    predictions = testANN(nets, validationInputs);

    % compare to actual results and generate confusion matrix
    correct = 0;
    foldConfusionMatrix = zeros(6);

    for m=1:size(validationTargets, 2)
        predictedLabel = predictions(m);
        nonZeroValues = find(validationTargets(:, m));
        actualLabel = nonZeroValues(1);

        if predictedLabel == actualLabel
            correct = correct + 1;
        end

        confusionMatrix(actualLabel, predictedLabel) = confusionMatrix(actualLabel, predictedLabel) + 1;
        foldConfusionMatrix(actualLabel, predictedLabel) = foldConfusionMatrix(actualLabel, predictedLabel) + 1;
    end

    % report fold F1 measure
    fprintf('Fold %i\n:', i)
    foldRecallAndPrecisionRates = getRecallAndPrecisionRates(foldConfusionMatrix);
    foldF1Measures = getF1Measures(foldRecallAndPrecisionRates)

    classificationRate = classificationRate + (correct / size(validationTargets, 2));
end

fprintf('1-output:\n')
confusionMatrix = confusionMatrix / 10

recallAndPrecisionRates = getRecallAndPrecisionRates(confusionMatrix)
f1Measures = getF1Measures(recallAndPrecisionRates)

classificationRate = classificationRate / 10
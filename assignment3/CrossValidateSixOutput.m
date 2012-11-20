function [ classificationRate ] = CrossValidateSixOutput( examples, labels )
%CrossValidate uses 10-fold validation to estimate the error rate of a
% 6-output neural network trained using the examples.

classificationRate = 0;
last = 0;

confusionMatrix = zeros(6);

for i=1:10
    % first will mark the index of the start of the fold, and last the end
    first = last + 1;
    last = round(size(examples, 2)*i / 10);

    % split the examples from the fold
    trainingInputs = examples(:, ~ismember(1:size(examples, 2), [first:last]));
    trainingTargets = labels(:, ~ismember(1:size(labels, 2), [first:last]));
    validationInputs = examples(:, ismember(1:size(examples, 2), [first:last]));
    validationTargets = labels(:, ismember(1:size(labels, 2), [first:last]));

    net = trainNet(trainingInputs, trainingTargets, [13 7]);

    predictions = testANN(net, validationInputs);

    % compare to actual results and generate confusion matrix
    correct = 0;

    for m=1:size(validationTargets, 2)
        predictedLabel = predictions(m);
        nonZeroValues = find(validationTargets(:, m));
        actualLabel = nonZeroValues(1);

        if predictedLabel == actualLabel
            correct = correct + 1;
        end

        confusionMatrix(actualLabel, predictedLabel) = confusionMatrix(actualLabel, predictedLabel) + 1;
    end

    classificationRate = classificationRate + (correct / size(validationTargets, 2));
end

confusionMatrix = confusionMatrix / 10

recallAndPrecisionRates = getRecallAndPrecisionRates(confusionMatrix)
f1Measures = getF1Measures(recallAndPrecisionRates)

classificationRate = classificationRate / 10
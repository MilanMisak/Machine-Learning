function [ classificationRate ] = CrossValidateSixOutput( examples, labels )
%CrossValidate uses 10-fold validation to estimate the error rate of the 6
%trees created from training the examples

classificationRate = 0;
last = 0;

confusionMatrix = zeros(6);

for i=1:10
    % first will mark the index of the start of the fold, and last the end
    first = last + 1;
    last = round(size(examples, 2)*i / 10);

    % split the examples from the fold
    testInputs  = examples(:, first:last);
    testTargets = labels(:, first:last);
    validationInputs  = examples(:, first:last);
    validationTargets = labels(:, first:last);

    predictions = cell(size(validationTargets,1), size(validationTargets,2));

    [net] = feedforwardnet([15,20], 'traingdx');
    [net] = configure(net, testInputs, testTargets);
    %net.layers{1}.transferFcn = '';
    %net.layers{2}.transferFcn = '';
    net.trainParam.mc = 0.95;
    net.trainParam.epochs = 1000;
    net.trainParam.lr = 0.015;
    [net, tr] = train(net, testInputs, testTargets);
    simulation = sim(net, testInputs);

    predictions = testANN(net, validationInputs);
    %fprintf('Best performance: %f\n', trs{i}.best_perf);

    % compare to actual results and generate confusion matrix
    correct = 0;

    for m=1:size(predictions,2)
        predictedLabel = predictions(:,m);
        actualLabel = validationTargets(:,m);

        if predictedLabel == actualLabel
            correct = correct + 1;
        end

        confusionMatrix(actualLabel, predictedLabel) = confusionMatrix(actualLabel, predictedLabel    ) + 1;
    end

    classificationRate = classificationRate + (correct / size(testSetLabels, 1));
end

confusionMatrix = confusionMatrix / 10

recallAndPrecisionRates = GetRecallAndPrecisionRates(confusionMatrix)
f1Measures = GetF1Measures(recallAndPrecisionRates)

classificationRate = classificationRate / 10




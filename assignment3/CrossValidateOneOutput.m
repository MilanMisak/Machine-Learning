function [ classificationRate ] = CrossValidateOneOutput( examples, labels )
%CrossValidate uses 10-fold validation to estimate the error rate of the 6
%neural networks trained using the examples.

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
    %trainingInputs  = examples(:, first:last);
    %trainingTargets = labels(:, first:last);
    validationInputs = examples(:, ismember(1:size(examples, 2), [first:last]));
    validationTargets = labels(:, ismember(1:size(examples, 2), [first:last]));
    %validationInputs  = examples(:, first:last);
    %validationTargets = labels(:, first:last);

    % create the 6 networks for the fold
    nets = cell(1, 6);
    trs = cell(1, 6);

    for n=1:6
        trainingTargetsForEmotion = trainingTargets(n, :);
        
        [nets{n}] = feedforwardnet([15,20], 'traingdx');
        [nets{n}] = configure(nets{n}, trainingInputs, trainingTargetsForEmotion);
        
        % TODO - this stuff is a bit arbitrary
        %nets{i}.layers{1}.transferFcn = '';
        %nets{i}.layers{2}.transferFcn = '';
        nets{n}.trainParam.mc = 0.95;
        nets{n}.trainParam.epochs = 1000;
        nets{n}.trainParam.lr = 0.015;
        nets{n}.trainParam.showWindow = 0;
        
        [nets{n}, trs{i}] = train(nets{n}, trainingInputs, trainingTargetsForEmotion);
    end
    
    predictions = testANN(nets, validationInputs);

    % compare to actual results and generate confusion matrix
    correct = 0;
    
    for m=1:size(validationTargets, 1)
        predictedLabel = predictions(m);
        nonZeroValues = find(validationTargets(:, m));
        actualLabel = validationTargets(nonZeroValues(1), m);

        if predictedLabel == actualLabel
            correct = correct + 1;
        end
        fprintf('%i, %i %i\n', i, predictedLabel, actualLabel)

        confusionMatrix(actualLabel, predictedLabel) = confusionMatrix(actualLabel, predictedLabel) + 1;
    end

    classificationRate = classificationRate + (correct / size(validationTargets, 1));
end

confusionMatrix = confusionMatrix / 10

recallAndPrecisionRates = getRecallAndPrecisionRates(confusionMatrix)
f1Measures = getF1Measures(recallAndPrecisionRates)

classificationRate = classificationRate / 10


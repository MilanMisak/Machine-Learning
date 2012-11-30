function [ classificationRate ] = CrossValidate( examples, labels )
%CrossValidate uses 10-fold validation to estimate the error rate of the
%CBR created from training the examples

classificationRate = 0;
last = 0;

confusionMatrix = zeros(6);

for i=1:10
    % first will mark the index of the start of the fold, and last the end
    first = last + 1;
    last = round(size(examples, 2)*i / 10);

    % split the examples from the fold
    trainingInputs = examples(~ismember(1:size(examples, 1), [first:last]), :);
    trainingTargets = labels(~ismember(1:size(labels, 1), [first:last]), :);
    validationInputs = examples(ismember(1:size(examples, 1), [first:last]), :);
    validationTargets = labels(ismember(1:size(labels, 1), [first:last]), :);

    cbr = CBRInit(trainingInputs, trainingTargets);

    correct = 0;
    foldConfusionMatrix = zeros(6);
    
    for j=1:size(validationTargets, 1)
        newcase = MakeCase(validationInputs(j,:), 0);
        solvedcase = reuse(retrieve(cbr, newcase), newcase);
        cbr = retain(cbr, solvedcase);
        
        %predictedLabel = predictions(j);
        %nonZeroValues = find(validationTargets(:, j));
        %actualLabel = nonZeroValues(1);
        
        predictedLabel = solvedcase.solution;% = [predictions solvedcase.solution];
        actualLabel = validationTargets(j);
        
        if predictedLabel == actualLabel
            correct = correct + 1;
        end

        confusionMatrix(actualLabel, predictedLabel) = confusionMatrix(actualLabel, predictedLabel) + 1;
        foldConfusionMatrix(actualLabel, predictedLabel) = foldConfusionMatrix(actualLabel, predictedLabel) + 1;
    end

    % report fold F1 measure
    fprintf('Fold %i\n:', i)
    foldRecallAndPrecisionRates = getRecallAndPrecisionRates(foldConfusionMatrix);
    foldF1Measures = mean(getF1Measures(foldRecallAndPrecisionRates))

    classificationRate = classificationRate + (correct / size(validationTargets, 2));
end

fprintf('6-output:\n')
confusionMatrix = confusionMatrix / 10

recallAndPrecisionRates = getRecallAndPrecisionRates(confusionMatrix)
f1Measures = getF1Measures(recallAndPrecisionRates)

classificationRate = classificationRate / 10

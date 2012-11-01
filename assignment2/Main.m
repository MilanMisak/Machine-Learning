cleandata = load('cleandata_students.mat');


CrossValidate(cleandata.x, cleandata.y)

% Create the 6 target vectors
targets = cell(6);
for i=1:6
    targets{i} = zeros(size(cleandata.y));
    for j=1:size(cleandata.y)
        targets{i}(j) = cleandata.y(j) == i;
    end
end

% Train and draw a tree for each emotion
trees = cell(1, 6);
for i=1:6
    targetVector = targets{i}(1:size(targets{i}, 1));
    trees{i} = DecisionTreeLearning(cleandata.x, 1:1:45, targetVector);
    DrawDecisionTree(trees{i});
end
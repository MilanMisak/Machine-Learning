function [ predictions ] = TestTrees( T, x2 )
%TestTrees predicts output of examples, given the 6 trained trees, T

examples = x2.x;
labels = ones(size(examples, 1));

exampleIndex = 1;
for example=examples
    classifications = cell(0);
    treeIndex = 1;
    for tree=T
        if treeClassify(example, tree)
           classifications{size(classifications) + 1} = treeIndex; 
        end
        treeIndex = treeIndex + 1;
    end

    classifications
    
    if size(classifications) == 0
        fprintf('No classifications');
        % Label defaults to 1
    else
        % Select classification at random
        labels(exampleIndex) = classifications{randi(size(classifications))};
    end
end

predictions.x = examples;
predictions.y = labels;


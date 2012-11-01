function [ predictions ] = TestTrees( T, x2 )
%TestTrees predicts output of examples, given the 6 trained trees, T

examples = x2.x;
labels = zeros(1, size(examples, 1));
%T

for j=1:size(examples, 1)
    classifications = cell(0);
    for i=1:6
        if logical(TreeClassify(T{i}, examples(j, :)))
           classifications{size(classifications, 1) + 1} = i;
        end
    end
    
    if size(classifications, 1) == 0
        labels(j) = randi(6);
    else
        % Select classification at random
        labels(j) = classifications{randi(size(classifications, 1))};
    end
end

predictions.x = examples;
predictions.y = labels;


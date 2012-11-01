function [ classification ] = TreeClassify( tree, example )
%TreeClassify will traverse a tree, and classify the example as 1 or 0

if isempty(tree.kids)
    classification = tree.class;
else
    if example(tree.op) == 0
        kid = tree.kids{1};
        classification = TreeClassify(kid, example);
    else
        kid = tree.kids{2};
        classification = TreeClassify(kid, example);
    end
end
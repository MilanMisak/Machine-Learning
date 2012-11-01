function [ classification ] = TreeClassify( tree, example )
%TreeClassify will traverse a tree, and classify the example as 1 or 0
tree
if isempty(tree.op)
    classification = tree.class;
else
    if example(tree.op) == 0
        classification = TreeClassify(tree.kids(0), example);
    else
        classification = TreeClassify(tree.kids(1), example);
    end
end
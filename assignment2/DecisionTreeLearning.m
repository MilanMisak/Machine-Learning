function [ tree ] = DecisionTreeLearning( examples, attributes, binaryTargets )
%DecisionTreeLearning Trains a decision tree using given examples

if range(binaryTargets) == 0
    % All binary targets are the same
    tree.kids = cell(0);
    tree.class = binaryTargets(1);
    fprintf('HAI (%i, %i)\n', binaryTargets(1), size(binaryTargets, 1));
elseif isempty(attributes)
    % There are no attributes to split the tree on
    tree.kids = cell(0);
    tree.class = MajorityValue(binaryTargets);
else
    bestAttribute = ChooseBestDecisionAttribute(examples, attributes, binaryTargets);
    bestAttributeIndex = 0;

    for i=1:size(attributes, 2)
       if attributes(i) == bestAttribute
           bestAttributeIndex = i;
       end
    end
    
    kids = cell(0);
    
    for u=0:1
        newExamples = [];
        newBinaryTargets = [];
        
        for i=1:size(examples, 1)
            if examples(i, bestAttributeIndex) == u
               % bestAttribute of an example at index i equal to u
               example = examples(i, :);
               binaryTarget = binaryTargets(i);
               
               % Build up new examples and binaryTargets
               newExamples = [newExamples; example];
               newBinaryTargets = [newBinaryTargets; binaryTarget];
            end
        end
        
        if isempty(newExamples)
            tree.kids = cell(0);
            tree.class = MajorityValue(binaryTargets);
            return
        else
            attributes(find(attributes ~= bestAttribute));
            kid = DecisionTreeLearning(newExamples, attributes(find(attributes ~= bestAttribute)), newBinaryTargets);            
            kids{size(kids, 1) + 1} = kid;
        end
    end
    
    % New tree with bestAttribute as its root
    tree.op = bestAttribute;
    tree.kids = kids;
end

function [ majorityValue ] = MajorityValue( values )
majorityValue = mode(values);
    
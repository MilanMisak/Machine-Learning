function [ tree ] = DecisionTreeLearning( examples, attributes, binaryTargets)
%DecisionTreeLearning Trains a decision tree using given examples

if range(binaryTargets) == 0
    % All binary targets are the same
    tree.kids = [];
    tree.class = binaryTargets(1);
elseif isempty(attributes)
    % There are no attributes to split the tree on
    tree.kids = [];
    tree.class = MajorityValue(binaryTargets);
else
    bestAttribute = ChooseBestDecisionAttribute(examples, attributes, binaryTargets);
    bestAttributeIndex = 0;
    for i=1:size(attributes)
       if attributes(i) == bestAttribute
           bestAttributeIndex = i;
       end
    end
    
    kids = [];
    
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
            tree.kids = [];
            tree.class = MajorityValue(binaryTargets);
            return
        else
            attributes(find(attributes ~= bestAttribute));
            kid = DecisionTreeLearning(newExamples, attributes(find(attributes ~= bestAttribute)), newBinaryTargets);
            kids = [kids; kid];
        end
    end
    
    % New tree with bestAttribute as its root
    tree.op = bestAttribute;
    tree.kids = kids;
end

function [ majorityValue ] = MajorityValue( values )
majorityValue = mode(values)
    
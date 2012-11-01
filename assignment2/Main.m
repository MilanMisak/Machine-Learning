cleandata = load('cleandata_students.mat');


%Create the 6 target vectors
%targets = cell(6);
%for i=1:6
%    targets{i} = zeros(size(cleandata.y));
%    for j=1:size(cleandata.y)
%        targets{i}(j) = cleandata.y(j) == i;
%    end
%end

%attributes = 1:1:45;
%S = DecisionTreeLearning(cleandata.x, attributes, targets{1}); 
%DrawDecisionTree(S)

CrossValidate(cleandata.x, cleandata.y)



            

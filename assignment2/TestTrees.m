function [ predictions ] = TestTrees( T, x2 )
%TestTrees predicts output of examples, given the 6 trained trees, T

examples = x2.x;
labels = zeros(1, size(examples, 1));

%Work out the number of occurences of each label in the test data
occurences = zeros(1, 6);
for i=1:6
    for j=1:size(x2.y)
        if (x2.y(j) == i)
            occurences(i) = occurences(i) + 1;
        end
    end
end

%Order labels by priority based on their occurence in the test data
guessPriorities = zeros(1, 6);
for i=1:6
    [C, I] = max(occurences);
    guessPriorities(i) = I;
    occurences(I) = 0;
end

guessPriorities2 = zeros(1, 6);
guessPriorities3 = zeros(1, 6);

score = zeros(1, 6);

for j=1:size(examples, 1)
    classifications = [];
    for i=1:6
        if logical(TreeClassify(T{i}, examples(j, :)))
           classifications(size(classifications, 1) + 1) = i;
           occurences(i) = occurences(i) + 1;
        end
    end
    
    if size(classifications, 1) == 0
        %Select the most common label
        tempOccurences = occurences;
        for i=1:6
            [C, I] = max(tempOccurences);
            guessPriorities2(i) = I;
            tempOccurences(I) = 0;
        end
    
        labels(j) = randi(6);
    else
       
        %Order priorities of the labels encountered so far
        tempOccurences = occurences;
        for i=1:6
            [C, I] = max(tempOccurences);
            guessPriorities2(i) = I;
            tempOccurences(I) = 0;
        end
      
        %Choose the most trustworthy tree
        for i=1:size(classifications)
            if ~isempty(find(classifications == guessPriorities3(1:i)))
                [C, I] = find(classifications == guessPriorities3(1:i));
                labels(j) = classifications(I);
                break;
            end
        end

        %If no label could be chosen, pick one at random
        if (labels(j) == 0)
            % Select classification at random
            labels(j) = classifications(randi(size(classifications, 1)));
        end


        label = labels(j);
        if(labels(j) == x2.y(j))
            score(label) = score(label) + 1;
        else
            score(label) = score(label) - 1;
        end

        tempScores = score;
        for i=1:6
            [C, I] = max(tempScores);
            guessPriorities3(i) = I;
            tempScores(I) = 0;
        end
         
        %Select most common label
        %for i=1:size(classifications)
        %   if ~isempty(find(classifications == guessPriorities(1:i)))
        %        [C, I] = find(classifications == guessPriorities(1:i));
        %        labels(j) = classifications(I);
        %        break;
        %        fprintf('MOOOO')
        %    end
        %end
        
        % Select classification at random
        %labels(j) = classifications(randi(size(classifications, 1)));
    end
end

predictions.x = examples;
predictions.y = labels;


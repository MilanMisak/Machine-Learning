
function [ cbr ]  = CBRInit( x, y )

    %Create categories
    cbr.categories = cell(6);
    for i=1:6
        cbr.categories{i} = MakeCategory(i);
    end

    %Insert all cases
    for i=1:size(x, 1)  
        problem = x(i, :);
        solution = y(i);
        
        noOfCases = cbr.categories{solution}.noOfCases;
        cbr.categories{solution}.noOfCases = noOfCases + 1;
        
        acc = cbr.categories{solution}.averageBinaryProblem;
        cbr.categories{solution}.averageBinaryProblem = acc + problem;
    end
    
    for i=1:6
        binaryProblem = cbr.categories{i}.averageBinaryProblem;
        noOfCases = cbr.categories{i}.noOfCases;
        average = binaryProblem / noOfCases;
        cbr.categories{i}.averageBinaryProblem = average;
        cbr.categories{i}.averageAUProblem = CreateAUVector(average);
    end
end

function [ category ] = MakeCategory( index )
    category.noOfCases = 0;
    category.solution = index;
    category.averageBinaryProblem = zeros(1, 45);
end


function [ cbr ] = OldCBRInit( x, y )
%CBRInit initialises a CBR system given a matrix of examples x and a vector
% of labels y.
    % TODO
    cbr.cases = {};
    cbr.cases{1} = MakeCase(x(1, :), y(1));
    
    for i=2:size(x, 1)
        auvector = CreateAUVector(x(i, :));
        existingcase = ExistsInCellArray(cbr.cases, auvector);
        if existingcase == -1
            cbr.cases{i} = MakeCase(x(i, :), y(i));
        else
            cbr.cases{existingcase}.typicality = cbr.cases{existingcase}.typicality + 1;
        end
    end
end




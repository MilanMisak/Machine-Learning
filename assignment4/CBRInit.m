function [ cbr ] = CBRInit( x, y )
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

function [ cbr ]  = OtherCBRInit( x, y )

    %Create categories
    cbr.categories = cell(6);
    for i=1:6
        cbr.categories{i} = MakeCategory(i);
    end

    %Insert all cases
    exists = false;
    for i=1:size(x, 1)
        auvector = CreateAUVector(x(i, :));
        
        for i=1:6
            existingcase = ExistsInCellArray(cbr.categories{i}.cases, auvector);
            if existingcase > -1
                foundcase = cbr.categories{i}.cases{existingcase};
                foundcase.typicality = foundcase.typicality + 1;
                exists = true;
                break;
            end
        end

        if ~exists
            new_case = MakeCase(x(i, :), y(i));
            cases = cbr.categories{new_case.solution}.cases;
            cases{size{cases} + 1} = new_case;
        else
            exists = false;
        end
    end

    %TODO - Append averages to each category

end

function [ category ] = MakeCategory( index )
    category.solution = index;
    category.cases = {};
end

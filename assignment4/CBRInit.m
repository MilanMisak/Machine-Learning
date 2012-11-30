function [ cbr ] = CBRInit( x, y )
%CBRInit initialises a CBR system given a matrix of examples x and a vector
% of labels y.
    % TODO
    cbr.cases = {};
    cbr.cases{1} = MakeCase(x(1, :), y(1));
    
    for i=2:size(x, 1)
        %x(i, :)
        existingcase = ExistsInCellArray(cbr.cases, x(i, :));
        if existingcase == -1
            cbr.cases{i} = MakeCase(x(i, :), y(i));
        else
            fprintf('exists\n')
            cbr.cases{existingcase}.typicality = cbr.cases{existingcase}.typicality + 1;
        end
    end
end


function [ exists ] = ExistsInCellArray( cellarray, attributevector )
    auvector = [];
    for i=1:size(attributevector, 2)
        if attributevector(1, i) == 1
            auvector = [auvector; i];
        end
    end
    
    for j=1:size(cellarray, 1)
        problem = cellarray{j}.problem;
        if size(problem, 1) == size(auvector, 1)
            if problem == auvector
                exists = j;
                return;
            end
        end
    end
    
    exists = -1;
end
function [ cbr ] = CBRInit( x, y )
%CBRInit initialises a CBR system given a matrix of examples x and a vector
% of labels y.
    % TODO
    cbr.cases = {};
    for i=1:size(x, 1)
        existingcase = ExistsInCellArray(cbr.cases, x(i, :));
        if existingcase == -1
            cbr.cases{i} = MakeCase(x(i, :), y(i));
        else
            cbr.cases{existingcase}.typicality = cbr.cases{existingcase}.typicality + 1;
        end
    end
end


function [ exists ] = ExistsInCellArray( cellarray, attributevector )
    
    if size(cellarray, 1)==0
        exists = -1;
        return;
    end

    auvector = [];
    for i=1:size(attributevector, 2)
        if attributevector[i] == 1
            auvector = auvector + [i];
        end
    end
    
    for j=1:size(cellarray, 1)
        if cellarray(j).problem==auvector
            exists = j;
            return;
        end
    end
    
    exists = -1;
    return;
end
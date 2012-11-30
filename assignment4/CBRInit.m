function [ cbr ] = CBRInit( x, y )
%CBRInit initialises a CBR system given a matrix of examples x and a vector
% of labels y.
    % TODO
    cbr.cases = {};
    cbr.cases{1} = MakeCase(x(1, :), y(1));
    
    for i=2:size(x, 1)
        existingcase = ExistsInCellArray(cbr.cases, x(i, :));
        if existingcase == -1
            cbr.cases{i} = MakeCase(x(i, :), y(i));
        else
            cbr.cases{existingcase}.typicality = cbr.cases{existingcase}.typicality + 1;
        end
    end
end
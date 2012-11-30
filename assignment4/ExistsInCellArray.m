function [ exists ] = ExistsInCellArray( cellarray, attributevector )
% TODO
    auvector = CreateAUVector(attributevector);
    
    for j=1:size(cellarray, 1)
        problem = cellarray{j}.problem;
        if size(problem, 2) == size(auvector, 2)
            if problem == auvector
                exists = j;
                return;
            end
        end
    end
    
    exists = -1;
end
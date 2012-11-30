function [ newcbr ] = retain( cbr, solvedcase )
%retain updates cbr by storing solvedcase and returns a new CBR system.
    %TODO
    cbrsize = size(cbr, 1)
    existingcase = ExistsInCellArray(cbr.cases, solvedcase.problem);
    if existingcase == -1
        cbr.cases{cbrsize+1} = solvedcase;
    else
        cbr.cases{existingcase}.typicality = cbr.cases{existingcase}.typicality + 1;
    end
    newcbr = cbr;
end

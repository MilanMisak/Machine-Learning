function [ newcbr ] = retain( cbr, solvedcase )
%retain updates cbr by storing solvedcase and returns a new CBR system.
    solution = solvedcase.solution;
    problem = solvedcase.problem;
    weight = 0.5;
    
    average = cbr.categories{solution}.averageBinaryProblem;
    
    noOfCases = cbr.categories{solution}.noOfCases + 1;
    cbr.categories{solution}.noOfCases = noOfCases;
    average = average + ((problem / noOfCases) * weight);
    
    cbr.categories{solution}.averageBinaryProblem = average;
    cbr.categories{solution}.averageAUProblem = CreateAUVector(round(average));
    
    newcbr = cbr;
end


function [ newcbr ] = OldRetain( cbr, solvedcase )
%retain updates cbr by storing solvedcase and returns a new CBR system.
    existingcase = ExistsInCellArray(cbr.cases, solvedcase.problem);
    if existingcase == -1
        cbr.categories{solution}.cases{size(cbr, 1) + 1} = solvedcase;
    else
        cbr.cases{existingcase}.typicality = cbr.cases{existingcase}.typicality + 1;
    end
    newcbr = cbr;
end
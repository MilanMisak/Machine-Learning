function [ solvedcase ] = reuse( matchingcase, newcase )
% reuse returns a result of attaching the solution of case to newcase.
    newcase.solution = matchingcase.solution;
    newcase.weight = 0.8;
    solvedcase = newcase;
end
function [ outputcase ] = MakeCase( inputvector, scalarlabel )
%MakeCase makes a case from these input vector and scalar label.
    auvector = CreateAUVector(inputvector);

    outputcase.problem = auvector;
    outputcase.binaryproblem = inputvector;
    outputcase.solution = scalarlabel;
    outputcase.typicality = 1;
    outputcase.weight = 1;
end
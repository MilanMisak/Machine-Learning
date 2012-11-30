function [ outputcase ] = MakeCase( inputvector, scalarlabel )
%MakeCase makes a case from these input vector and scalar label.
    auvector = CreateAUVector(inputvector);

    outputcase = struct('problem', auvector, 'solution', scalarlabel, 'typicality', 1);
end
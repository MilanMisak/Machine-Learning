function [ outputcase ] = MakeCase( inputvector, scalarlabel )
%MakeCase TODO: makes a case from these input things
    auvector = [];
    for i=1:size(inputvector, 2)
        if inputvector[i] == 1
            auvector = auvector + [i];
        end
    end
    outputcase = struct('problem', auvector, 'solution', scalarlabel, 'typicality', 1);
end

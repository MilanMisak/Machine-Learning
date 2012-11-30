function [ outputcase ] = MakeCase( inputvector, scalarlabel )
%MakeCase makes a case from these input vector and scalar label.
    auvector = [];

    for i=1:size(inputvector, 2)
        if inputvector(1, i) == 1
            auvector = [auvector; i];
        end
    end

    outputcase = struct('problem', auvector, 'solution', scalarlabel, 'typicality', 1);
end